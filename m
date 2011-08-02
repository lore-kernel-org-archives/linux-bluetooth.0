Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] doc: add remote version to NewConnection method
Date: Tue,  2 Aug 2011 16:22:19 +0200
Message-Id: <1312294940-8327-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1312294940-8327-1-git-send-email-frederic.danis@linux.intel.com>
References: <1312294940-8327-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/hfp-api.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/hfp-api.txt b/doc/hfp-api.txt
index 93251e8..cf2e730 100644
--- a/doc/hfp-api.txt
+++ b/doc/hfp-api.txt
@@ -62,7 +62,7 @@ Service         unique name
 Interface       org.bluez.HandsfreeAgent
 Object path     freely definable
 
-Methods		void NewConnection(filedescriptor fd)
+Methods		void NewConnection(filedescriptor fd, uint16 version)
 
 			This method gets called whenever a new handsfree
 			connection has been established.  The objectpath
-- 
1.7.1

