Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E93535E549;
	Sat, 17 Oct 2026 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206636; cv=none; b=fGtA34mpSXjgFcP4Gp8WWte2yk3hEG/9UVSqdkfCrGoS8rC/R8woYMofqB4Maoy+VUw9kFmVFGgrvhq2ctjJxv0Sv/G33lFBfikvrRrBoxyyUbKkTjItMcxBcmuSD7CRZPp0MkayGqpxjdsUFOMWdIp9AeJg+bOYN/KWCLI4itQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206636; c=relaxed/simple;
	bh=EydJaeOPcgnwYauQrlKCmQrwboRabxLcEK0PX6C3A8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XmbTcg7+694E6T1X5/nTe39S1aPglj/ltkmQ8e4GNlyhzhcrEdiewQaeRzWkQBy9Gt51O0yKJB1J88kqA2OLmnw9Prp7WpXW8rFppLqlLJ4HW42dICO5vHZMk6NYnNST8pgr6APSM8J1Yy5zIHlciMTLnTqDJdha76S+/LKSM5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JLafZMES; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JLafZMES"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zo
	sLx/Bg7cCgbn2DO3c2rWFDXN4Y30T5DuUHyaOcvoE=; b=JLafZMESWcODdl9K9L
	PjfhI/gjdA471r4/rfusWesTM3cq47oQhAyWcO+nsFDgsioJwLUc8q9lHKGxGh2+
	X9e80yaZhJmw2O40H0WmPTCX5EBjEN86fPIX3fO5TfBu6IH4eB83FTYNc4xolapI
	pDDF6KqeH37XCfQIMfmhQzYM4=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3Pw4g59JqTu_FAg--.28809S2;
	Sat, 17 Oct 2026 11:10:24 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 2/2] Bluetooth: msft: free detached address filter on cancel
Date: Sat, 17 Oct 2026 11:10:22 +0800
Message-Id: <20261017031022.3616384-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Pw4g59JqTu_FAg--.28809S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWDWw1xGr1DKryfWF47twb_yoW8Aw1kpF
	9xG3Z8C3y8XF47J39rAr4UWF15ZFs3u3W7ur48u34FkFs0qrsFka17CryUt3Z5ZrWkJw4I
	vFs8tw4xXan8Kw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piYFAdUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8ABRi2rS5yBBXgAA3K

An address filter queued for addition can be detached from the MSFT
filter list and marked AF_STATE_REMOVING before its command-sync work
runs. If the queued entry is then cancelled, its NULL destroy callback
leaves the detached filter without an owner.

Install a destroy callback that frees a cancelled filter only when it
has reached AF_STATE_REMOVING. Filters that are still linked remain
owned by the normal close cleanup path.

Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 net/bluetooth/msft.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index d9dd722db3eb..b9f8f089cc72 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -928,6 +928,16 @@ static int msft_add_address_filter_sync(struct hci_dev *hdev, void *data)
 	return 0;
 }
 
+static void msft_add_address_filter_destroy(struct hci_dev *hdev, void *data,
+					    int err)
+{
+	struct msft_monitor_addr_filter_data *address_filter = data;
+
+	if (err == -ECANCELED &&
+	    address_filter->state == AF_STATE_REMOVING)
+		kfree(address_filter);
+}
+
 /* This function requires the caller holds msft->filter_lock */
 static struct msft_monitor_addr_filter_data *msft_add_address_filter
 		(struct hci_dev *hdev, u8 addr_type, bdaddr_t *bdaddr,
@@ -959,7 +969,7 @@ static struct msft_monitor_addr_filter_data *msft_add_address_filter
 	list_add_tail(&address_filter->list, &msft->address_filters);
 
 	err = hci_cmd_sync_queue(hdev, msft_add_address_filter_sync,
-				 address_filter, NULL);
+				 address_filter, msft_add_address_filter_destroy);
 	if (err < 0) {
 		bt_dev_err(hdev, "MSFT: Add address %pMR filter err", bdaddr);
 		list_del(&address_filter->list);
-- 
2.34.1

