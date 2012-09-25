Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Sep 2012 11:57:14 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org
Subject: Re: [RFCv1 03/20] Bluetooth: Add L2CAP create channel request
 handling
In-Reply-To: <20120925113828.GG2509@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1209251155430.2455@mathewm-linux>
References: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org> <1347387691-5285-4-git-send-email-mathewm@codeaurora.org> <20120925113828.GG2509@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Andrei -

On Tue, 25 Sep 2012, Andrei Emeltchenko wrote:

> Hi Mat,
>
> On Tue, Sep 11, 2012 at 11:21:14AM -0700, Mat Martineau wrote:
>> The L2CAP create channel request is very similar to an L2CAP connect
>> request, but it has an additional parameter for the controller ID.  If
>> the controller id is 0, the channel is set up on the BR/EDR controller
>> (just like a connect request).  Using a valid high speed controller ID
>> will cause the channel to be initially created on that high speed
>> controller.  While the L2CAP data will be initially routed over the
>> AMP controller, the L2CAP fixed signaling channel only uses BR/EDR.
>>
>> When a create channel request is received for a high speed controller,
>> a pending response is always sent first.  After the high speed
>> physical and logical links are complete a success response will be
>> sent.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  net/bluetooth/l2cap_core.c | 70 +++++++++++++++++++++++++++++++++++-----------
>>  1 file changed, 54 insertions(+), 16 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 166382c..17e02d9 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -3362,8 +3362,9 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn, struct l2cap_cmd_hd
>>  	return 0;
>>  }
>>
>> -static void __l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
>> -			    u8 *data, u8 rsp_code, u8 amp_id)
>> +static struct l2cap_chan *__l2cap_connect(struct l2cap_conn *conn,
>> +					  struct l2cap_cmd_hdr *cmd,
>> +					  u8 *data, u8 rsp_code, u8 amp_id)
>>  {
>>  	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
>>  	struct l2cap_conn_rsp rsp;
>> @@ -3390,7 +3391,7 @@ static void __l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
>>
>>  	/* Check if the ACL is secure enough (if not SDP) */
>>  	if (psm != __constant_cpu_to_le16(L2CAP_PSM_SDP) &&
>> -				!hci_conn_check_link_mode(conn->hcon)) {
>> +	    !hci_conn_check_link_mode(conn->hcon)) {
>>  		conn->disc_reason = HCI_ERROR_AUTH_FAILURE;
>>  		result = L2CAP_CR_SEC_BLOCK;
>>  		goto response;
>> @@ -3414,6 +3415,7 @@ static void __l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
>>  	bacpy(&bt_sk(sk)->dst, conn->dst);
>>  	chan->psm  = psm;
>>  	chan->dcid = scid;
>> +	chan->local_amp_id = amp_id;
>>
>>  	bt_accept_enqueue(parent, sk);
>>
>> @@ -3433,8 +3435,16 @@ static void __l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
>>  				status = L2CAP_CS_AUTHOR_PEND;
>>  				parent->sk_data_ready(parent, 0);
>>  			} else {
>> -				__l2cap_state_change(chan, BT_CONFIG);
>> -				result = L2CAP_CR_SUCCESS;
>> +				/* Force pending result for AMP controllers.
>> +				 * The connection will succeed after the
>> +				 * physical link is up. */
>> +				if (amp_id) {
>> +					__l2cap_state_change(chan, BT_CONNECT2);
>> +					result = L2CAP_CR_PEND;
>> +				} else {
>> +					__l2cap_state_change(chan, BT_CONFIG);
>> +					result = L2CAP_CR_SUCCESS;
>> +				}
>>  				status = L2CAP_CS_NO_INFO;
>>  			}
>>  		} else {
>> @@ -3480,6 +3490,8 @@ sendresp:
>>  					l2cap_build_conf_req(chan, buf), buf);
>>  		chan->num_conf_req++;
>>  	}
>> +
>> +	return chan;
>>  }
>>
>>  static int l2cap_connect_req(struct l2cap_conn *conn,
>> @@ -3970,12 +3982,12 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
>>  	return 0;
>>  }
>>
>> -static inline int l2cap_create_channel_req(struct l2cap_conn *conn,
>> -					struct l2cap_cmd_hdr *cmd, u16 cmd_len,
>> -					void *data)
>> +static int l2cap_create_channel_req(struct l2cap_conn *conn,
>> +				    struct l2cap_cmd_hdr *cmd, u16 cmd_len,
>> +				    void *data)
>>  {
>>  	struct l2cap_create_chan_req *req = data;
>> -	struct l2cap_create_chan_rsp rsp;
>> +	struct l2cap_chan *chan;
>>  	u16 psm, scid;
>>
>>  	if (cmd_len != sizeof(*req))
>> @@ -3989,14 +4001,40 @@ static inline int l2cap_create_channel_req(struct l2cap_conn *conn,
>>
>>  	BT_DBG("psm 0x%2.2x, scid 0x%4.4x, amp_id %d", psm, scid, req->amp_id);
>>
>> -	/* Placeholder: Always reject */
>> -	rsp.dcid = 0;
>> -	rsp.scid = cpu_to_le16(scid);
>> -	rsp.result = __constant_cpu_to_le16(L2CAP_CR_NO_MEM);
>> -	rsp.status = __constant_cpu_to_le16(L2CAP_CS_NO_INFO);
>> +	if (req->amp_id) {
>> +		struct hci_dev *hdev;
>>
>> -	l2cap_send_cmd(conn, cmd->ident, L2CAP_CREATE_CHAN_RSP,
>> -		       sizeof(rsp), &rsp);
>> +		/* Validate AMP controller id */
>> +		hdev = hci_dev_get(req->amp_id);
>> +		if (!hdev || hdev->dev_type != HCI_AMP ||
>> +		    !test_bit(HCI_UP, &hdev->flags)) {
>> +			struct l2cap_create_chan_rsp rsp;
>> +
>> +			rsp.dcid = 0;
>> +			rsp.scid = cpu_to_le16(scid);
>> +			rsp.result = L2CAP_CR_BAD_AMP;
>> +			rsp.status = L2CAP_CS_NO_INFO;
>
> Please consider this:
>
> -                       rsp.result = L2CAP_CR_BAD_AMP;
> -                       rsp.status = L2CAP_CS_NO_INFO;
> +                       rsp.result = __constant_cpu_to_le16(L2CAP_CR_BAD_AMP);
> +                       rsp.status = __constant_cpu_to_le16(L2CAP_CS_NO_INFO);
>

Ok, I'll fix that and look for similar issues.

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

