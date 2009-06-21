Return-Path: <cyrus@holtmann.org>
Subject: Re: regression introduced on v2.6.30-rc1
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c100906210708x1816e5d9hb9a80c82d76da6dd@mail.gmail.com>
References: <2d5a2c100906090617m167d3815pae998d06bdbd6646@mail.gmail.com>
	 <2d5a2c100906210708x1816e5d9hb9a80c82d76da6dd@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 21 Jun 2009 16:48:27 +0200
Message-Id: <1245595707.15367.66.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Finally find out what is the problem, we are currently sending DM to
> reject the connection when using DEFER_SETUP which is fine according
> to RFCOMM spec:
> 
> "the responding implementation may replace the "proper" response on
> the Multiplexer Control channel with a DM frame, sent on the referenced DLCI
> to indicate that the DLCI is not open, and that the responder would not grant a
> request to open it later either."
> 
> What it doesn't mention is which part is supposed to take down DLCI 0
> in case that there is no other DLC configured, from what I could find
> out the initiator is supposed to take down by sending DISC 0. This
> seems to work fine when using rctest, but some headset may not take
> any action when receiving the DM frame, so what can be done in this
> case?
> 
> What about a timeout to trigger rfcomm_session_put and send DISC 0?
> This might solve the problem and we avoid the double DISC 0 in case
> the initiator stack implementation cope with DM.

so does this fixes it:

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 374536e..266c3b7 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1772,8 +1772,7 @@ static inline void rfcomm_process_dlcs(struct
rfcomm_sessi
                        rfcomm_dlc_clear_timer(d);
                        if (!d->out)
                                rfcomm_send_dm(s, d->dlci);
-                       else
-                               d->state = BT_CLOSED;
+                       d->state = BT_CLOSED;
                        __rfcomm_dlc_close(d, ECONNREFUSED);
                        continue;
                }

Regards

Marcel


