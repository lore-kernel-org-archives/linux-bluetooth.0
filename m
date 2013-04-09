Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] obexd: Force service lookup when instantiating MAP session
Date: Tue,  9 Apr 2013 13:54:08 +0200
Message-Id: <1365508448-13171-9-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365508448-13171-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365508448-13171-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

In order to correctly receive event reports, the MAP driver needs to read
the MASinstanceID of the MAS server it is connected to. Since that
information is only available in the SDP record, a MAP session needs to
force the service lookup when connecting.

The MASinstanceID is needed to correctly retrieve event reports.
---
 obexd/client/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index b39eaa5..7a02583 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1804,6 +1804,7 @@ static struct obc_driver map = {
 	.uuid = MAS_UUID,
 	.target = OBEX_MAS_UUID,
 	.target_len = OBEX_MAS_UUID_LEN,
+	.force_service_lookup = TRUE,
 	.probe = map_probe,
 	.remove = map_remove
 };
-- 
1.8.2.1

