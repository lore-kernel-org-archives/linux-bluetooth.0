Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/4] ignore newly generated manpages
Date: Sat, 27 Jun 2009 17:05:45 +0200
Message-Id: <1246115145-14891-1-git-send-email-filippo@esaurito.net>
In-Reply-To: <1246114900-14482-1-git-send-email-filippo@esaurito.net>
References: <1246114900-14482-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index fdbebcb..324b053 100644
--- a/.gitignore
+++ b/.gitignore
@@ -83,3 +83,5 @@ doc/*.sgml
 doc/version.xml
 doc/xml
 doc/html
+src/bluetoothd.8
+src/hcid.conf.5
-- 
1.6.3.1

