Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 2/4] Add .gitignore for bluez-hcidump
Date: Sun,  9 Aug 2009 05:41:07 -0300
Message-Id: <1249807269-21494-3-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1249807269-21494-2-git-send-email-gustavo@las.ic.unicamp.br>
References: <1249807269-21494-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1249807269-21494-2-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

this file avoids dirty things on git status
---
 .gitignore |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100644 .gitignore

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..76bcb61
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,28 @@
+*.o
+*.a
+*.lo
+*.la
+*.so
+.deps
+.libs
+Makefile
+Makefile.in
+aclocal.m4
+config.guess
+config.h
+config.h.in
+config.log
+config.status
+config.sub
+configure
+depcomp
+install-sh
+libtool
+ltmain.sh
+missing
+stamp-h1
+autom4te.cache
+
+src/bpasniff
+src/csrsniff
+src/hcidump
-- 
1.6.3.3

