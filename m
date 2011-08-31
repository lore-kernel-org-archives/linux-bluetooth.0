Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 0/4] Add support for HandsfreeGateway to Media
Date: Wed, 31 Aug 2011 17:48:48 +0200
Message-Id: <1314805732-30418-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The first patch in this series fix the issue remaining in v2.
It also fix a crash because the request_stream callback was run synchronously.
After that two minor fixes.

Best regards,
Frédéric

Frédéric Dalleau (4):
  Fix disconnect SCO at same time than RFCOMM
  Fix asynchronously run request stream cb
  Fix state to "playing" on SCO establishment
  Set state to "connecting" on connection requested

 audio/gateway.c |  153 +++++++++++++++++++++++++++++++++++++------------------
 audio/gateway.h |    2 +-
 audio/unix.c    |   13 ++---
 3 files changed, 109 insertions(+), 59 deletions(-)

