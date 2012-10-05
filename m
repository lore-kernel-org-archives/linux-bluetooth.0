Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/5] adapter: Don't use adapter_get_address to access adapter address
Date: Fri, 5 Oct 2012 14:54:37 +0200
Message-ID: <1349441679-18557-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349441679-18557-1-git-send-email-szymon.janc@tieto.com>
References: <1349441679-18557-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use struct btd_adapter directly to access bdaddr member.

---
 src/adapter.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7e695b9..885d232 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1884,7 +1884,7 @@ static void create_stored_device_from_ltks(char *key, char *value,
 					(GCompareFunc) device_address_cmp))
 		return;
 
-	ba2str(adapter_get_address(adapter), srcaddr);
+	ba2str(&adapter->bdaddr, srcaddr);
 
 	if (g_strcmp0(srcaddr, address) == 0)
 		return;
@@ -3626,8 +3626,8 @@ ssize_t btd_adapter_get_pin(struct btd_adapter *adapter, struct btd_device *dev,
 			return ret;
 	}
 
-	return read_pin_code(adapter_get_address(adapter),
-					device_get_address(dev), pin_buf);
+	return read_pin_code(&adapter->bdaddr, device_get_address(dev),
+								pin_buf);
 }
 
 void btd_adapter_register_powered_callback(struct btd_adapter *adapter,
-- 
1.7.9.5

