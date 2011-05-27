Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH] Change append to prepend in media_transport_add
Date: Fri, 27 May 2011 15:24:20 +0300
Message-Id: <1306499060-10415-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/transport.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 702bef2..85358c7 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -487,7 +487,7 @@ static void media_transport_add(struct media_transport *transport,
 					struct media_owner *owner)
 {
 	DBG("Transport %s Owner %s", transport->path, owner->name);
-	transport->owners = g_slist_append(transport->owners, owner);
+	transport->owners = g_slist_prepend(transport->owners, owner);
 	owner->transport = transport;
 }
 
-- 
1.7.4.1

