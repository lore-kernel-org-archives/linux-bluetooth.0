Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 0/2] gateway: Fix crash if SCO connection fails
Date: Tue, 21 Feb 2012 17:46:48 +0100
Message-Id: <1329842810-13449-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

The first patch is a resend of a previous patch with same name.
The second one happens after the sco connection has failed : the disconnect
watch is not removed when the media owner is freed upon error in acquire.

Let me know what you think.

Regards,
Frédéric


Frédéric Dalleau (2):
  gateway: Fix crash if SCO connection fails
  media: register disconnect watch at transport add

 audio/gateway.c   |    5 +----
 audio/transport.c |    6 +++---
 2 files changed, 4 insertions(+), 7 deletions(-)

-- 
1.7.5.4

