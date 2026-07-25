Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1954C346AC0
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784973774; cv=pass; b=Z3IX60F82D5pvEVKl9G9uIEoLnqhTzmMgbDKvN7wX04oolHNulm5jH7szekbBsKub4ksyOh0xrzYXVcwQxQ3SgdTtrswpnQucuG4N1srz90ltTJpJNEX3lzswdJKgM8skfejIH2oP5Sgcj5A9fpjvUrmvxwi+6xVhHAox6/mCV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784973774; c=relaxed/simple;
	bh=QgpIRQN8FBDT8NG+biWkaUzGCCxT12wy76QBf2JYfmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G2yJbFU1IB0AF9jW1k255S86EDn8UgTM82c1QvpLhOJ+4v1vh+MvCvFCAPECVD1cQDY6F5+5pr5LrKOGknZXfZKkoJ739ZHBH53+P91K/4o2df0d/u1KmDnSOquCNsakAB6QHq0hY1zcOT8gTOFIbpMwNgrR4V/o+dm6lZPuKXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=lYjpBYuP; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="lYjpBYuP"
Received: from monolith.lan (unknown [185.65.133.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4h6gQW5nGCz49QMh;
	Sat, 25 Jul 2026 13:02:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1784973764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tINuCDy+cBxAKSWRL8FvKdEE3IaCz4mL6Q/s1A+gUwc=;
	b=lYjpBYuPInZTHy2Isr0FmlWdseyCJuE4j1dM+F90ILjddjGvw0pTTLskIVcMNJPCojSOcY
	5+xDjiZ3SpPve5yPc1GJYYDUaitS/hg2aubFGMZK33zGAQu8MrVFfIyqABJH1y5nwEi6zU
	PszSqv6+K3QLE6mKPEYy8jmDD0wUdPuu12rpeTl06T6qKCNt8Hpse+Um3Ll0dpSveeWms/
	dNtVtKVaGBdx6AsH/sVTg4/6RDFssMTcKYs/QcPzG21f08QPn23U5egq5ofyka4qqcuNfq
	2MF2qvJyInU72VakbjcAOWSpo/OZXyjHi0IGWbPg90EDrNv2i/Gr/naCfICIZg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1784973764;
	b=SaZVdxENmGVsNxNV18UoojzijJGv/JgRTzBhDxvNoE3UgeYX70mRHgnziOjLunmVaYPZMf
	Odncipzbe1HhKBlCCSQESgTvfLqR1/5xBHhFSmTKuX7B5prk0PWal7noF6dd/DgauL8vbX
	EIq4/m3iPYhCAmCDnSS8mNtcVOA8ZhtwrtCoO+HRp5gSAgJEwMmKZDQr/gsvmKJ5XrCt/8
	p1yjXwsligU39+9swIoIMT1O4qJIfxkq0LO7YEf13812wZKu4spdN0HJgq8C0FmfBf46da
	8j6rVhb4SrhjL/iNR21yBtbkNt9/UL90s2nlgGDa05XBEI4+WGxBqIBUUgjgFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1784973764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tINuCDy+cBxAKSWRL8FvKdEE3IaCz4mL6Q/s1A+gUwc=;
	b=rvuMegRdJ533mQOIvlhypybiMvi1SpHGkr8wqrHbnDWpatmW3ojD2snMD6I9dzgZ+3nE/N
	Fv3tfPJNuERNweZ2bJjQwCeTHjJjCDWtlbTsMp92I1FKCgbvMLeXZ65yE2z0uKZ+EDbK2O
	hvKEp79xOpzeAXzuhlrElc34xo87CUHO5QTE3oqpxd1+R4m9YStTfvDvC1jk10JIt3z67q
	1Ie3TMFoBl33rwg7PiEqN8kRssr3OjYDoP8ft9oY4vdnYfaJhcHf5+u93gUDPsRlteIBm/
	ccteTtA/mjIVm1eGx+76TtthaAw3NH6s/x3nDbURCXirxI0xadmr+kXBN36fEw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: hci_sync: add conditional locking annotations
Date: Sat, 25 Jul 2026 13:02:36 +0300
Message-ID: <528c354dca68f05cfd17df7c80f8b04419c0fb74.1784973709.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add context analysis annotations to functions doing conditional locking,
to suppress analysis warnings.

Fixes: a3ad01d51d4b ("Bluetooth: hci_sync: Fix advertising data UAFs")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d5554fbf3129..f5545f270f09 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1255,6 +1255,7 @@ hci_set_ext_adv_params_sync(struct hci_dev *hdev, u8 instance,
 }
 
 static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
+	__context_unsafe(/* conditional locking */)
 {
 	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
 		    HCI_MAX_EXT_AD_LENGTH);
@@ -1343,6 +1344,7 @@ int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
 }
 
 int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
+	__context_unsafe(/* conditional locking */)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
 	struct hci_rp_le_set_ext_adv_params rp;
@@ -1499,6 +1501,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 }
 
 static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
+	__context_unsafe(/* conditional locking */)
 {
 	DEFINE_FLEX(struct hci_cp_le_set_ext_scan_rsp_data, pdu, data, length,
 		    HCI_MAX_EXT_AD_LENGTH);
@@ -1552,6 +1555,7 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 }
 
 static int __hci_set_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
+	__context_unsafe(/* conditional locking */)
 {
 	struct hci_cp_le_set_scan_rsp_data cp;
 	u8 len;
@@ -1693,6 +1697,7 @@ static int hci_set_per_adv_params_sync(struct hci_dev *hdev, u8 instance,
 }
 
 static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
+	__context_unsafe(/* conditional locking */)
 {
 	DEFINE_FLEX(struct hci_cp_le_set_per_adv_data, pdu, data, length,
 		    HCI_MAX_PER_AD_LENGTH);
-- 
2.55.0

