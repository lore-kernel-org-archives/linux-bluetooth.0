Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: linux-bluetooth@vger.kernel.org
Date: Wed, 11 Aug 2010 20:46:54 +0200
Message-Id: <1281552414-2986-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1281548304.12579.243.camel@localhost.localdomain>
References: <1281548304.12579.243.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH] Add hfp-api.txt to EXTRA_DIST
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Makefile.am |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index aa95ed7..83a90c9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -332,7 +332,8 @@ EXTRA_DIST += doc/manager-api.txt \
 		doc/adapter-api.txt doc/device-api.txt \
 		doc/service-api.txt doc/agent-api.txt doc/attribute-api.txt \
 		doc/serial-api.txt doc/network-api.txt \
-		doc/input-api.txt doc/audio-api.txt doc/control-api.txt
+		doc/input-api.txt doc/audio-api.txt doc/control-api.txt \
+		doc/hfp-api.txt
 
 AM_YFLAGS = -d
 
-- 
1.7.1

