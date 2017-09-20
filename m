Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 3/4] systemd: Add more filesystem lockdown
Date: Wed, 20 Sep 2017 13:48:18 +0200
Message-Id: <20170920114819.19929-3-hadess@hadess.net>
In-Reply-To: <20170920114819.19929-1-hadess@hadess.net>
References: <20170920114819.19929-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We can only access the configuration file as read-only and read-write
to the Bluetooth cache directory and sub-directories.
---
 Makefile.am              | 2 ++
 src/bluetooth.service.in | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 1c38d94e5..13ccf9079 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -478,6 +478,8 @@ MAINTAINERCLEANFILES = Makefile.in \
 
 SED_PROCESS = $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
 		$(SED) -e 's,@libexecdir\@,$(libexecdir),g' \
+		       -e 's,@statedir\@,$(statedir),g' \
+		       -e 's,@confdir\@,$(confdir),g' \
 		< $< > $@
 
 %.service: %.service.in Makefile
diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index a6f3030f9..7e55b5043 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -17,6 +17,10 @@ LimitNPROC=1
 ProtectHome=true
 ProtectSystem=full
 PrivateTmp=true
+ProtectKernelTunables=true
+ProtectControlGroups=true
+ReadWritePaths=@statedir@
+ReadOnlyPaths=@confdir@
 
 # Privilege escalation
 NoNewPrivileges=true
-- 
2.14.1

