Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] Remove MediaPlayer interface from control-api.txt
Date: Fri, 30 Sep 2011 16:10:42 +0300
Message-Id: <1317388243-26240-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1317388243-26240-1-git-send-email-luiz.dentz@gmail.com>
References: <1317388243-26240-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/control-api.txt |   47 -----------------------------------------------
 1 files changed, 0 insertions(+), 47 deletions(-)

diff --git a/doc/control-api.txt b/doc/control-api.txt
index a7e5cbb..e3a13e9 100644
--- a/doc/control-api.txt
+++ b/doc/control-api.txt
@@ -93,50 +93,3 @@ Properties	uint8 SubUnitID [readonly]
 		array{string} Capabilities [readonly]
 
 			List of Capabilities provided by the connected device.
-
-
-MediaPlayer hierarchy  [experimental]
-=====================
-
-Service		org.bluez
-Interface	org.bluez.MediaPlayer
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
-
-Methods		void ChangePlayback(string status, uint32 elapsed)
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
-		void SetProperty(string property, variant value)
-
-			Called to set the media-player's properties
-
-			Current defined properties are represented with the
-			following keys and values:
-
-				Equalizer	off, on
-				Repeat		off, singletrack, alltracks, group
-				Shuffle		off, alltracks, group
-				Scan		off, alltracks, group
-
-Signals		PropertyChanged(string setting, variant value)
-
-			Called when one of the settings are changed by the
-			remote device or to inform its battery status.
-- 
1.7.6.2

