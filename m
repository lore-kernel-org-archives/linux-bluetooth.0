Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC62C393DC0
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 21:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774906064; cv=none; b=EILvrDEZy/gwaIufrHpevseh38pTq2KxARnJnznefqRwuzbbRpbt/dqOVeeuMwoM0Tb4CXOZZxD2wtL4OurNS8rFOMZyQzMshwn8sa2n2khi09+/DDBKG309XqwSOnIyOlhwywe8Fq9e2ygPAQxhRp+HDZ+vBUbpfVqc4YnG0R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774906064; c=relaxed/simple;
	bh=RKgk+a2ITsqi9XukOOzHKnfiIEpr6iF2PY9x6eaZd4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBQNvTgm/mxSiesML14lbSKIVmzheQhq3yc4kQ9+KtGfI4VA/AJmSqPgxjQci0hjlhFIAj3JctsIHqQq76zTi6+YJj90+s0KHF5OnCjT08lPNcxguVcejQPKV4fzGhek8H6LPFptbOWA38p7TW0eDZQ9dM5yYDbYQH1jzJcKHRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhHgJza+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhHgJza+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b2589c26e3so9421855ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 14:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774906062; x=1775510862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgJhP5eB3Kjlb+gJEQE6up3YZMbKoV0ITM0rqeVdqjo=;
        b=RhHgJza+k1NMSAMgtCFvVXTCQSxNCEri5bXe6UCeRs78eQyBnMRPyiwfm+EvDZwwR8
         S+kmR7G2LMLN7N3ozhrsIYrnY5DvOAULmN65cflRFmtac5ApSu1gwhVvZSgXVE736Nsc
         CAolI7UN81WbDIkfkFvIaw9tAh1+rTpRv2Os+/Gshm+ec9ODwqdRDPQ4F/JRSn2IZQhO
         mgcFSbSHVRC+tr1xuLLUCwc9ca6stjvzKTDf1uymhfb/P4B5vV1tt5beXZTGFlPCvEoq
         pP3pvlzH23TYZ27XuP6ldJNIozg+FGwmdlcmR2HvpXl5yl+iv+LNynWDdCCjZMSrxM2o
         An6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774906062; x=1775510862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QgJhP5eB3Kjlb+gJEQE6up3YZMbKoV0ITM0rqeVdqjo=;
        b=KheBdVRWH4v8wg60SqJvb3LvOgM4DoGFOBoR5M8HxNPnkVqbvuWtawAUQ5VXi2h7J7
         mGsQpZiOot7ND83quCteNAvQMu1FHs3+cvxXTBySoGBRqRNxiUP+Zv4pG83RcPlPHgwq
         Pg93SUIFDxUT0k2wC6T3/mDbPJTR3hMq6p/gzg+09bCWGoWwtVshl4SRCXA9H2x+FGFW
         3Gk50VctRFqsJc39mWOZcN+7f1dGDAou1HT7mBDcOAVV4GdgW9egCXqfQq7Pl4Wk4qci
         dfVTik0bk04zwFXbscakwhr6AuZYi93UA/2GPwyR3way5GClL5vLu6jx/8efwdesqU5G
         6uOQ==
X-Gm-Message-State: AOJu0YxTD6dDyIut5Yf+t3lt6Y2Ok1M1j/hsxWAXTf56f1zkVlTTiWFi
	Eq2Q4MKf08p6bqCIqD0lHHa2hERFMzUYO0AzLGZV212R5wZXu6dHxq5KhnIPqnU7
