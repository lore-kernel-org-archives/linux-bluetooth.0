Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Dec 2010 09:10:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: HFP: typo in error path?
Message-ID: <20101216071015.GA32193@jh-x301>
References: <20101216064231.GA2033@candlejack.bmw-carit.intra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101216064231.GA2033@candlejack.bmw-carit.intra>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Thu, Dec 16, 2010, Daniel Wagner wrote:
> I'm reading a bit through the code and try to understand how the HF
> role in HFP is implemented. I found following in audio/gateway.c:
> 
> static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond,
> 			struct audio_device *dev)
> {
> 	struct gateway *gw = dev->gateway;
> 
> 	if (cond & G_IO_NVAL)
> 		return FALSE;
> 
> 	if (cond & (G_IO_ERR | G_IO_HUP)) {
> 		DBG("sco connection is released");
> 		g_io_channel_shutdown(gw->sco, TRUE, NULL);
> 		g_io_channel_unref(gw->sco);
> 		gw->sco = NULL;
> 		change_state(dev, GATEWAY_STATE_CONNECTED);
> 		return FALSE;
> 	}
> 
> 	return TRUE;
> }
> 
> I don't really understand what's going on here, but just from the
> naming I think the change_state call should be
> GATEWAY_STATE_DISCONNECTED. If my assumation is correct I can spin a
> patch.

Actually the current code is correct. This is the callback for SCO (like
the function name suggests) so when SCO gets closed there's a transition
from PLAYING to CONNECTED (meaning RFCOMM but no SCO). You can see the
full set of state values in audio/gateway.h.

Johan
