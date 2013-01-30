Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 0/4] sco: Integrate SCO socket option in user space.
Date: Wed, 30 Jan 2013 18:03:00 +0100
Message-Id: <1359565384-4656-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is the required patches for taking advantage of SCO codec mode from
userspace.

Regards,
Frédéric

Frédéric Dalleau (4):
  lib: Declare mode field in sco_options
  scotest: Add option for SCO socket mode
  btio: Add option for SCO socket mode
  btiotest: Add option for SCO socket mode

 btio/btio.c      |   11 ++++++++---
 btio/btio.h      |    1 +
 lib/sco.h        |    1 +
 tools/btiotest.c |   19 ++++++++++++++-----
 tools/scotest.c  |   36 ++++++++++++++++++++++++++++++++++--
 5 files changed, 58 insertions(+), 10 deletions(-)

-- 
1.7.9.5

