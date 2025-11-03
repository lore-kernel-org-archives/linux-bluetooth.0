Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107C3191D9;
	Mon,  3 Nov 2025 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194610; cv=pass; b=V1O8j89SbryLyoaSyVxc/VXuQrAv15Y27hI7TwMp9eReJremMRQfkseEvDBViUusHqiy3xI2/3sgIwETzVFJhGWECi3V+T53WYEiJVt5TUgrmjodKmn7gv47sNUbzhdTU18wEqZgxPtxDyGgm3SLFtzIgyAB3lepUA+AJuEV3oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194610; c=relaxed/simple;
	bh=dAtk7PjdtUCEE8bwEBiJz/8MposaZJw9t+HG9q2CUWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BM5B7l7tw1UM3LxbeRBt8ejCnUmByV2Vv8EZ02y9d3vp++JXckh+7+5iSdR0RjpZs3CHX8eoTtYJ18Q0Wc4OJB1gHB79A40WckWNBtBnVAdQfBk2hiEPuYQM02Ip5sBLf/HSps4VjJ78azOgOjqAemuLjUbV3/PoLIyNkKd2WjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=OEPzuMJK; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="OEPzuMJK"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d0g9d3WRxzyVm;
	Mon,  3 Nov 2025 20:29:57 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762194598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuSwtvvZqe+BLLG64FkSWUw+vGdNFwr6lb7MZdWqlUo=;
	b=OEPzuMJK6KJ2RaTgAd7Ikh2B9M2i1/bFFXE6sqJFPwbNvyzsPA2toBpjOM3+KGXsMtOij7
	p16hf+vA+Gh7u/r+cf/lgfek0Bj/7DMONZlfsM0liUyZQTYw+9rJ+UFazaZUphuiCv9EdV
	N4CB/0VNkfKOVuuAtSh/EPEqY/2+zuc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762194598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuSwtvvZqe+BLLG64FkSWUw+vGdNFwr6lb7MZdWqlUo=;
	b=aG8v3AXh5Vde6Oyz2ai6kt94lKayBmmoPvFYnlfA4uRBVZdR/PxDVXhgsqH3awGqsiaQZk
	9Lq+0xu8/qFhu9ftI4I++hFTUXsDSJ30W6V472fW8VFO0tBkrKGlnGKKKDXsm9rzef3vyQ
	tuENKyfI3ia1arlS4wt/ozlGpE9Jr2o=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762194598; a=rsa-sha256; cv=none;
	b=Yaj9/q/Jfr90pC4ICQG7okBhTMN+21CcOW0RNICs/u6Qbl4Q3dn18+5adoS8AV1Vswp2Qr
	9TX1ivWchx/+q7kNcgm5bKDKo+2XPw+H/KWHNyw6FrQOQFHtMr5tz2pZcgfDCLV7I/q1/f
	CVX9RgIyCtd9YLgVr+kK860R6VV0NZY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2 2/5] Bluetooth: 6lowpan: fix BDADDR_LE vs ADDR_LE_DEV address type confusion
Date: Mon,  3 Nov 2025 20:29:47 +0200
Message-ID: <3b858ba8d70039751285ff33e70fc72ef61f74fd.1762194056.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <467024bf1ba60184bff304d23de33abb0ed2384f.1762194056.git.pav@iki.fi>
References: <467024bf1ba60184bff304d23de33abb0ed2384f.1762194056.git.pav@iki.fi>
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
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - no changes

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