X-Gm-Gg: ATEYQzz1HamfkY3VzWUwGituXWKCx0U/2smXKbFLIWXPn8WZ0CqmkbN6EOOyKg1Hvnd
	uNNKF1FKPmR7fFIRLWX4zZT/qDtdqtguh/KFJVcz6tmrzRMgx7RzFnrO2asmz1Ls3uBFn/YK0nS
	f1oshPl+KozImrPoSE4P1Zzr8Hovx8KX4Bydel06AxX283Ir7AOiUoR6cib8LKzzGHx/QXJigtU
	hyEC2KTlLwD4SeH5X9jP7kn+eIvmxYFDuqZWvHBoRIC9T9KzTvGg5Ej+m8u+F6rCt3H7fKhNW2A
	2enedihZigZIRMhny9vkTDb5OPvZTs3y+WA3Fr4qqYSmdkYoxI5dFm8CDqMxjwYTAcBRj3ben5d
	npwgcQfBg3miEja8MogM601DN1/OXpnDlBgAacl+OzRH94yg01oiY2gA0qoy+4mQGkFaG1yQ30b
	5k/TIxeBjHc7YHCcC4oDYa15uTU6LJOcsPfv1nvvBLA90b5uMYwc6zUhnv1oDbec+sZg3rq3RHd
	rgfbR/9LT9Lb4xHAvC0aw==
X-Received: by 2002:a05:620a:1a22:b0:8cd:8635:c031 with SMTP id af79cd13be357-8d01c60d473mr1783105485a.20.1774905690987;
        Mon, 30 Mar 2026 14:21:30 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027edb8d1sm672796685a.4.2026.03.30.14.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:21:30 -0700 (PDT)
From: Nathan Rebello <nathan.c.rebello@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	stable@vger.kernel.org,
	kyungtae.kim@dartmouth.edu,
	Nathan Rebello <nathan.c.rebello@gmail.com>
Subject: [PATCH v2] Bluetooth: ISO: fix NULL deref in iso_recv() ISO_END handling
Date: Mon, 30 Mar 2026 17:21:29 -0400
Message-ID: <20260330212129.319339-1-nathan.c.rebello@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328035813.296410-1-nathan.c.rebello@gmail.com>
References: <20260328035813.296410-1-nathan.c.rebello@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ISO_CONT case in iso_recv() properly checks for unexpected
continuation frames (!conn->rx_len) and oversized fragments
(skb->len > conn->rx_len) before accessing conn->rx_skb. The
ISO_END case lacks both checks.

When an ISO_END packet arrives without a preceding ISO_START:
  - conn->rx_skb is NULL (never allocated)
  - skb_put(conn->rx_skb, ...) dereferences NULL -> kernel crash

When an ISO_END fragment length does not exactly match the
remaining expected length:
  - the reassembly is malformed and must be rejected

KASAN confirmed the NULL-deref on kernel 7.0.0-rc5 via VHCI:

  general protection fault, probably for non-canonical address 0xdffffc0000000018
  KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
  CPU: 0 UID: 0 PID: 72 Comm: kworker/u9:0 Not tainted 7.0.0-rc5
  Workqueue: hci0 hci_rx_work
  RIP: 0010:skb_put+0x27/0x1a0
  Call Trace:
   <TASK>
   iso_recv+0x5e0/0xee0
   hci_rx_work+0x226/0x730
   process_one_work+0x633/0x1060
   worker_thread+0x45b/0xd10
   kthread+0x2c6/0x3b0
   ret_from_fork+0x38d/0x5c0
   </TASK>
  Kernel panic - not syncing: Fatal exception

Fix by adding validation to the ISO_END case: reject unexpected
end frames when no reassembly is in progress, and reject end
fragments whose length does not exactly complete the expected
reassembly.

Fixes: ccf74f2390d6 ("Bluetooth: Add ISO Socket")
Cc: stable@vger.kernel.org
Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
---
Changes in v2:
  - Tighten end fragment check from (skb->len > conn->rx_len) to
    (skb->len != conn->rx_len): the end fragment must exactly
    complete the reassembly, not merely avoid overflow.

 net/bluetooth/iso.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index be145e273..ee87341a1 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2587,6 +2587,20 @@ int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 		break;
 
 	case ISO_END:
+		if (!conn->rx_len) {
+			BT_ERR("Unexpected end frame (len %d)", skb->len);
+			goto drop;
+		}
+
+		if (skb->len != conn->rx_len) {
+			BT_ERR("End fragment length mismatch (len %d, expected %d)",
+			       skb->len, conn->rx_len);
+			kfree_skb(conn->rx_skb);
+			conn->rx_skb = NULL;
+			conn->rx_len = 0;
+			goto drop;
+		}
+
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len -= skb->len;
-- 
2.43.0

