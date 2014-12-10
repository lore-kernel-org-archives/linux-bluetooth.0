Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/4] android/bluetooth: Start keep IRK for adapter
Date: Wed, 10 Dec 2014 15:16:11 +0100
Message-Id: <1418220974-12287-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418220974-12287-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418220974-12287-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 48ca231..e9c5be1 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -176,6 +176,8 @@ static struct {
 
 	char *name;
 
+	uint8_t irk[16];
+
 	uint8_t max_advert_instance;
 	uint8_t rpa_offload_supported;
 	uint8_t max_irk_list_size;
@@ -196,6 +198,7 @@ static struct {
 	.index = MGMT_INDEX_NONE,
 	.dev_class = 0,
 	.name = NULL,
+	.irk = {0},
 	.max_advert_instance = 0,
 	.rpa_offload_supported = 0,
 	.max_irk_list_size = 0,
-- 
1.8.4

