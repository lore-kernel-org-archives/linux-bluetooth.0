Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355FD28361
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bOOD+KrU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1+wOy
	CxuFdRwkRbseg89dpr/73zEQYpQG6NBYdROfvY=; b=bOOD+KrUlstkg133Z87Tl
	1nCzu0PHrTxr0v+SkFqt9wr12/hZCQ96amloIvi79kXWPSOrdzhZ8uAfDYBjwGvD
	a7W2za9/b08imAWtCQ2XUoAOZh9oalY631SgfPYxf+kjsrFGxwu/W5URB9ysGSFD
	SFSZaPTWsxESGSFsUpXzLg=
Received: from WH-D-007635B.QUECTEL.COM (unknown [223.76.229.213])
	by zwqz-smtp-mta-g2-4 (Coremail) with SMTP id _____wD3_xIFc4plKn8gAQ--.50646S2;
	Tue, 26 Dec 2023 14:30:30 +0800 (CST)
From: clancy_shang@163.com
To: linux-bluetooth@vger.kernel.org
Cc: zhongjun.yu@quectel.com,
	Clancy Shang <clancy.shang@quectel.com>
Subject: [PATCH] [BlueZ] adapter: Fix airpod device pair fail
Date: Tue, 26 Dec 2023 14:30:28 +0800
Message-Id: <20231226063028.2457072-1-clancy_shang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_xIFc4plKn8gAQ--.50646S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF47Kw4UtFykWF1rCFykKrg_yoW8WrWrpr
	Z8Ka95Gr4jg3W2gw13Wa47Wr13Cw4kury0qFWSy3ZYkFW7XrWkX3y3tw18ta1UJF9rXa47
	JF1DX3WDGw4UKaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jQNVkUUUUU=
X-CM-SenderInfo: xfod0ux1bvxtlqj6il2tof0z/xtbBzQxSuGVOBDA1LgAAsv

From: Clancy Shang <clancy.shang@quectel.com>

Airpod is performing inquiry scans in BR/EDR and advertising in an
unconnectable mode with the same public address at the same time.
with this feature, when found airpod device, set the bredr support,
fix it pairs fail bug.

Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
---
 src/adapter.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 022390f0d..71f7ed86d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7066,6 +7066,24 @@ static void adapter_msd_notify(struct btd_adapter *adapter,
 	}
 }
 
+#define APPLE_INC_VENDOR_ID 0x004c
+
+static bool eir_msd_is_apple_inc(GSList *msd_list)
+{
+	GSList *msd_l, *msd_next;
+
+	for (msd_l = msd_list; msd_l != NULL; msd_l = msd_next) {
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
@@ -7281,6 +7299,13 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 		device_update_last_seen(dev, BDADDR_BREDR, !not_connectable);
 	}
 
+	if (eir_msd_is_apple_inc(eir_data.msd_list) &&
+					(not_connectable == true) &&
+					(bdaddr_type == BDADDR_LE_PUBLIC)) {
+		device_set_bredr_support(dev);
+		device_update_last_seen(dev, BDADDR_BREDR, true);
+	}
+
 	if (eir_data.name != NULL && eir_data.name_complete)
 		device_store_cached_name(dev, eir_data.name);
 
-- 
2.25.1

