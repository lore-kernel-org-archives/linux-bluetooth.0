Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599152;
	b=FmboPcYbw68NSt48fhzfoMWATknDZdcRnLKEWgMRh6o+qUNMywvmZnt/1fqJNx4q097C
	 kDrXCmy6FiOtB5CF32cSjTwkSB7BZhiHuBB9uMF0W9XRLvgtuwRgDiGgEvTQW+zhieEFe
	 GB3Puby3nuhCFUu4bjLGbEvoGt0ezJc/51gAKnNC3OvYkQDADGuLlIeq8CuIAu/mY9j73
	 o2Xoro69IBjfLEgMBY+ELMp3bTWFFhSVroT3sRYwkmK2xTXUgVm4GII6rLVHYcKPnTPv8
	 QcyZu0nLOnZrmljVI1UlHmZg74iDpTCmTIt1mkGwS8UhS0+/tgN/+j7I6WT5qywmvjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l4RHB6K7RgAz/nQf8J1fwTRQBwHcMKQGbkgU+q0PgV8=;
	b=2qklUNGaXn8yXDRU4rhp4Nn7yJHm0yVGUVSLxyD8S9tTgegK0KWhx+9ecKdH+A9mS4PC
	 KpNTpVSb9/xEQIZbrS9aHhk92xskkJ6DAbEgFkO1Q8KIKhbQh4Zk0wwBHE4raCwYDDxCa
	 EdHn/If2l9GfKCuHKyOpOpcWHWAcOZHaD74CeMKuGHeJRKsKhk1E6b6ER+cvp14oJsnxH
	 fSOvDPKjWHr4tkKS2mQBsbt6EaI009w2+hcAwcqQnFg8vOvLEC4fOj07/aKkXRAN+d0A2
	 mpQmMMXnR64Fm/vjcQDMguA2jkOhXligFiEyxR8OOoUjt3R05MnrCue9Sgz8tG8fnZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ucWggkp/";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A26606A323
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6A26606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ucWggkp/
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so47485215e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 01:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795599150; x=1796203950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l4RHB6K7RgAz/nQf8J1fwTRQBwHcMKQGbkgU+q0PgV8=;
        b=ucWggkp/ylQeQo+d3P3B4kePoFLjOBL4EURBC03OYEs6t0KRzCt7GAV9npYPdoHzLU
         y2QCcusM0/gl1bRT/7n6sOQOlH8ZAZvNUziP9aOJxCeCF9B6O2ZQyb9/irm9jUDgVqfd
         KBrfejRrsKZfakTfthYUuLt3B3LVYrXRrjsXjXu/0eq13CNTZ28ATtCXjnhlXj8oGqn+
         y+XiET0B6ez89fSEwIN6oUY3zGE6Mo8w+F66hI0KqkGCVDkgSAUXbPu4jpmIAF3pImhn
         TMQVlLSY2STfsdpLmQEvN8nj7QxV60X4C4kNhU0wWxhADCPybT0L3FZ+KRhBwXqR8aTP
         bhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599150; x=1796203950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l4RHB6K7RgAz/nQf8J1fwTRQBwHcMKQGbkgU+q0PgV8=;
        b=LpEYc/w4leYsnC2tztKfF/gd/BvhmcNOzwE6v8mwJpPy4U1/1AwiRp6U8K0rSL9zyA
         I5cv/zja6/s393WDk/26Jehd5fw4KUZhhi3DNfV37mYBqnPDSZaxXARZZsgdLSmhYBal
         vWKTQLcaZVCGDWBZXWOac/tB4UmsbDKXK0b6Q0CxTEoCSJq91ElxWp1M9H4dCXKVwo6N
         0O4g9xRR9P7PFJqjzr9rRairOMqto7LDaPVcgilMCC2bIbcM7rl18N5jrdt5mXwUooYr
         EELuGP0riO4wd46oatuhgrD1Kfxa/4ioDRlGoER7XgPa39PJp05c/c0aGTp9hTo8M4ks
         xvQQ==
