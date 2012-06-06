Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH 13/13] doc: Fix typo
Date: Wed, 6 Jun 2012 18:06:11 +0200
Message-ID: <1338998771-18683-13-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
References: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fix simple typo in documentation of API.
---
 doc/adapter-api.txt   |    2 +-
 doc/audio-api.txt     |    2 +-
 doc/device-api.txt    |    2 +-
 doc/media-api.txt     |    2 +-
 doc/proximity-api.txt |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index dccb6bf..916e941 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -24,7 +24,7 @@ Methods		dict GetProperties()
 		void SetProperty(string name, variant value)
 
 			Changes the value of the specified property. Only
-			properties that are listed a read-write are changeable.
+			properties that are listed as read-write are changeable.
 			On success this will emit a PropertyChanged signal.
 
 			Possible Errors: org.bluez.Error.InvalidArguments
diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index 02291fd..9b1737d 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -122,7 +122,7 @@ Methods		void Connect()
 		void SetProperty(string name, variant value)
 
 			Changes the value of the specified property. Only
-			properties that are listed a read-write are changeable.
+			properties that are listed as read-write are changeable.
 			On success this will emit a PropertyChanged signal.
 
 			Possible Errors: org.bluez.Error.DoesNotExist
diff --git a/doc/device-api.txt b/doc/device-api.txt
index 4a170e4..0f34210 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -25,7 +25,7 @@ Methods		dict GetProperties()
 		void SetProperty(string name, variant value)
 
 			Changes the value of the specified property. Only
-			properties that are listed a read-write are changeable.
+			properties that are listed as read-write are changeable.
 			On success this will emit a PropertyChanged signal.
 
 			Possible Errors: org.bluez.Error.DoesNotExist
diff --git a/doc/media-api.txt b/doc/media-api.txt
index 2e19417..0299333 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -315,7 +315,7 @@ Methods		dict GetProperties()
 		void SetProperty(string name, variant value)
 
 			Changes the value of the specified property. Only
-			properties that are listed a read-write can be changed.
+			properties that are listed as read-write can be changed.
 
 			On success this will emit a PropertyChanged signal.
 
diff --git a/doc/proximity-api.txt b/doc/proximity-api.txt
index 0c60d47..c8eae50 100644
--- a/doc/proximity-api.txt
+++ b/doc/proximity-api.txt
@@ -19,7 +19,7 @@ Methods		dict GetProperties()
 		void SetProperty(string name, variant value)
 
 			Changes the value of the specified property. Only
-			properties that are listed a read-write are changeable.
+			properties that are listed as read-write are changeable.
 			On success this will emit a PropertyChanged signal.
 
 			Possible Errors: org.bluez.Error.InvalidArguments
-- 
on behalf of ST-Ericsson

