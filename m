Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v3 0/8] Add support for HandsfreeGateway to Media
Date: Fri, 26 Aug 2011 17:39:30 +0200
Message-Id: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The first patch in this series fix the issue remaining in v2.
It also fix a crash because the request_stream callback was run synchronously.
After that various fixes and cleanup.

Best regards,
Frédéric

Frédéric Dalleau (8):
  Fix disconnect SCO at same time than RFCOMM
  Fix asynchronously run request stream cb
  Cancel pending callback if stream is canceled
  Fix state to "playing" on SCO establishment
  Set state to "connecting" on connection requested
  Use int instead of GError into callbacks
  Asynchronously run gateway_config_stream cb
  Remove occurences of sco_start_cb

 audio/gateway.c   |  144 +++++++++++++++++++++++++++++++++++-----------------
 audio/gateway.h   |    6 +-
 audio/transport.c |    4 +-
 audio/unix.c      |   21 +++-----
 4 files changed, 110 insertions(+), 65 deletions(-)

