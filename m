Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 0/2] Add support for SCO defered setup in test
Date: Mon, 19 Nov 2012 16:50:42 +0100
Message-Id: <1353340244-16443-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for deferred setup in userspace test tools for SCO
connections.

Regards,
Frédéric

Frédéric Dalleau (2):
  scotest: Add deferred setup option
  btiotest: Enable deferred setup for sco sockets

 test/btiotest.c |   22 +++++++++++++++-----
 test/scotest.c  |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 72 insertions(+), 10 deletions(-)

-- 
1.7.9.5

