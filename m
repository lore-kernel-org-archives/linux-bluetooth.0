Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] gstreamer a2dp as marginal plugin
Date: Wed,  1 Jul 2009 13:15:56 +0200
Message-Id: <1246446957-15477-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch avoids taking over the default output sink by registering a2dp as
RANK_MARGINAL.
I'm not sure this is desiderable in general but at least autoaudiosink does the
right thing and selects ALSA/OSS which are RANK_PRIMARY.

Filippo Giunchedi (1):
  Register the a2dp gst sink as marginal

 audio/gsta2dpsink.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