X-Forwarded-Encrypted: i=1; AL+hErGSbWSPQz13eFOtRf5oYaTdhs7fXyoK7r7+5MZYPCGHZ+dSBsPkTOdbo5XfPYM0M47PmnzyAUHJpmtMDBic0eM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Mi3KX+b6aPyLPdd2MIAZMiXFZLzXbUrcQPY/jsJBp5vwnZshx
	8K89Bu17KPuICEUNp20+6X67kwgUlLzuU1yZtd5ILcB9YB941i5IJJEn
X-Gm-Gg: AZFdTZffGUH1ZdmNkkPQNug7Flp3l/g7XGK3Etm/q842Qa6sSj7GPWKOzSdC/Llzu7N
	6UBt8sBkoaH0ZILSuaJblcm5mDezKunIEBFzgPl42W5tTtPgTvpkDeWbagif+S/kbUQjiiW0p8h
	TtZGGrRTZ0QHMMLOwnHHtGoaTEBSsuwaBvAgir1sdB/3/3As0Idu/D3zRJ7Y69TPW21Wztig7dV
	69YWZXy6+Ay87VcucrfdSYE9mdbUKmjY2P4T8W0MTImnZrcwW2lfZmXK4i+7lGTWRIGa0UfF897
	/ixgGVpWYQorH2vOu30b1sCUkJwXs64dKBye/iR/PrcFbPqMnt/zKChm/ElJdsk1B/noA/b5A3g
	ykjToYyEXZ5bgfouekkX1pXjsttWANnJ0hKYWVQArrsJe8zH+gRpr7xyPBuGULH4ybqO0flDPlv
	SBU+i+jwNRz5qoOjzOIKybMlgO026KayU53CCs7HRcq5oTm/kryTh03Sd6Kwyi6dJqdPJffzon1
	hGuvOP2sWDaLxHFbH2iZYOl084keoYJFB403OxK4mbwGosnhI/0f4My0JyrfTi90Mgr98tCdHjC
	5sEFHo97mabjhq/KMfT0
X-Received: by 2002:a05:600c:4e02:b0:4bb:5d39:95fa with SMTP id 5b1f17b1804b1-4bb88811c82mr338133785e9.12.1795599149909;
        Wed, 25 Nov 2026 01:32:29 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884911e3sm608782495e9.6.2026.11.25.01.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:32:29 -0800 (PST)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Vaganov <petrvaganoff@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.1] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
Date: Wed, 25 Nov 2026 16:31:00 +0700
Message-ID: <20261125093208.224568-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit 59437cbb5781227567dec226aaa88c66a09ccc5a upstream.

This fixes not checking if skb really contains an SCO header otherwise
the code may attempt to access some uninitilized/invalid memory past the
valid skb->data.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Petr: add Fixes tag ]
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 net/bluetooth/hci_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1639097a865f..443a1bb76019 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3786,18 +3786,22 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 /* SCO data packet */
 static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_sco_hdr *hdr = (void *) skb->data;
+	struct hci_sco_hdr *hdr;
 	struct hci_conn *conn;
 	__u16 handle, flags;
 
-	skb_pull(skb, HCI_SCO_HDR_SIZE);
+	hdr = skb_pull_data(skb, sizeof(*hdr));
+	if (!hdr) {
+		bt_dev_err(hdev, "SCO packet too small");
+		goto drop;
+	}
 
 	handle = __le16_to_cpu(hdr->handle);
 	flags  = hci_flags(handle);
 	handle = hci_handle(handle);
 
-	BT_DBG("%s len %d handle 0x%4.4x flags 0x%4.4x", hdev->name, skb->len,
-	       handle, flags);
+	bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
+		   handle, flags);
 
 	hdev->stat.sco_rx++;
 
@@ -3815,6 +3819,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 				       handle);
 	}
 
+drop:
 	kfree_skb(skb);
 }
 
-- 
2.55.0

