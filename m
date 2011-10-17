Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Oct 2011 10:23:46 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org
Subject: Re: [PATCH 4/9] Bluetooth: Add AMP-related data and structures for
 channel signals
Message-ID: <20111017072343.GB6724@aemeltch-MOBL1>
References: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
 <1318543247-27130-5-git-send-email-mathewm@codeaurora.org>
 <20111014121912.GA4753@aemeltch-MOBL1>
 <alpine.DEB.2.02.1110141541560.9993@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1110141541560.9993@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Fri, Oct 14, 2011 at 03:58:27PM -0700, Mat Martineau wrote:
> >>+#define L2CAP_CREATE_CHAN_STATUS_NONE		0x0000
> >>+#define L2CAP_CREATE_CHAN_STATUS_AUTHENTICATION	0x0001
> >>+#define L2CAP_CREATE_CHAN_STATUS_AUTHORIZATION	0x0002
> >
> >Isn't it a little bit log? why not CR/CS as it is already done?
> 
> I was staying close to the spec, but I admit it's verbose by Linux
> kernel standards.  I'll adopt your shorter names.
> 
> 
> >BTW: I've done it different way. Since STATUS and RESULT are almost the same for
> >connect/create my patch is:
> >
> ><------8<-----------------------------------------
> >|  @@ -214,14 +216,15 @@ struct l2cap_conn_rsp {
> >|   #define L2CAP_CID_DYN_START    0x0040
> >|   #define L2CAP_CID_DYN_END      0xffff
> >|
> >|  -/* connect result */
> >|  +/* connect/create channel results */
> >|   #define L2CAP_CR_SUCCESS       0x0000
> >|   #define L2CAP_CR_PEND          0x0001
> >|   #define L2CAP_CR_BAD_PSM       0x0002
> >|   #define L2CAP_CR_SEC_BLOCK     0x0003
> >|   #define L2CAP_CR_NO_MEM                0x0004
> >|  +#define L2CAP_CR_BAD_AMP       0x0005
> >|
> >|  -/* connect status */
> >|  +/* connect/create channel status */
> >|   #define L2CAP_CS_NO_INFO       0x0000
> >|   #define L2CAP_CS_AUTHEN_PEND   0x0001
> >|   #define L2CAP_CS_AUTHOR_PEND   0x0002
> >|
> ><------8<-----------------------------------------
> >
> >>+
> >>+struct l2cap_move_chan_req {
> >>+	__le16      icid;
> >>+	__u8        dest_amp_id;
> >>+} __attribute__ ((packed));
> >>+
> >>+struct l2cap_move_chan_rsp {
> >>+	__le16      icid;
> >>+	__le16      result;
> >>+} __attribute__ ((packed));
> >>+
> >>+#define L2CAP_MOVE_CHAN_SUCCESS			0x0000
> >>+#define L2CAP_MOVE_CHAN_PENDING			0x0001
> >>+#define L2CAP_MOVE_CHAN_REFUSED_CONTROLLER	0x0002
> >>+#define L2CAP_MOVE_CHAN_REFUSED_SAME_ID		0x0003
> >>+#define L2CAP_MOVE_CHAN_REFUSED_CONFIG		0x0004
> >>+#define L2CAP_MOVE_CHAN_REFUSED_COLLISION	0x0005
> >>+#define L2CAP_MOVE_CHAN_REFUSED_NOT_ALLOWED	0x0006
> >
> >Same here: use CR and shorter names
> 
> How about L2CAP_MC_SUCCESS, L2CAP_MC_PEND, etc.?  While create
> channel is very similar to the connect request, moving a channel is
> a whole different idea.

Maybe MR (Move Result, similar to CR) is better.

Best regards 
Andrei Emeltchenko 

