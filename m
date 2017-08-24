Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 3/3] build: Add a few default configure options
Date: Thu, 24 Aug 2017 20:28:24 +0200
Message-Id: <20170824182824.8465-3-hadess@hadess.net>
In-Reply-To: <20170824182824.8465-1-hadess@hadess.net>
References: <20170824182824.8465-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add 3 optional features that are currently used and distributed in
the Fedora packages to the default build configuration.

The additional build time is minimal, and it ensures that the build
gets maximum coverage.
---
 bootstrap-configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bootstrap-configure b/bootstrap-configure
index 658eef296..cb19b56bd 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -24,4 +24,7 @@ fi
 		--enable-sixaxis \
 		--enable-midi \
 		--enable-mesh \
+		--enable-pie \
+		--enable-cups \
+		--enable-library \
 		--disable-datafiles $*
-- 
2.13.5

