Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Remove unused obex.conf
Date: Wed, 25 May 2011 18:39:59 +0300
Message-Id: <1306338000-7905-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1306338000-7905-1-git-send-email-luiz.dentz@gmail.com>
References: <1306338000-7905-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

obexd currently does not support configuration files.
---
 Makefile.am   |    2 +-
 src/obex.conf |   20 --------------------
 2 files changed, 1 insertions(+), 21 deletions(-)
 delete mode 100644 src/obex.conf

diff --git a/Makefile.am b/Makefile.am
index 8d8fdc6..0be6c33 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -138,7 +138,7 @@ INCLUDES = -I$(builddir)/src -I$(srcdir)/src -I$(srcdir)/plugins \
 
 CLEANFILES = $(service_DATA) $(builtin_files)
 
-EXTRA_DIST = src/genbuiltin $(doc_files) $(test_files) src/obex.conf \
+EXTRA_DIST = src/genbuiltin $(doc_files) $(test_files) \
 			src/obexd.service.in client/obex-client.service.in \
 			plugins/phonebook-dummy.c plugins/phonebook-ebook.c \
 			plugins/phonebook-tracker.c \
diff --git a/src/obex.conf b/src/obex.conf
deleted file mode 100644
index 12f88b6..0000000
--- a/src/obex.conf
+++ /dev/null
@@ -1,20 +0,0 @@
-# Configuration file for the OBEX Daemon
-[General]
-
-EnabledTransports=Bluetooth
-
-[Bluetooth]
-Enable=OPUSH
-
-# Object Push Server options
-[OPUSH]
-name=OBEX Object Push Server
-channel=9
-folder=/tmp
-auto_accept=true
-
-# FTP Server options
-# [FTP]
-# name=OBEX FTP Server
-# channel=10
-# folder=/tmp
-- 
1.7.5.1

