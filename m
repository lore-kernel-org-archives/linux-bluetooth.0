Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, hadess@hadess.net, padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 5/5] Document new "hex-encoded pins" feature
Date: Thu,  5 May 2011 21:17:20 +0200
Message-Id: <1304623040-30461-5-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1304623040-30461-1-git-send-email-dh.herrmann@googlemail.com>
References: <1304623040-30461-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/agent-api.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index d8d35c0..0c84e1c 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -26,7 +26,13 @@ Methods		void Release()
 			needs to get the passkey for an authentication.
 
 			The return value should be a string of 1-16 characters
-			length. The string can be alphanumeric.
+			length. Longer strings are truncated to 16 characters.
+			The string can be alphanumeric.
+
+			Strings starting with '$' are parsed as hex-encoded
+			pins. That is, each two following hex characters form
+			a single byte of the resulting pin. The parser is
+			case-insensitive.
 
 			Possible errors: org.bluez.Error.Rejected
 			                 org.bluez.Error.Canceled
-- 
1.7.5

