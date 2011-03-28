Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/2] Update Media API documentation
Date: Mon, 28 Mar 2011 17:21:57 +0300
Message-Id: <1301322117-22724-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1301322117-22724-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1301322117-22724-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Possible error responses are added to RegisterEndpoint.
---
 doc/media-api.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 84903d6..b2f239a 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -35,6 +35,11 @@ Methods		void RegisterEndpoint(object endpoint, dict properties)
 					Capabilities blob, it is used as it is
 					so the size and byte order must match.
 
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.NotSupported - emitted
+					 when interface for the end-point is
+					 disabled.
+
 		void UnregisterEndpoint(object endpoint)
 
 			Unregister sender end point.
-- 
1.7.1

