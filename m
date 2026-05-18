Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1773C3DA7C2
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086767; cv=none; b=aqufRJ37YjChiURSNzS+pVeE0itGUGyVnD2PS4z9bmNGLd+q+wy+7ZGKzOv9rZQpUv5DF9ZOc/I+mtjGj0ADNra5NVooZs6GnQZSs9Qq4vBPYe+zuSnUkqN90idQA6Ylizyopb2JXC/tqMYOuC60bVRHLMYx5CS2/dld5TpGl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086767; c=relaxed/simple;
	bh=XerD2okT+tHInJPlMYxA2PKHPRugmv36/s4SgMdNcbk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ag18uJ8b+BugbiSKzbOyNS3k1c7mqlemuIfZm/MIXD3/9zZZSsJaLmEFDRPF67ad3xI/8VEJF+MzO9kvhEA3FvUHRQQq2qypXi8l2a/6xCUOJqC33OPWigakQL8gzK+LuswriOYsAjXEr4Q9uuXgBKAVGxhUfqXS6QGcIehgp2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=JjyJ6GM9; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="JjyJ6GM9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779086751;
	bh=V58VINb+jT86KcNNV0WJtmZsx5Ez7byCtNTIqK8vHss=;
	h=From:To:Cc:Subject:Date;
	b=JjyJ6GM97SfJHPeAjBQQt50XYg2v18ZCnAXZZjCxeusmWLPKufa8ZJcmvWP6+CtJT
	 5jMYlshcBbhwdvW+ZCqaFwR2A/HiHUqEazdGTSQsBuHEHhst9rBnCcxrbrWqUj2naA
	 LZ7FcrdrNNpRacjvtfo8m6EsT8X1jSg78Gk+OK8U=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id B71AF264; Mon, 18 May 2026 14:45:49 +0800
X-QQ-mid: xmsmtpt1779086749tf9o73qdm
Message-ID: <tencent_017770C54B37BDA20BEEC119272E1AED0608@qq.com>
X-QQ-XMAILINFO: Nte9/BsRzcszWfSX6PdJ8bhTdGoJuqvJ5l9YdLivlBJBGkM5uLurJUrLKnE4tQ
	 X1/Xumq+0AcIbBpCWd/ep423dcq3I3cEsZwk88scJaKChaBPCGU0fVG8HQXUeqxbXion6hhWVTbQ
	 mC0NZD5mR6rucgGigLYdp8cZcJjuD7jvBUZwJaaP2rpZzr3nd5Tsq0+uECgqzccg2XWtN0LzQCzJ
	 vvtzOVuEDuHJx+QlpNTnjWWQ26536gyAZZjg51FiXVkbAPR/qh7Vi1rctftaN5IgfaDPM5kq9WP8
	 el4UfX/VGRSJXQg+tE1dYhNLzT16mTd9zl/HCf2WYDf5y4qln0t+XHzHAWNYt1L79rdK1Zz1uXwJ
	 dq3mJogQHIiz2KcxBFQOZ4kIkprMNDVbN7ua69YqnL22Etes1fE0XxvJpzLo/KH4MifW7merDC/t
	 LOGn5FPmMiCEIH7DESjwFprjwFbBr2+Laf5WEGaEntRaT7H8lMPwWS2Tp95VKXygvytxIGWWExmi
	 l0OEi8Y02WnG77pm7wnOAL19C4gsNxiPX5zKtyWZsc3Z84ATDdowEXFImD2fvHb2cv0kyD53FB+F
	 fh7xyERtLPsitPdmISq4BXxbL1ovvSYEBRfDfDj7TwR+QUf/ePfFa29IuM647uead4QJ+qzaouOO
	 UWgUPuKijxewxGXaBx+fVGvgG4kLe2uV4VhfG0E9Qf1fp+7prjhISVLE5vvQNaba2c5qRPbP6kKJ
	 6sIPAntzCbisoWEq51cS+c/DxC3oOyLeqVpGIRn5vjT23CQ36GEruYDKebvnd0i7D0jqLl/EhS0s
	 OccxcwoTc9xij/E3gZ0TLw8O78p1df2/ADNATYdHlDOU1tZhxPza3dNkGEPnf4hJh7UgqIJre1ZV
	 SqFpgAqiVO2KK83z4gQXgtB1m3872np8r1CxHex/dTOi1FBdyZ3QP67C6A7ZAI7ZZF8w8IbR0ZDb
	 5Y2sG2wmVhe9UJwYrH+SCsAcFRQxMvTWajDVLS3KMiqGgDKNNLXkS8vwOB1utWcbv6Lgc5yNWN24
	 /UptWoYZKUzWJMIYtUcTNdF68r8gytz0P+OGbB0jSAebfHCKXXabC0XGYjAPkoOdETOOuV4A==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Zhao Dongdong <winter91@foxmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: [PATCH BlueZ v2] device: fix inverted NULL check in gatt_db clone
Date: Mon, 18 May 2026 14:45:32 +0800
X-OQ-MSGID: <20260518064532.408904-1-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

gatt_db_clone() returns NULL on failure so the condition was inverted.
With the old check a successful clone (non-NULL) would return false and
skip swapping the device's GATT database, while a failure (NULL) would
fall through and dereference a NULL pointer a few lines below.

Fix by negating the condition: only bail out early if the clone failed;
proceed with the swap when the clone actually succeeds.

Fixes: cbe4144dea6f ("set: Attempt to use existing set gatt-db")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 28515054c..bea893301 100644
--- a/src/device.c
+++ b/src/device.c
@@ -7896,7 +7896,7 @@ bool btd_device_set_gatt_db(struct btd_device *device, struct gatt_db *db)
 		return false;
 
 	clone = gatt_db_clone(db);
-	if (clone)
+	if (!clone)
 		return false;
 
 	gatt_db_unregister(device->db, device->db_id);
-- 
2.25.1

