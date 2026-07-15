Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A73E2E7365;
	Wed, 15 Jul 2026 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104569; cv=none; b=S8LM+SRX7XpUwwueCK7LLjsVMsNC9jH5sgfpP2FvLZPwkX+7TPJab78XUtQuPIxlMUoahaN0P0MlmWcdTTpqtzVlvE97PApDKHODsNHyO2p/V9N/wVrMR/1/gKhe7udqoKTO6Zvh07Pui8eBeWuqjT3TyjQpsihWm/AIO604rQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104569; c=relaxed/simple;
	bh=veCD3K8Q3dVLi6XqB97BswAEquaVcb2rZA15NOngp24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BsZOz9KeGAyZTtypxLfb0WThn3Ibes6MyUio0Cw4CUtwimHMkUDsvfCEmBGtU9+ZaNgL1WXj+EOUOyWdPXdw+4WkeFbgdsqgx998/q192nqyQ/urBQLWwbbpxOtIUEAvJBV//Z02BrrLErohDMnwilt6UpozsrGpN1O+hlLgb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowADHNel0RldqeExHGA--.5090S2;
	Wed, 15 Jul 2026 16:36:04 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] Bluetooth: btrtl: validate config entry bounds
Date: Wed, 15 Jul 2026 16:36:04 +0800
Message-ID: <20260715083604.28393-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHNel0RldqeExHGA--.5090S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1rGryxWr4DCFy5XFyDGFg_yoW5JF4UpF
	WUWFyYy34rJF4Syr4xtF1fCFWY93s7Way2gasxur95Ar43CrWrCF98KrySva4DCr4kGr1x
	ZFZYqF429FWDGFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeKsjUU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

btrtl_get_uart_settings() walks variable-length entries in an externally
loaded Realtek configuration blob.  It previously checked only that the
cursor was below the physical data area before reading an entry header and
advancing by its declared payload length.  A truncated final entry could
therefore make the parser read an incomplete header or consume a payload
beyond the configuration data.

The format gives a logical entry area in config->total_len.  First prove it
fits in the physical blob.  Parse only that logical area afterward.  This
preserves valid physical tail padding while requiring each fixed header and
payload to fit in the current logical configuration area.

Fixes: b85b0ee1001b ("Bluetooth: btrtl: add support for retrieving the UART settings")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/bluetooth/btrtl.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 49ecb18fea45..fab9a59a1eb4 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1460,11 +1460,11 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 {
 	struct rtl_vendor_config *config;
 	struct rtl_vendor_config_entry *entry;
-	int i, total_data_len;
+	int i, declared_data_len, physical_data_len;
 	bool found = false;
 
-	total_data_len = btrtl_dev->cfg_len - sizeof(*config);
-	if (total_data_len <= 0) {
+	physical_data_len = btrtl_dev->cfg_len - sizeof(*config);
+	if (physical_data_len <= 0) {
 		rtl_dev_warn(hdev, "no config loaded");
 		return -EINVAL;
 	}
@@ -1475,14 +1475,25 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 		return -EINVAL;
 	}
 
-	if (total_data_len < le16_to_cpu(config->total_len)) {
+	declared_data_len = le16_to_cpu(config->total_len);
+	if (declared_data_len > physical_data_len) {
 		rtl_dev_err(hdev, "config is too short");
 		return -EINVAL;
 	}
 
-	for (i = 0; i < total_data_len; ) {
+	for (i = 0; i < declared_data_len; ) {
+		if (declared_data_len - i < sizeof(*entry)) {
+			rtl_dev_err(hdev, "truncated config entry header");
+			return -EINVAL;
+		}
+
 		entry = ((void *)config->entry) + i;
 
+		if (entry->len > declared_data_len - i - sizeof(*entry)) {
+			rtl_dev_err(hdev, "truncated config entry payload");
+			return -EINVAL;
+		}
+
 		switch (le16_to_cpu(entry->offset)) {
 		case 0xc:
 			if (entry->len < sizeof(*device_baudrate)) {
-- 
2.43.0

