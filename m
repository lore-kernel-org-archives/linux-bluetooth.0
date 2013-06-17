Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/6] build: Add support for building MAP notification dispatcher
Date: Mon, 17 Jun 2013 10:35:28 +0200
Message-Id: <1371458131-2741-4-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1371458131-2741-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1371458131-2741-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

---
 Makefile.obexd | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.obexd b/Makefile.obexd
index 5824e0a..4937e0c 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -73,6 +73,7 @@ obexd_src_obexd_SOURCES = $(gdbus_sources) $(btio_sources) $(gobex_sources) \
 			obexd/client/ftp.h obexd/client/ftp.c \
 			obexd/client/opp.h obexd/client/opp.c \
 			obexd/client/map.h obexd/client/map.c \
+			obexd/client/map-event.h obexd/client/map-event.c \
 			obexd/client/transfer.h obexd/client/transfer.c \
 			obexd/client/transport.h obexd/client/transport.c \
 			obexd/client/dbus.h obexd/client/dbus.c \
-- 
1.8.2.3

