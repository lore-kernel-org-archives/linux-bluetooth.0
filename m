Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5881D46A8
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 05:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PPlncuHT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=IO+dk
	AnixD9hpsTyKaQ6W4sS2oMZcVGFzQpHVG50o3s=; b=PPlncuHTTZ5S4PI0Y4rb3
	VOH5lI9FqiY+PbPzCM+YKgXEQP0LVIZ1IcYk4C3HCAWUjOHm7VUBsC+GkqM79YDh
	u3Q8/IWPNh6SxeJDqk3RC74Ba4hlZCZLwZ1W1lOFCbs0qGVuEkUjY0svpMt7iRAJ
	Q8CChUhgjZgoGo8Tr7TXno=
Received: from WH-D-007635B.QUECTEL.COM (unknown [223.76.229.213])
	by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wA3P0JsIoVlI4kACg--.27645S2;
	Fri, 22 Dec 2023 13:45:17 +0800 (CST)
From: 15013537245@163.com
To: linux-bluetooth@vger.kernel.org
Cc: zhongjun.yu@quectel.com,
	Clancy Shang <clancy.shang@quectel.com>
Subject: [PATCH] [BlueZ] adapter: Fix airpod device pair fail
Date: Fri, 22 Dec 2023 13:45:15 +0800
Message-Id: <20231222054515.1266741-1-15013537245@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3P0JsIoVlI4kACg--.27645S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrykKFW3Jw1kAryxXr1xuFg_yoW8WrWUpr
	s8Was5Gr4jg3Wagw13WFy7Wr13Cw4kury0qFWay3Z5CFW7XrykX3y3tw10ya1UJa4DXa47
	JF1DX3WDG3yUGaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jkzVbUUUUU=
X-CM-SenderInfo: rprviiitvtljiuv6il2tof0z/xtbBEhJO12VOBGp4qQAAsN

From: Clancy Shang <clancy.shang@quectel.com>

Airpod is performing inquiry scans in BR/EDR and advertising in a
unconnectabl mode whit the same public address at the same time.
with this featrue, when found airpod device, set the bredr support,
fix it pair fail bug.

Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
---
 src/adapter.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 022390f0d..488355e9c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7066,6 +7066,25 @@ static void adapter_msd_notify(struct btd_adapter *adapter,
 	}
 }
 
+#define APPLE_INC_VENDOR_ID 0x004c
+
+static bool eir_msd_is_apple_inc(GSList *msd_list)
+{
+	GSList *msd_l, *msd_next;
+
+	for (msd_l = msd_list; msd_l != NULL; msd_l = msd_next) {
+
+		const struct eir_msd *msd = msd_l->data;
+
+		msd_next = g_slist_next(msd_l);
+
+		if (msd->company == APPLE_INC_VENDOR_ID)
+			return true;
+	}
+
+	return false;
+}
+
 static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
 								int8_t rssi)
 {
@@ -7281,6 +7300,12 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 		device_update_last_seen(dev, BDADDR_BREDR, !not_connectable);
 	}
 
+	if (eir_msd_is_apple_inc(eir_data.msd_list) && (not_connectable == true)
+		&& (bdaddr_type == BDADDR_LE_PUBLIC)) {
+		device_set_bredr_support(dev);
+		device_update_last_seen(dev, BDADDR_BREDR, true);
+	}
+
 	if (eir_data.name != NULL && eir_data.name_complete)
 		device_store_cached_name(dev, eir_data.name);
 
-- 
2.25.1

