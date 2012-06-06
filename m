Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH 12/13] media-api: Update documentation with setting Addressed Player
Date: Wed, 6 Jun 2012 18:06:10 +0200
Message-ID: <1338998771-18683-12-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
References: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Media API for Addressed Player allow to change addressed player
to one from already registered players. If no players are registered
default dummy player is used.
---
 doc/media-api.txt |   28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 4446439..2e19417 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -8,7 +8,19 @@ Service		org.bluez
 Interface	org.bluez.Media
 Object path	[variable prefix]/{hci0,hci1,...}
 
-Methods		void RegisterEndpoint(object endpoint, dict properties)
+Methods		dict GetProperties()
+
+			Returns all properties. See the
+			properties section for available properties.
+
+		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed as read-write are changeable.
+
+			On success this will emit a PropertyChanged signal.
+
+		void RegisterEndpoint(object endpoint, dict properties)
 
 			Register a local end point to sender, the sender can
 			register as many end points as it likes.
@@ -123,6 +135,20 @@ Methods		void RegisterEndpoint(object endpoint, dict properties)
 
 			Unregister sender media player.
 
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	array{object} Players [readonly]
+
+			List of registered players.
+
+		object AddressedPlayer [readwrite]
+
+			Set active media player. Only one active player may be
+			used by remote controller.
+
 MediaPlayer hierarchy
 =====================
 
-- 
on behalf of ST-Ericsson

