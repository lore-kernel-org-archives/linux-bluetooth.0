Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] sdp: Move sdp server init to adapter
Date: Thu, 29 Aug 2013 11:56:44 +0200
Message-Id: <1377770207-22688-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1377770207-22688-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1377770207-22688-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change-Id: Ie8440d59a00750f3d8aec49924d6b209bc6ebe2f
---
 src/adapter.c |   12 ++++++++++++
 src/adapter.h |    1 +
 src/main.c    |    2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 17f5508..d2d829e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6295,3 +6295,15 @@ void adapter_shutdown(void)
 	if (!adapter_remaining)
 		btd_exit();
 }
+
+void adapter_start_sdp_server(uint16_t sdp_mtu, uint32_t sdp_flags)
+{
+	sdp_list_t *services;
+
+	info("Start sdp server");
+	start_sdp_server(sdp_mtu, sdp_flags);
+
+	services = sdp_get_record_list();
+	for (; services; services = services->next)
+		adapter_foreach(adapter_service_insert, services->data);
+}
diff --git a/src/adapter.h b/src/adapter.h
index 32b12c0..a60a29f 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -79,6 +79,7 @@ struct smp_ltk_info {
 int adapter_init(void);
 void adapter_cleanup(void);
 void adapter_shutdown(void);
+void adapter_start_sdp_server(uint16_t sdp_mtu, uint32_t sdp_flags);
 
 struct btd_adapter *adapter_find(const bdaddr_t *sba);
 struct btd_adapter *adapter_find_by_id(int id);
diff --git a/src/main.c b/src/main.c
index dc0478e..7e68d1e 100644
--- a/src/main.c
+++ b/src/main.c
@@ -548,7 +548,7 @@ int main(int argc, char *argv[])
 	if (option_compat == TRUE)
 		sdp_flags |= SDP_SERVER_COMPAT;
 
-	start_sdp_server(sdp_mtu, sdp_flags);
+	adapter_start_sdp_server(sdp_mtu, sdp_flags);
 
 	/* Loading plugins has to be done after D-Bus has been setup since
 	 * the plugins might wanna expose some paths on the bus. However the
-- 
1.7.9.5

