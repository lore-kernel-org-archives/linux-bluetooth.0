Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7057FD
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 05:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721626057; cv=none; b=VKyiKbwqpgzfuajEZHZDfml+nkdsCe2ZUWpWkvDPYvRZKvvI+KD1l0K5XQFKVkU6xfFaQ9M6QGyRVTgR0mQiuvPAh99uNPSmGyDvU0M6QCt+8FlKQ2HcB2QFt0/CAFuQOSDaRDwkem6GpdDbsIJ+uqI6uLvKW5oEsEYd1VVIbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721626057; c=relaxed/simple;
	bh=DfqbiCYSGMErQPz0qg/8Qb49nz3raUi19FsDEXaiku4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ioUlrbw2HSLjoSyUWVO3yqMGKhhNtame7wT3Jgc1h2birXZkluEhOBrRzQXHjfpXCYtfdhITK8LwYP5vsCtK0DhYYf+TluP+eeetwL6W6y3UAMjj/PPeDnYIOdmGtX1vPbeA5SntxB/Wgc1EpSpugShS8cVHi92ZVrIxDB52c7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cDUOr4/j; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cDUOr4/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2CCoo
	Pk7ccH+3j9HdeT5Dg9uyvkIjDzitLjS+912XRI=; b=cDUOr4/jIZKXsCy5KHy9O
	1+7yZnGCoEaQLCQjvDCWX/ftr1MxZRImCfCz/d5plP1mN27WhS4Kxs9o8Rbhp3bL
	YPw28nVjS4vsc8dnG8e53PDKrpHHSnWd3iY8XE1VsvmJ+ad8pqYm9ydNjevj6GVL
	Q4v6lJN6px0JWAkYn0IkI8=
Received: from WH-D-007635B.QUECTEL.COM (unknown [223.76.229.213])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wDnj3q87Z1m82dDBA--.13110S2;
	Mon, 22 Jul 2024 13:27:26 +0800 (CST)
From: clancy_shang@163.com
To: linux-bluetooth@vger.kernel.org
Cc: zhongjun.yu@quectel.com,
	Clancy Shang <clancy.shang@quectel.com>
Subject: [PATCH] [BlueZ] adapter: Fix execute "LE Add Device To Resolving List" command fail
Date: Mon, 22 Jul 2024 13:27:23 +0800
Message-Id: <20240722052723.3031061-1-clancy_shang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj3q87Z1m82dDBA--.13110S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFy5Aw15AF1xGr48Wr1rZwb_yoWfAFg_Wa
	18JF48WrZxtr1Fkw4rXF1vvr1Iy3yY9FWkuas7tw18AF1jqrn0gFWDXrsF9r1UJ3yYkw17
	AFyUt34jy3WxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU2-e3UUUUU==
X-CM-SenderInfo: xfod0ux1bvxtlqj6il2tof0z/1tbiUBEkuGXAmA90mQACsA

From: Clancy Shang <clancy.shang@quectel.com>

According to BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E,
7.8.38, If there is an existing entry in the resolving list with the same
non-zero Peer_IRK, the Controller should return the error code Invalid
HCI Command Parameters (0x12), so fix it.

Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9195edd7d..8823c7e3f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8978,7 +8978,7 @@ static void delete_exist_irk_from_directory(
 		if (irk_info) {
 			if (!memcmp(irk_info->val, key, 16)) {
 				DBG("Has same irk,delete it");
-				device = btd_adapter_find_device(adapter, 
+				device = btd_adapter_find_device(adapter,
 											&irk_info->bdaddr,
 											irk_info->bdaddr_type);
 				if (device)
-- 
2.25.1

