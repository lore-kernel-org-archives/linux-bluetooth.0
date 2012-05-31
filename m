Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH] BNEP Reply to extensions at connection setup
Date: Thu, 31 May 2012 11:30:07 +0300
Message-Id: <1338453008-15947-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A folk is trying to qualify bluez and told that the following test would fail :
TP/BNEP/CTRL/BV-19-C. I searched the spec, errata and list archive. I haven't
found any informations or previous patch related to this test.

So I wrote a fix, but I think it shouldn't go upstream before it has been
validated and the folk cannot do that before next month. If anybody has access
to a test system sooner, please let me know.

This version is now restyled as per Luiz comments !

Frédéric Dalleau (1):
  network: Reply to extensions at connection setup

 network/server.c |   34 ++++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

-- 
1.7.5.4

