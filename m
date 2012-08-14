Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Aug 2012 10:25:02 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Subject: Re: [RFCv0 04/21] Bluetooth: Process create response and connect
 response identically
In-Reply-To: <20120814101213.GA18949@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1208141024090.24089@mathewm-linux>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org> <1343260274-11953-5-git-send-email-mathewm@codeaurora.org> <20120814101213.GA18949@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Andrei -

On Tue, 14 Aug 2012, Andrei Emeltchenko wrote:

> Hi Mat,
>
> On Wed, Jul 25, 2012 at 04:50:56PM -0700, Mat Martineau wrote:
> ...
>> -static inline int l2cap_create_channel_rsp(struct l2cap_conn *conn,
>> -					struct l2cap_cmd_hdr *cmd, void *data)
>> -{
>> -	BT_DBG("conn %p", conn);
>> -
>> -	return l2cap_connect_rsp(conn, cmd, data);
>> -}
>> -
>>  static void l2cap_send_move_chan_rsp(struct l2cap_conn *conn, u8 ident,
>>  				     u16 icid, u16 result)
>>  {
>> @@ -4249,6 +4241,7 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
>>  		break;
>>
>>  	case L2CAP_CONN_RSP:
>> +	case L2CAP_CREATE_CHAN_RSP:
>>  		err = l2cap_connect_rsp(conn, cmd, data);
> ...
>
> We might rename l2cap_connect_rsp to something like
> l2cap_connect_create_rsp

Ok, I'll update that function name.


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

