Return-Path: <cyrus@holtmann.org>
From: yegorslists@googlemail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH 2/2] add tools to include folder list
Date: Wed, 28 Dec 2011 10:53:37 +0100
Message-Id: <1325066017-2384-3-git-send-email-yegorslists@googlemail.com>
In-Reply-To: <1325066017-2384-1-git-send-email-yegorslists@googlemail.com>
References: <1325066017-2384-1-git-send-email-yegorslists@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Yegor Yefremov <yegorslists@googlemail.com>

adding tools to include folder list avoids out-of-source build
breakage
---
 Makefile.am |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 9f26b06..8bc6cfe 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -441,7 +441,8 @@ AM_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@
 
 INCLUDES = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
 			-I$(srcdir)/audio -I$(srcdir)/sbc -I$(srcdir)/gdbus \
-			-I$(srcdir)/attrib -I$(srcdir)/btio
+			-I$(srcdir)/attrib -I$(srcdir)/btio -I$(srcdir)/tools \
+			-I$(builddir)/tools
 
 if MCAP
 INCLUDES += -I$(builddir)/health
-- 
1.7.5.4
