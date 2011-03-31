Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 2/2] Remove unused files from gatttool compilation
Date: Thu, 31 Mar 2011 11:59:11 -0400
Message-Id: <1301587151-18975-2-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1301587151-18975-1-git-send-email-bruna.moreira@openbossa.org>
References: <1301587151-18975-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index feef380..f6d7b13 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -54,7 +54,6 @@ bin_PROGRAMS += attrib/gatttool
 
 attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 				attrib/gattrib.c btio/btio.c \
-				src/glib-helper.h src/glib-helper.c \
 				attrib/gatttool.h attrib/interactive.c \
 				attrib/utils.c
 attrib_gatttool_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @READLINE_LIBS@
-- 
1.7.0.4

