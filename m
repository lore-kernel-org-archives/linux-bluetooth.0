Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 0/9] Add support for HandsfreeGateway to Media
Date: Mon, 22 Aug 2011 17:30:38 +0200
Message-Id: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch will enable HandsfreeGateway interface to work with PulseAudio.
This is similar to what is done for Headset interface.

Also there is some minor fixes in the pulse audio part required.
I've updated the patch on the PA list to v3

Best regards,
Frédéric

Frédéric Dalleau (9):
  Fix double free in error case in endpoint_reply
  Add state change callback to HandsfreeGateway
  Use state change callback from media interface
  Update g_strcmp0 to strcasecmp
  Fix RFCOMM disconnect on suspend request
  Set state to "connecting" when AG connects.
  Fix invalid state at SCO disconnect in gateway
  Introduce gateway locking mechanism
  Implement media_transport for HFP_HS_UUID

 audio/gateway.c   |  107 ++++++++++++++++++++++++++++++++++++++++++-
 audio/gateway.h   |   15 ++++++
 audio/media.c     |   61 ++++++++++++++++++++++++-
 audio/transport.c |  130 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 309 insertions(+), 4 deletions(-)

