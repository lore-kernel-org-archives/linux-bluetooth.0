Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: David Frey <dpfrey@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: David Frey <dpfrey@gmail.com>
Subject: [PATCH BlueZ 1/1] Remove obsolete Debian notes from HACKING
Date: Mon,  5 Mar 2018 12:01:16 -0800
Message-Id: <20180305200116.32291-2-dpfrey@gmail.com>
In-Reply-To: <20180305200116.32291-1-dpfrey@gmail.com>
References: <20180305200116.32291-1-dpfrey@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HACKING document says that Debian's automake version doesn't satisfy
the automake >= 1.10 requirement, but this is no longer true. The
automake version in Debian 8 (oldstable) is 1.14 and the version in
Debian 9 (stable) is 1.15.
---
 HACKING | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/HACKING b/HACKING
index 87762f1e0..e10986fcb 100644
--- a/HACKING
+++ b/HACKING
@@ -5,16 +5,7 @@ Build tools requirements
 ========================
 
 When building and testing directly from the repository it is important to
-have at least automake version 1.10 or later installed. All modern
-distributions should default to the latest version, but it seems that
-Debian's default is still an earlier version:
-
-  Check version
-    # dpkg -l '*automake*'
-
-  Install new version
-    # apt-get install automake1.10
-    # update-alternatives --config automake
+have at least automake version 1.10 or later installed.
 
 
 Working with the source code repository
-- 
2.11.0

