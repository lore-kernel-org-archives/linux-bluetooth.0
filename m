Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Dec 2010 07:42:31 +0100
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Subject: HFP: typo in error path?
Message-ID: <20101216064231.GA2033@candlejack.bmw-carit.intra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm reading a bit through the code and try to understand how the HF
role in HFP is implemented. I found following in audio/gateway.c:

static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond,
			struct audio_device *dev)
{
	struct gateway *gw = dev->gateway;

	if (cond & G_IO_NVAL)
		return FALSE;

	if (cond & (G_IO_ERR | G_IO_HUP)) {
		DBG("sco connection is released");
		g_io_channel_shutdown(gw->sco, TRUE, NULL);
		g_io_channel_unref(gw->sco);
		gw->sco = NULL;
		change_state(dev, GATEWAY_STATE_CONNECTED);
		return FALSE;
	}

	return TRUE;
}

I don't really understand what's going on here, but just from the
naming I think the change_state call should be
GATEWAY_STATE_DISCONNECTED. If my assumation is correct I can spin a
patch.

cheers,
daniel
