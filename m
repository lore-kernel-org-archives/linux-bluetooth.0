Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66896306B1B
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003341; cv=none; b=Fby94jeU4soUDA2woJwELtD96aH3MFv3ifgqx2/2/eOGAMJH301t3jcCVK/cAZ61q2WAjxcArMeV3Fs7VdYQzK6jglVY+Qo9VtMb4tPrmhuDljYfrK5LPVHwy5LsNKuW8ciUSsFjMWwoZBvXEOV1e0AUCbamxOmvS0tpLGZ2NHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003341; c=relaxed/simple;
	bh=BLdy5RYwwnxwI12/reMngqLlpG0q24uuDZT8WAkw5pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqzSmsjmzEcU0OW1nzfiE0H9zhlZtAxqRDPZ+jvhW89usKq9B6xATZ6JVf5Z85+ApCP87aru7Ca2kUhHFnKdh5Nw77q6Pu19byTOjfYM3iby8Zd32bFGI1Q4FZ6wMnSy4/a9E1DAAyTwe9STjPgAzMyI4mrpSjMPdj0iU1rNU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpHQXqCh; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpHQXqCh"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e54f8c051so95095085a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783003337; x=1783608137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDc1M3fzwyIo252qDTRE7KflfviUkXRwK1adxDoa5h8=;
        b=kpHQXqChcKGMDbWjy+8IxNFzWWb08y7SEJrQFSJXZFUaXLvkAePKa+F+Ly8CyCeyo4
         n8uYivqCyeubwp23I2rsZHdX/Mgb2zbmb32xGPlfV46Hp35kWGQc49j6qGogArE5FT8N
         5XanaoKJQ6HYGXpJ3VQp2SCnzn/J21PHUIYfajml3zgCHSeMcRgPKaACIW23VMZa27q6
         8AF7LyTzfmaMOmWoCbFAR7iZ5X9jZQRBl/m49Pr8rCb6askpqi88husfJ9cPF+uWlhiV
         qvxSJHmdPKhI0Bf4aQ5y1kqLS878H2GjvlGYCh3TvT9I8iCwnA4uYIcLmSDi4FVIdeXH
         SRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783003337; x=1783608137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FDc1M3fzwyIo252qDTRE7KflfviUkXRwK1adxDoa5h8=;
        b=Ywnf5V4p45SCNQx3sZPOmqMF+ShIeocmKIBp9dY+Ml+F3Yt+3XY/96SgRLTa/0HZF6
         BgxEkMggmfbk893Qe7aG9pV4y8dtlkfBaAXSG+2pNImH9eKKVp95CXA3iGpheBuMVcm+
         HQRtCm7IuMHJQjjxWyjLiFyrvzEN/TniQihmeR/f+rPl9LAqpMG54+tlQS/JQlvR+wSj
         Pi3WSLmQFdMAm73ezTH7sZHCOQ/XERCCX1Yidkjh3gSfEgTGtZH8dWTIFLm1p5j47oG/
         z30tLIm+YhxxVKq5E65zhSy2GTcwdhqyPT8zsG+pdmCwJhfjMOpW4/r+MJtE/d57RXHO
         sbjA==
X-Forwarded-Encrypted: i=1; AFNElJ8vjaPHCHW7N3IKFUJTbbyHx5aBOKtWhj55wcRbA+rskNvhbm0965qhH73ZDseo6uPMKE6e7RS+BfUFvJG0iDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg5u0CaTEJcqLu2lIpEjX/tnYC/FjTb7OyzmRn5oUJfYROlPrW
	dPjuWbCZnz3ckfJG2oocYTlq2pIYFuHFfKozzFCRS4Yhrbw8qqrMfcWV
X-Gm-Gg: AfdE7cl1EOUgYY29n1xP+EVOsMKezT0UBFdTxgp9kerhzOu7Hfd8OuPcjpI/2naihQs
	NJqJhGO9z7H8vFKl2S3doD3xVfvhwmRrYVTj5N6247pAKzmxnkwl/2RQhsdd69nEnLSZZAjr10Y
	tLziHSnhin1iWGe53onMJJe50p5XpSVNnZM/LTLwofnjJ+vOkxRVpr9xsWi7Qbpcvk9wvnpQXTD
	m0u6etxuXy9rEBTNS7Xoh7QRNms4Lvg7aMi0x7k6ln1PQLOAxR2l0KWtEECyuFMM5aVJArc6Hgd
	zJlEHlqsNVfQxTw/ycwqsvT4KJmaJ6z7rbkvLEeuSoDsitUQe8MLaS3eK2jmQmYLBzQlOjefosx
	2mVC2UlmwM8R2TlAcDj+qJp0Om6ojY6cnRbvaqViuKkIJk+jMeDACojZ5TKNCw3KCH4d5QBwifW
	9r3DlFjhBNHS8BMBN0yROKxSwEyNyMDZ3C4jUol79WTTY3Y85re8Ksl38za70ejZ7hJM/IMFZq2
	kC1Yqt8LUYB1G0Jpr9sbQlanwtSg/rEJHbd
