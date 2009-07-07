Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Jul 2009 10:28:07 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] make sure that PKG_CONFIG macros are defined
Message-ID: <20090707102807.3f64f886@stoetzler>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 configure.ac |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8124c01..a08c972 100644
--- a/configure.ac
+++ b/configure.ac
@@ -8,6 +8,8 @@ m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 
 AM_MAINTAINER_MODE
 
+PKG_PROG_PKG_CONFIG
+
 AC_INIT_BLUEZ
 
 COMPILER_FLAGS
-- 
1.6.3.2
