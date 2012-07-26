Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Jul 2012 22:43:05 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Subject: Re: [RFCv0 03/21] Bluetooth: Add L2CAP create channel request
 handling.
Message-ID: <20120726194302.GA5144@aemeltch-MOBL1>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
 <1343260274-11953-4-git-send-email-mathewm@codeaurora.org>
 <20120726131351.GA2686@aemeltch-MOBL1>
 <alpine.DEB.2.02.1207260753210.20121@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1207260753210.20121@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Jul 26, 2012 at 08:04:11AM -0700, Mat Martineau wrote:
> >>-static void __l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
> >>-			    u8 *data, u8 rsp_code, u8 amp_id)
> >>+static struct l2cap_chan *__l2cap_connect(struct l2cap_conn *conn,
> >>+					  struct l2cap_cmd_hdr *cmd,
> >>+					  u8 *data, u8 rsp_code, u8 chan_id)
> >
> >Do you think chan_id is better then amp_id? At least for channel connect amp_id
> >looks better.
> >
> 
> When we were defining the socket option API, Marcel preferred
> "channel policy" over "AMP policy", so I tried to keep terminology
> more generic in this code as well.  That might not have been the
> correct decision. I'm fine with anything: amp_id, chan_id,
> controller_id, ...

I think amp_id and controller_id (or even remote_amp_id) are better names
since this is "the identifier of the Controller on the remote device
obtained via an AMP Manager Discover Available AMPs request."

chan_id is kind of identifier of a channel, a name would be messed with CID
which is already used for other purposes. I think the name channel policy
is also OK since it is a policy of a channel (for each channel we might
have different policy).

Best regards 
Andrei Emeltchenko 