X-Received: by 2002:a05:620a:1a22:b0:92e:4dd2:bb24 with SMTP id af79cd13be357-92e784d10d5mr843521285a.39.1783003337207;
        Thu, 02 Jul 2026 07:42:17 -0700 (PDT)
Received: from jeremy.kali (srv1619992.hstgr.cloud. [2a02:4780:75:55a3::1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e800146acsm236934785a.13.2026.07.02.07.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 07:42:16 -0700 (PDT)
From: Jeremy Erazo <mendozayt13@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Claudia Draghicescu <claudia.rosu@nxp.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Erazo <mendozayt13@gmail.com>
Subject: [PATCH 1/2 6.6.y] Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID
Date: Thu,  2 Jul 2026 14:42:06 +0000
Message-ID: <20260702144207.320421-2-mendozayt13@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702144207.320421-1-mendozayt13@gmail.com>
References: <20260702144207.320421-1-mendozayt13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit f4da3ee15de99efa0a68eae1c4d09b4bcc6d9dcd upstream.

Copy the content of a Periodic Advertisement Report to BASE only if
the service UUID is Basic Audio Announcement Service UUID.

[Stable backport rationale]

This fix landed in mainline v6.7 without a Fixes: tag, so the stable
autoselect bot never picked it up.  linux-6.6.y HEAD (v6.6.143) still
carries the pre-fix code at net/bluetooth/iso.c:1935:

	if (sk) {
		memcpy(iso_pi(sk)->base, ev3->data, ev3->length);
		iso_pi(sk)->base_len = ev3->length;
	}

ev3->length is __u8 and iso_pi(sk)->base is __u8[BASE_MAX_LENGTH] where
BASE_MAX_LENGTH is HCI_MAX_PER_AD_LENGTH(252) - EIR_SERVICE_DATA_LENGTH(4)
= 248.  When an attacker within BLE radio range sends an HCI_EV_LE_PER_ADV_REPORT
with ev3->length in [249, 255], the memcpy writes 1 to 7 bytes past the
buffer into the trailing fields of struct iso_pinfo, including the low
bytes of the iso_pi(sk)->conn pointer.  FORTIFY_SOURCE flags the write
with "memcpy: detected field-spanning write" but does not block it.

The upstream refactor addresses this by:
  1. Filtering via eir_get_service_data() so only the BASE portion of
     the PA payload is copied.
  2. Bounding the copy with base_len <= sizeof(iso_pi(sk)->base).

The refactor applies cleanly against v6.6.143 - eir_get_service_data(),
EIR_BAA_SERVICE_UUID, and BASE_MAX_LENGTH already exist in the 6.6.y
tree.

Reachability: any host with an ISO listening socket bound as a
broadcast sink (LE Audio / Auracast).  No pairing required.

Fixes: 9c0826310bfb ("Bluetooth: ISO: Add support for periodic adv reports processing")
Cc: stable@vger.kernel.org # 6.6.y
Signed-off-by: Claudia Draghicescu <claudia.rosu@nxp.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[jerazo: backport to 6.6.y, no context conflicts]
Signed-off-by: Jeremy Erazo <mendozayt13@gmail.com>
---
 net/bluetooth/iso.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 011b2187b..8843bd5c5 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -14,6 +14,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/iso.h>
+#include "eir.h"
 
 static const struct proto_ops iso_sock_ops;
 
@@ -47,6 +48,7 @@ static void iso_sock_kill(struct sock *sk);
 
 #define EIR_SERVICE_DATA_LENGTH 4
 #define BASE_MAX_LENGTH (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH)
+#define EIR_BAA_SERVICE_UUID	0x1851
 
 /* iso_pinfo flags values */
 enum {
@@ -1587,6 +1589,8 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 		len = min_t(unsigned int, len, base_len);
 		if (copy_to_user(optval, base, len))
 			err = -EFAULT;
+		if (put_user(len, optlen))
+			err = -EFAULT;
 
 		break;
 
@@ -1928,12 +1932,16 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 	ev3 = hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
 	if (ev3) {
+		size_t base_len = ev3->length;
+		u8 *base;
+
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
 					 iso_match_sync_handle_pa_report, ev3);
-
-		if (sk) {
-			memcpy(iso_pi(sk)->base, ev3->data, ev3->length);
-			iso_pi(sk)->base_len = ev3->length;
+		base = eir_get_service_data(ev3->data, ev3->length,
+					    EIR_BAA_SERVICE_UUID, &base_len);
+		if (base && sk && base_len <= sizeof(iso_pi(sk)->base)) {
+			memcpy(iso_pi(sk)->base, base, base_len);
+			iso_pi(sk)->base_len = base_len;
 		}
 	} else {
 		sk = iso_get_sock_listen(&hdev->bdaddr, BDADDR_ANY, NULL, NULL);
-- 
2.53.0

