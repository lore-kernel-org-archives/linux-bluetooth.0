Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] cyclingspeed: Fix MultipleLocationsSupported property name usage
Date: Mon, 22 Jul 2013 21:36:05 -0400
Message-Id: <1374543365-8420-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

MultipleLocationsSupported is the correct property name, as implemented
in profiles/cyclingspeed/cyclingspeed.c.
---
 doc/cyclingspeed-api.txt |    2 +-
 test/test-cyclingspeed   |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/cyclingspeed-api.txt b/doc/cyclingspeed-api.txt
index 7b315e1..a1f1a93 100644
--- a/doc/cyclingspeed-api.txt
+++ b/doc/cyclingspeed-api.txt
@@ -58,7 +58,7 @@ Properties	string Location (optional) [readwrite]
 			true if sensor can read and set Cumulative Wheel
 			Revolutions value, false otherwise.
 
-		boolean MultipleSensorLocationsSupported [readonly]
+		boolean MultipleLocationsSupported [readonly]
 
 			true if sensor supports Multiple Sensor Locations
 			feature and can set Location, false otherwise.
diff --git a/test/test-cyclingspeed b/test/test-cyclingspeed
index 533120a..75bd7d7 100755
--- a/test/test-cyclingspeed
+++ b/test/test-cyclingspeed
@@ -169,13 +169,13 @@ if __name__ == "__main__":
 
 	if len(args) > 0:
 		if args[0] == "ShowSupportedLocations":
-			if properties["MultipleSensorLocationsSupported"]:
+			if properties["MultipleLocationsSupported"]:
 				print("Supported locations: ", properties["SupportedLocations"])
 			else:
 				print("Multiple sensor locations not supported")
 
 		elif args[0] == "SetLocation":
-			if properties["MultipleSensorLocationsSupported"]:
+			if properties["MultipleLocationsSupported"]:
 				device_prop.Set(CYCLINGSPEED_INTERFACE, "Location", args[1])
 			else:
 				print("Multiple sensor locations not supported")
-- 
1.7.9.5

