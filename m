Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/11] test: Fix using Number instead of Track in simple-player
Date: Thu, 25 Oct 2012 16:59:12 +0300
Message-Id: <1351173554-28039-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
References: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/simple-player | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/simple-player b/test/simple-player
index 70701da..f8751d6 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -111,7 +111,7 @@ if __name__ == '__main__':
 					"Album" : "Album",
 					"Genre" : "Genre",
 					"NumberOfTracks" : dbus.UInt32(10),
-					"Number" : dbus.UInt32(1),
+					"Track" : dbus.UInt32(1),
 					"Duration" : dbus.UInt32(10000) }, signature="sv")
 
 	print('Register media player with:\n\tProperties: %s\n\tMetadata: %s' \
-- 
1.7.11.7

