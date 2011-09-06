Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v5 0/6] Add support for HandsfreeGateway to Media
Date: Tue,  6 Sep 2011 15:55:47 +0200
Message-Id: <1315317353-14412-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The first patch in this series fix the issue remaining in v2.
It also fix a crash because the request_stream callback was run synchronously.
After that various fixes.

Changes from v4 :
Patch 2: take Luiz comment into account and create error domain for
gateway
Patch 4: also make sure gateway is set back to disconnected state in case of
authorize errors.

Best regards,
Frédéric

Frédéric Dalleau (6):
  Fix disconnect SCO at same time than RFCOMM
  Fix asynchronously run request stream cb
  Fix state to "playing" on SCO establishment
  Set state to "connecting" on connection requested
  Fix reference count issue in incoming connections
  Check all states before allowing gw connection

 audio/gateway.c |  194 ++++++++++++++++++++++++++++++++++++++-----------------
 audio/gateway.h |   12 +++-
 audio/manager.c |    8 ++-
 audio/unix.c    |   13 +---
 4 files changed, 155 insertions(+), 72 deletions(-)

