Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Jul 2012 08:33:32 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Subject: Re: [RFCv0 11/21] Bluetooth: Add move confirm response handling
In-Reply-To: <20120726144526.GF2686@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1207260826520.20121@mathewm-linux>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org> <1343260274-11953-12-git-send-email-mathewm@codeaurora.org> <20120726144526.GF2686@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Thu, 26 Jul 2012, Andrei Emeltchenko wrote:

> Hi Mat,
>
> On Wed, Jul 25, 2012 at 04:51:03PM -0700, Mat Martineau wrote:
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  net/bluetooth/l2cap_core.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 79f9d8e..bc56f09 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -4579,6 +4579,7 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
>>  						 u16 cmd_len, void *data)
>>  {
>>  	struct l2cap_move_chan_cfm_rsp *rsp = data;
>> +	struct l2cap_chan *chan;
>>  	u16 icid;
>>
>>  	if (cmd_len != sizeof(*rsp))
>> @@ -4588,6 +4589,32 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
>>
>>  	BT_DBG("icid 0x%4.4x", icid);
>>
>> +	chan = l2cap_get_chan_by_scid(conn, icid);
>> +
>
> nitpick: extra new line here.
>

Ok.  There are a couple of other similar cases that I will fix too.

>> +	if (!chan)
>> +		return 0;
>
> are we going to use return code?
>

Same deal as l2cap_move_channel_confirm: sticking with pattern 
established by other L2CAP signal functions.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


