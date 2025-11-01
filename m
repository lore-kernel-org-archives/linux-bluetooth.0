Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC82F656B;
	Sat,  1 Nov 2025 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761998990; cv=pass; b=B/kJQrFMsqZTDeCdKZKj6uPhgKlnzFC0OcDPEtEHtaMeVqXhAVIzQ3hsmVDJlIYhUFTjSb4BMFsfkwTv8vaKLpWcXqz7j6hvPchDx01BBcecrKUDFhH3ATrUvMiXGT81J1hC9R7q7EcFr6is4Fd5l72myt/HkbsWS/cHxzpyqi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761998990; c=relaxed/simple;
	bh=5GowbXN/EZgrbesrJCZ9k1SNps28aEbmEIF6Zf82dw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y94qKdbKHG218iWDn//3mC8ttoyo1MJFI0ISRgn3bpwCYXz3UvbdMy2rMEiAgLse8SUiokfDmpqII0mcZ4u8MkNtBoKFb8wRrK/MIx3abBo2Ip/Rfz5L83QNRyTciN8yQpy+bQ7MkZroflXFfYxlYk/z0iSZERVGzps6DQJoxzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZaVGJZWF; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=WK7JiHY2; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZaVGJZWF";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="WK7JiHY2"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4czGqh1k6Mz49PyQ;
	Sat,  1 Nov 2025 14:09:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1761998976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1UyxUSOD5Goq2WwP89cAoxH8CRpexkFCcQYkQp3UH/4=;
	b=ZaVGJZWFYcxwx3luj4RiM2tRcMl1kuOm01VMcTC66KldxYu5pCTuBEvzzZWjRD0B6+b+/a
	npvI+XXlT5AZ6nwTpCUIQmXuOmUbcnpCByX7AqNiJcVkwawTronwEaJDc+Nm9d6yA57xGz
	yucPy5skyw73Ox2fthO+MNLdbmB8SaoVwtYK/HA/vVVhm96g1AWeWZV5/B3Gsjhr2GIyr3
	njwCzXAh4t29P9UQIwsoUWu55GbGxAoKAI232QB018kEQfoGElkS2ShbvjwaGmkbImJ6K0
	dSD9uhWGl93lwzDyLteqwns3Zli70xDlsEHR8L1dUDf42Hi17DQdfTfcsj7HdQ==
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4czGqT0Ts3zycD;
	Sat,  1 Nov 2025 14:09:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1761998966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1UyxUSOD5Goq2WwP89cAoxH8CRpexkFCcQYkQp3UH/4=;
	b=WK7JiHY2nwa4+eilVqBXe/rwsVr1dDjcra/pN/oGo2yZuHch2RxskJrkIQBhlHstVvSG9c
	1pAlcKp9A4DUzdnQtqly7j57Bf5u0PjqHvojsaah64A7+k6RGh6DZTow0fG/XQXLzD7Hor
	NEHjZ/DMsXHsvdSt3ebObHGVRNrl6pA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1761998966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1UyxUSOD5Goq2WwP89cAoxH8CRpexkFCcQYkQp3UH/4=;
	b=JBgFtYoXoRJIVyuUY+PzdExMDdR717gyhsL12IwlGdgqS4TESIJzUTo75euulBouAr4/ej
	2aPkSfeySKBl67KaOUlNL476Iqjf1ntr/f1TBnHpO9WMPMEktuAYCYnemEBpVqXK7xmh/U
	KlVixqAicA4iX7rn4I8XZKqyMo6UhJQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1761998966; a=rsa-sha256; cv=none;
	b=AqWCSc+0hO1X9Kl/wHYyx0jU5x+zgoN8SEU1mdlDFfQsnvzRwl1Lt4T8c20Nhc9yDLJWtK
	aDHqCO9ndFCZwo7H1s8WeBeaew6yXXNFq9ZOnsfDwv7ZxBsKqTwaJc6zKDcIp7Vpm3YxmY
	i2u6enzOJbbfb+TWb6BR8jmyIlA8bss=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	jukka.rissanen@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: 6lowpan: fix BDADDR_LE vs ADDR_LE_DEV address type confusion
Date: Sat,  1 Nov 2025 14:09:12 +0200
Message-ID: <0d953f217feaafb4ba40281c3ab87e18ad28bae7.1761998763.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <639c5cb6ceb49ffd63952dc69d0d48b022aaec3b.1761998763.git.pav@iki.fi>
References: <639c5cb6ceb49ffd63952dc69d0d48b022aaec3b.1761998763.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bluetooth 6lowpan.c confuses BDADDR_LE and ADDR_LE_DEV address types,
e.g. debugfs "connect" command takes the former, and "disconnect" and
"connect" to already connected device take the latter.  This is due to
using same value both for l2cap_chan_connect and hci_conn_hash_lookup_le
which take different dst_type values.

Fix address type passed to hci_conn_hash_lookup_le().

Retain the debugfs API difference between "connect" and "disconnect"
commands since it's been like this since 2015 and nobody apparently
complained.

Fixes: f5ad4ffceba0 ("Bluetooth: 6lowpan: Use hci_conn_hash_lookup_le() when possible")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/6lowpan.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index f1d29fa4b411..0d8c2e2e9a6c 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -957,10 +957,11 @@ static struct l2cap_chan *bt_6lowpan_listen(void)
 }
 
 static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
-			  struct l2cap_conn **conn)
+			  struct l2cap_conn **conn, bool disconnect)
 {
 	struct hci_conn *hcon;
 	struct hci_dev *hdev;
+	int le_addr_type;
 	int n;
 
 	n = sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx %hhu",
@@ -971,13 +972,32 @@ static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
 	if (n < 7)
 		return -EINVAL;
 
+	if (disconnect) {
+		/* The "disconnect" debugfs command has used different address
+		 * type constants than "connect" since 2015. Let's retain that
+		 * for now even though it's obviously buggy...
+		 */
+		*addr_type += 1;
+	}
+
+	switch (*addr_type) {
+	case BDADDR_LE_PUBLIC:
+		le_addr_type = ADDR_LE_DEV_PUBLIC;
+		break;
+	case BDADDR_LE_RANDOM:
+		le_addr_type = ADDR_LE_DEV_RANDOM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	/* The LE_PUBLIC address type is ignored because of BDADDR_ANY */
 	hdev = hci_get_route(addr, BDADDR_ANY, BDADDR_LE_PUBLIC);
 	if (!hdev)
 		return -ENOENT;
 
 	hci_dev_lock(hdev);
-	hcon = hci_conn_hash_lookup_le(hdev, addr, *addr_type);
+	hcon = hci_conn_hash_lookup_le(hdev, addr, le_addr_type);
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
@@ -1104,7 +1124,7 @@ static ssize_t lowpan_control_write(struct file *fp,
 	buf[buf_size] = '\0';
 
 	if (memcmp(buf, "connect ", 8) == 0) {
-		ret = get_l2cap_conn(&buf[8], &addr, &addr_type, &conn);
+		ret = get_l2cap_conn(&buf[8], &addr, &addr_type, &conn, false);
 		if (ret == -EINVAL)
 			return ret;
 
@@ -1141,7 +1161,7 @@ static ssize_t lowpan_control_write(struct file *fp,
 	}
 
 	if (memcmp(buf, "disconnect ", 11) == 0) {
-		ret = get_l2cap_conn(&buf[11], &addr, &addr_type, &conn);
+		ret = get_l2cap_conn(&buf[11], &addr, &addr_type, &conn, true);
 		if (ret < 0)
 			return ret;
 
-- 
2.51.1

