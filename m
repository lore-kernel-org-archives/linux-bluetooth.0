Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: linux-bluetooth@vger.kernel.org
Date: Fri,  6 Aug 2010 16:20:00 +0200
Message-Id: <1281104400-9019-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH] add mailing list as bug report address to configure.ac
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index b004f6e..2804d29 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,5 +1,5 @@
 AC_PREREQ(2.60)
-AC_INIT(bluez, 4.69)
+AC_INIT(bluez, 4.69, [linux-bluetooth@vger.kernel.org])
 
 AM_INIT_AUTOMAKE([foreign subdir-objects])
 AM_CONFIG_HEADER(config.h)
-- 
1.7.1

