Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Oct 2012 08:51:26 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
    sunnyk@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCHv2 04/19] Bluetooth: Lookup channel structure based on
 DCID
In-Reply-To: <20121018073050.GC13545@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1210180850270.25318@mathewm-linux>
References: <1350430593-23565-1-git-send-email-mathewm@codeaurora.org> <1350430593-23565-5-git-send-email-mathewm@codeaurora.org> <20121018073050.GC13545@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Andrei -

On Thu, 18 Oct 2012, Andrei Emeltchenko wrote:

> Hi Mat,
>
> On Tue, Oct 16, 2012 at 04:36:18PM -0700, Mat Martineau wrote:
>> Processing a move channel request involves getting the channel
>> structure using the destination channel ID.  Previous code could only
>> look up using the source channel ID.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  net/bluetooth/l2cap_core.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index ec2b4d9..b5b849b 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -100,6 +100,22 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn,
>>  	return c;
>>  }
>>
>> +/* Find channel with given DCID.
>> + * Returns locked channel. */
>> +static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
>> +						 u16 cid)
>> +{
>> +	struct l2cap_chan *c;
>> +
>> +	mutex_lock(&conn->chan_lock);
>> +	c = __l2cap_get_chan_by_dcid(conn, cid);
>> +	if (c)
>> +		l2cap_chan_lock(c);
>> +	mutex_unlock(&conn->chan_lock);
>> +
>> +	return c;
>> +}
>> +
>>  static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn,
>>  						    u8 ident)
>>  {
>> @@ -4139,6 +4155,7 @@ static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
>>  					 u16 cmd_len, void *data)
>>  {
>>  	struct l2cap_move_chan_req *req = data;
>> +	struct l2cap_chan *chan;
>
> This line seems do not belong to the patch.

Yes, this line should be moved to patch 5 with the other changes to 
this function.

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
