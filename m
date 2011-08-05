Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 23/23] Update Control documentation
Date: Fri,  5 Aug 2011 15:15:32 -0300
Message-Id: <1312568132-21112-23-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move methods and signal to an experimental interface named MediaPlayer
as currently implemented.
---
 doc/control-api.txt |  101 +++++++++++++++++++++++++++------------------------
 1 files changed, 54 insertions(+), 47 deletions(-)

diff --git a/doc/control-api.txt b/doc/control-api.txt
index 1a42846..46eee53 100644
--- a/doc/control-api.txt
+++ b/doc/control-api.txt
@@ -45,44 +45,6 @@ Methods		void Connect()
 			Metadata or Events defined in the AVRCP+Metadata
 			specification.
 
-		void ChangePlayback(string status, uint32 elapsed)
-
-			The status can be "playing", "stopped", "paused",
-			"forward-seek", "reverse-seek" or "error". Elapsed is
-			the position within the track in milliseconds.
-
-		void ChangeTrack(dict metadata)
-
-			Called to send the mandated TrackChange event and
-			potential metadata information.
-
-			Current defined metadata information are represented
-			with the following keys:
-
-				Title		string	(mandatory)
-				Artist		string
-				Album		string
-				Genre		string
-				NumberOfTracks	uint32
-				TrackNumber	uint32
-				TrackDuration	uint32	(in milliseconds)
-
-		void ChangeSetting(string setting, variant value)
-
-			Called to transmit Application Settings, CT Status
-			and the like.
-
-			Currenet defined settings are represented with the
-			following keys:
-
-				Equalizer	off, on
-				Repeat		off, singletrack, alltracks, group
-				Shuffle		off, alltracks, group
-				Scan		off, alltracks, group
-				Battery		normal, warning, critical, external, fullcharge
-				System		powered, unpowered, unplugged
-				Volume		uint8
-
 Signals		Connected()
 
 			Sent when a successful AVRCP connection has been made
@@ -112,15 +74,6 @@ Signals		Connected()
 			connected device (except for Metadata defined in
 			Bluetooth SIG AVRCP+Metadata spec).
 
-		TrackChanged(dict metadata)
-
-			Called when Metadata is received from connected device.
-			May be multiple meta attribute/element pairs.
-
-		PlaybackChanged(string status, uint32 elapsed)
-
-		SettingChanged(string setting, variant value)
-
 Properties	uint8 SubUnitID [readonly]
 
 			The three-bit Subunit ID from the connected device.
@@ -140,3 +93,57 @@ Properties	uint8 SubUnitID [readonly]
 		array{string} Capabilities [readonly]
 
 			List of Capabilities provided by the connected device.
+
+
+MediaPlayer hierarchy  [experimental]
+=====================
+
+Service		org.bluez
+Interface	org.bluez.MediaPlayer
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Methods		void ChangePlayback(string status, uint32 elapsed)
+
+			The status can be "playing", "stopped", "paused",
+			"forward-seek", "reverse-seek" or "error". Elapsed is
+			the position within the track in milliseconds.
+
+		void ChangeTrack(dict metadata)
+
+			Called to send the mandated TrackChange event and
+			potential metadata information.
+
+			Current defined metadata information are represented
+			with the following keys:
+
+				Title		string	(mandatory)
+				Artist		string
+				Album		string
+				Genre		string
+				NumberOfTracks	uint32
+				TrackNumber	uint32
+				TrackDuration	uint32	(in milliseconds)
+
+		void ChangeSetting(string setting, variant value)
+
+			Called to transmit Application Settings.
+
+			Current defined settings are represented with the
+			following keys:
+
+				Equalizer	off, on
+				Repeat		off, singletrack, alltracks, group
+				Shuffle		off, alltracks, group
+				Scan		off, alltracks, group
+
+Signals		TrackChanged(dict metadata)
+
+			Called when Metadata is received from connected device.
+			May be multiple meta attribute/element pairs.
+
+		PlaybackChanged(string status, uint32 elapsed)
+
+		SettingChanged(string setting, variant value)
+
+			Called when one of the settings are changed by the
+			remote device or to inform its battery status.
-- 
1.7.6

