Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC 2/7] doc: document MediaTransport.Codecs property
Date: Thu, 22 Mar 2012 17:37:50 +0100
Message-Id: <1332434275-25394-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1332434275-25394-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1332434275-25394-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/media-api.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index c53ab7b..b32636b 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -312,6 +312,12 @@ Properties	object Device [readonly]
 			The values should match the profile specification which
 			is indicated by the UUID.
 
+		array{byte} Codecs [readonly, experimental]
+
+			Codecs list, contains assigned numbers for all codecs
+			that the transport support. The values should match the
+			profile specification which is indicated by the UUID.
+
 		array{byte} Configuration [readonly]
 
 			Configuration blob, it is used as it is so the size and
-- 
1.7.5.4

