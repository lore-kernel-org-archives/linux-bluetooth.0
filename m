Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 2/3] adapter: Add support for setting DID info from EIR
Date: Sat, 18 Jan 2014 15:57:13 +0100
Message-Id: <1390057034-7983-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1390057034-7983-1-git-send-email-szymon.janc@gmail.com>
References: <1390057034-7983-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 230f3ce..c117508 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4147,6 +4147,13 @@ static void update_found_devices(struct btd_adapter *adapter,
 	if (eir_data.class != 0)
 		device_set_class(dev, eir_data.class);
 
+	if (eir_data.did_source || eir_data.did_vendor ||
+			eir_data.did_product || eir_data.did_version)
+		btd_device_set_pnpid(dev, eir_data.did_source,
+							eir_data.did_vendor,
+							eir_data.did_product,
+							eir_data.did_version);
+
 	device_add_eir_uuids(dev, eir_data.services);
 
 	eir_data_free(&eir_data);
-- 
1.8.5.3

