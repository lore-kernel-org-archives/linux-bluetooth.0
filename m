Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Dec 2010 14:09:59 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: HFP: typo in error path?
Message-ID: <20101216160959.GA5927@vigoh>
References: <20101216064231.GA2033@candlejack.bmw-carit.intra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101216064231.GA2033@candlejack.bmw-carit.intra>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

* Daniel Wagner <wagi@monom.org> [2010-12-16 07:42:31 +0100]:

> Hi,
> 
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

GATEWAY_STATE_CONNECTED means that we have Service Level Connection with the
Phone, then if a new call arrives we change to the GATEWAY_STATE_PLAYING
state to signal that we have audio, but if for some reason the SCO link fails
we just go back to the GATEWAY_STATE_CONNECTED state because we still have the
SLC running. So your assumption is wrong. ;)

-- 
Gustavo F. Padovan
http://profusion.mobi
