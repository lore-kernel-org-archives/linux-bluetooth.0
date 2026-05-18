Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46F9287510
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779070401; cv=none; b=KA8P9TYdI5t2RGsvJvBJ+DkRdB6k0Mf0ktVwykRm+mZF370xj2erik1mnlBz/IhkOvWdRwxdgJyCoWiGXb+Q8jgL056simrPpiXZMT8SMXMW05GlVA9qgOtgi4jmN1H3nbgiLoN1i+AZybBnX9chRzS9eMvLUro7V33fwOGrRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779070401; c=relaxed/simple;
	bh=CvXlrQgt5nbjic24fVRRrqtlMrYzoMpTclQwXdzzzKA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=U54GLRMKDGkKA/8nsPImMqTxN3H257LOj/kP3cvUknMGlRibbqdSBTV40tHhd60fBpHYMH7IvP6vRXxiOTX64sRBjN8V3arfF8Au51OMOBjHHpMahSLUC3oOPYVY7d7HDAVAuegd6t9/maA4QbaiIu+mgrtapbX0US0MiuheYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=S/4jA/6o; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="S/4jA/6o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779070391;
	bh=g3aApX6ZvDWELzM4Bkx755eOMaWEW0Pzm8qHjexG6Gg=;
	h=From:To:Cc:Subject:Date;
	b=S/4jA/6oaQTAybA17ONd8ZdKtIyqztpGkZ+eW16ePS7fJj1q/s1MnBe0ktS2+Y/Nv
	 7Cm4d1HYnJC12PHKsbeOVDgUYCuqntTIvnrib2EN/BJpqbxoZ6YVyzyDKUTKxsgNG1
	 XY/5wpJSCT/jSe+kkPTtzLMDdeuUmcUdthvjiDxE=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 349946AE; Mon, 18 May 2026 10:13:09 +0800
X-QQ-mid: xmsmtpt1779070389t5zb098fg
Message-ID: <tencent_9B9A0B74FBCC9D4EF1CA4D8EE89DFB444606@qq.com>
X-QQ-XMAILINFO: MpvrJ5NyRx5iSleeuldDu2cxMw0Pp88Efsews//Ips+gsw7AcGRaucy56hPVw6
	 TFKD5T+mCu7Nie6tVFwlnBlfRds2INGQEV+YdWvS/4z0n+sMwvjDDjurCDC7EUihn/7i771Vob1U
	 82RibGSxiUEFD/97Pj+BBHe5JOP+x61JiE+PVwl4eclEXWxpijpNA2i/EKMjx15c6j5RW6d8d6eN
	 UgaJCF74frIw+ByNJTejZ4lQ4Gxnz5HSskEUU9UYXtDy3lze699yCx8S5d62zGT5Hq9/ZZuICWBr
	 FVXS0TSd2yPwrL/C+PLaVgdr0JA9VwwfLnSajFI0YCEua/BX+iaZaUMXf8/3AKGcY78oKnE+qHqN
	 Fho8cvk1AugS1P7nLS7aASg6CyONxrSaQiI0DuqEg8pVueEAoVu4W8iPkb4w7YsKdvyXsTHVVQ8c
	 PDZXAvOC0TIlYHayrou8kC8hPpn8qMMnm0sH0vKE5QI4cjcmY2Yu+77wuRtzhtmRookRMmw4+o8m
	 T3NE3ABboYUlY5HtNW5IktB0tJ+x6H/1QoaegqYtI7K1UDVyWXxnzLXE9K+Fa23vcZg2xfyf+7tW
	 H9O4JIksQP25fSOPofz5m6YxHs54DoaB+ydw8jNpYfAhcUH8dvQyr1fe+Axkd5UKIKCD8zQH24OT
	 gDZ3JAzMVwGLogS6FC079sWqxVxnkGucwN2Vtm/Rj8ZuqJMRu3fl5llVeVMmJ9oegjYI3F9wluyr
	 u5IxoL0Bm1fXvHqZRBFt+qwFE8LYvOvTOIzXwors1FxGkSaqZG6zf8MDWNlzLnaCOXcgUO/ZDD7a
	 F3B08rf8QzbC8cgOSxaDOreU0E7koUxr1pNrH6vYgvwpHdvsRhR7IdNz3uQcvwklU8ACZ3uTnfup
	 VhqesC8LySzr7GbIceepTca8st1X1HcBbYybw2YJmkiT9lbsqxMzrwzQbnnXr+Pr7dmopu1/7gtF
	 DGMJvMRnOjn5ET15qoyP2VPOGhOSlpzaQ7jL7wWrd1w9jFG8rW8VikvXewXYIts1rvhz5q3vFMR/
	 T7x9VmFA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Zhao Dongdong <winter91@foxmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: [PATCH BlueZ] device: fix inverted NULL check in gatt_db clone
Date: Mon, 18 May 2026 10:12:40 +0800
X-OQ-MSGID: <20260518021240.87483-1-winter91@foxmail.com>
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

Fixes: cbe4144 ("set: Attempt to use existing set gatt-db")
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

