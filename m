Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] build: Add support for building MNS server
Date: Tue,  9 Apr 2013 13:51:35 +0200
Message-Id: <1365508297-13032-4-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365508297-13032-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365508297-13032-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

---
 Makefile.obexd | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile.obexd b/Makefile.obexd
index ae05ae9..5824e0a 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -48,6 +48,9 @@ obexd_builtin_sources += obexd/plugins/mas.c obexd/src/map_ap.h \
 				obexd/plugins/messages.h \
 				obexd/plugins/messages-dummy.c
 
+obexd_builtin_modules += mns
+obexd_builtin_sources += obexd/client/mns.c obexd/src/map_ap.h \
+				obexd/client/map-event.h
 
 libexec_PROGRAMS += obexd/src/obexd
 
-- 
1.8.2.1

