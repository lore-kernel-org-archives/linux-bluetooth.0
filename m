Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Oct 2012 11:24:57 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 05/11] Bluetooth: AMP: Add Logical Link Create function
Message-ID: <20121029092456.GB9314@aemeltch-MOBL1>
References: <1350493622.26318.114.camel@aeonflux>
 <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1351167652-12346-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1210260958240.2459@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1210260958240.2459@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Fri, Oct 26, 2012 at 10:01:01AM -0700, Mat Martineau wrote:

...

> >@@ -3948,13 +3955,15 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
> >				goto done;
> >			}
> >
> >-			/* check compatibility */
> >-
> >			if (!chan->ctrl_id)
> >				l2cap_send_efs_conf_rsp(chan, buf, cmd->ident,
> >							0);
> >-			else
> >-				chan->ident = cmd->ident;
> >+			else {
> >+				if (l2cap_check_efs(chan)) {
> >+					amp_create_logical_link(chan);
> >+					chan->ident = cmd->ident;
> >+				}
> >+			}
> 
> Minor style issue - if one block of an if/else needs braces, then
> they all get braces.

Sure. Will fix this.

Best regards 
Andrei Emeltchenko 

