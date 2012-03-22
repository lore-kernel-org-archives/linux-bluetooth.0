Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC 3/7] doc: document MediaTransport.Reconfigure
Date: Thu, 22 Mar 2012 17:37:51 +0100
Message-Id: <1332434275-25394-4-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1332434275-25394-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1332434275-25394-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/media-api.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index b32636b..cd3363d 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -286,6 +286,12 @@ Methods		dict GetProperties()
 
 			Releases file descriptor.
 
+		void Reconfigure(object endpoint)  [experimental]
+
+			Reconfigure the transport to use the specified endpoint.
+			The stream will be reconfigured and the transport
+			recreated.
+
 		void SetProperty(string name, variant value)
 
 			Changes the value of the specified property. Only
-- 
1.7.5.4

