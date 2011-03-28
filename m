Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 3/6] Register Attrib interface after Primary Service discovery
Date: Mon, 28 Mar 2011 19:40:48 -0300
Message-Id: <1301352051-12046-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1301352051-12046-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1301352051-12046-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index 9a3202f..1d7094b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1546,6 +1546,10 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	}
 
 	device_probe_drivers(device, uuids);
+
+	/* FIXME: Need the correct psm */
+	attrib_client_register(device, -1, services);
+
 	g_slist_free(uuids);
 
 	create_device_reply(device, req);
-- 
1.7.4.1

