Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v3 07/12] Fix memory leak of EIR data
Date: Mon, 16 May 2011 17:49:56 -0300
Message-Id: <1305579001-3019-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1305579001-3019-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1305579001-3019-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    1 +
 src/eir.c     |    7 +++++++
 src/eir.h     |    1 +
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 556a537..a274f26 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3091,6 +3091,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 
 done:
 	free(name);
+	eir_data_free(&eir_data);
 }
 
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr)
diff --git a/src/eir.c b/src/eir.c
index d827c7e..2fbd919 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -44,6 +44,13 @@
 #define EIR_TX_POWER                0x0A  /* transmit power level */
 #define EIR_DEVICE_ID               0x10  /* device ID */
 
+void eir_data_free(struct eir_data *eir)
+{
+	g_slist_foreach(eir->services, (GFunc) g_free, NULL);
+	g_slist_free(eir->services);
+	g_free(eir->name);
+}
+
 int eir_parse(struct eir_data *eir, uint8_t *eir_data, size_t eir_length)
 {
 	uint16_t len = 0;
diff --git a/src/eir.h b/src/eir.h
index c7699eb..aacd16a 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -36,6 +36,7 @@ struct eir_data {
 	gboolean name_complete;
 };
 
+void eir_data_free(struct eir_data *eir);
 int eir_parse(struct eir_data *eir, uint8_t *eir_data, size_t eir_length);
 void eir_create(const char *name, int8_t tx_power, uint16_t did_vendor,
 			uint16_t did_product, uint16_t did_version,
-- 
1.7.5.rc3

