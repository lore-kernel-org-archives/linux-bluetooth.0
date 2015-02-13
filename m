Return-Path: <cyrus@holtmann.org>
From: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
To: linux-bluetooth@vger.kernel.org
References: <1423461075-13898-1-git-send-email-s.nageshmurt@samsung.com>
In-reply-to: <1423461075-13898-1-git-send-email-s.nageshmurt@samsung.com>
Subject: RE: [PATCH 1/1] doc/media-api: Add RegisterTrackList method
Date: Fri, 13 Feb 2015 10:23:05 +0530
Message-id: <00dd01d04748$f61b5c30$e2521490$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

-----Original Message-----
From: Sagar Nageshmurthy [mailto:s.nageshmurt@samsung.com] 
Sent: Monday, February 09, 2015 11:21 AM
To: linux-bluetooth@vger.kernel.org
Cc: Sagar Nageshmurthy
Subject: [PATCH 1/1] doc/media-api: Add RegisterTrackList method

Provides access to a short list of tracks which were recently played or will
be played shortly.
---
 doc/media-api.txt |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt index b17a151..9830136
100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -62,6 +62,21 @@ Methods		void RegisterEndpoint(object
endpoint, dict properties)
 			Possible Errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.NotSupported
 
+		void RegisterTrackList(object player, dict properties)
+
+			Register a media player object to TrackList
interface.
+
+			Object must be registered to sender using
+			RegisterPlayer.
+
+			Object must implement
org.mpris.MediaPlayer2.TrackList
+			as defined in MPRIS 2.2 spec:
+
+
http://specifications.freedesktop.org/mpris-spec/latest/
+
+			Possible Errors: org.bluez.Error.NotAuthorized
+					 org.bluez.Error.InvalidArguments
+
 		void UnregisterPlayer(object player)
 
 			Unregister sender media player.
--
1.7.9.5

If you don't have any comments on this patch I will raise the corresponding
patch that implements RegisterTrackList method.

Thanks & Regards,
Sagar N

