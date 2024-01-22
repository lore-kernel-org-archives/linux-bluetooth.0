Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4489A64A96
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939503; cv=none; b=KlK9kcb1B+kDb4i+VHkb/rMmUrQ7otIBV2yP4UgxBKKySKKXRjHeyNpElJLxmFw+GBiFMvfOmx3RqqrAQ3pXimcmsRkGJwhn8VuX7Pjz339VrRzjML1pgmC0h8wX0uprYD8ZECtde2nKFw0W+SciHNyDsfi98fG9fxuQfUlISUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939503; c=relaxed/simple;
	bh=vZ3u219SkU5oVGHBkp9Sjp2g/zobncmCdXb4FGQnXy8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=at3vq9dwqBYNkQx4i9dY7tUN6Pe/m4O5FyDNXodab2yIsyxyQU0XxEeQB3s4Nyl9rtAonZurxJT5L08YWsX34mtSOJFqa52+ytq5Tfl7xa1WG42ifWDtDN6d6j+Q7U/mcP6pVE2ceeFhz4opHE7CYYlNNGSCKwp32SEARRapL30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kpi3uDdi; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kpi3uDdi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705939499;
	bh=vZ3u219SkU5oVGHBkp9Sjp2g/zobncmCdXb4FGQnXy8=;
	h=From:To:Subject:Date:From;
	b=kpi3uDdiTi5MNd2JRNKGBCLXLrQQ4cbsbvj+kCarjXkajQNXgKZYETUIVu/rdqrhI
	 /MSbhVhYFWztN8ikZO0M2V5+HdgxwM3fWgJ03IRv6jCi8A9067WIZPNloXGt8AwK5t
	 U0wRabC4bKxa5RzizBo1k2hmtnMtNO30bqr25SZAxqoBxsaee596Jd/+xbUqY8dbgH
	 kP+nhwxy/kjuypb1WXvr0DEsBf6Su4p6wewZpbPhpCfVk4dJH4hJ4x7Zj0zb/hgLAK
	 lCeX2MErZ/bTeOZ9/Uy2skvcYBAFQz1RTkkqSlUU7dJaLtnXBSfEpVopMgp1X2W+0c
	 +30GbTdOGJYCw==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 418223780029
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 16:04:59 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: mgmt: Fix limited discoverable off timeout
Date: Mon, 22 Jan 2024 17:04:53 +0100
Message-Id: <20240122160453.270919-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

LIMITED_DISCOVERABLE flag is not reset from Class of Device and
advertisement on limited discoverable timeout. This prevents to pass PTS
test GAP/DISC/LIMM/BV-02-C

Calling set_discoverable_sync as when the limited discovery is set
correctly update the Class of Device and advertisement.

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 173986f3405f..c5022c90584c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1063,7 +1063,7 @@ static void discov_off(struct work_struct *work)
 	hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
 	hdev->discov_timeout = 0;
 
-	hci_update_discoverable(hdev);
+	hci_cmd_sync_queue(hdev, set_discoverable_sync, NULL, NULL);
 
 	mgmt_new_settings(hdev);
 
-- 
2.34.1

