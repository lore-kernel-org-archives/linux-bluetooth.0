Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E2A28468E
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774935566; cv=none; b=KiaQrd5gfUamA6BVvbRxm8WBtZxp2TYi8Oebjd1/zxqu0ku6lywxOCwagPN2QWdmYNvvvYl6N+H+53BlOHA/mSzkfygUOS+OfgheABoOiAV2lm/75zvEVLXPIC+KyifuwlRN7ql76liIRP1d7Pawq53vBnKkNauNUfzWA4x4weI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774935566; c=relaxed/simple;
	bh=IRCcHxZE5vrRcel8klWBqk+hwn76HSWyQfvZSoxQlsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iovHB34SKQjq/X0iQW4RKKQ2dIzASfF4LsEV2Adnr1KYmPK8J5Hz+ozG1yeMZQZSYHnOAPRBnhElHpLz5m5YTRJ1RFhQeBU9jJVVqKmTLZXRqYUH+nPfg4IF+GhVkZLi1IYQpeaCe2EJxwi2lVRYNAo8YJY1yga+4i3joH5zlJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbKQHeIf; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbKQHeIf"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso3324843eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 22:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774935564; x=1775540364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HV8dmt1HgzHPMJw/ZTQseF87igS3ZBKLE6u0ax+TN+8=;
        b=cbKQHeIfgKXH/z9j7RkbpWtwjEEO4gAGFKUB8bLeDeanreLcqxAR8TLC4vpXzJOs2k
         xkYRJfENbh8EsMxLH/AnfUOay1Y7ezbqdGRCczYEhQvPubQbj+wV2f5k8bP+7/oQfpG6
         yoMNrPnsrVFb4zaE8HE+Slltg00y8NsZj5p6FZ5/7XTgfxWwneQdBqNgZIWoqywuXDJI
         NrZ+g01fHn4co7m43/SBE7sNt3sF86QvRiJgmBFYntCsnPr0OWQLiVlAnOEA2P9odNEV
         5hwAoRhlcZKpgvG2dA+m9NqWmlKDqkscMhfdVbxKtEyjbZDz6epE8zhfLjRSf6x0tIOj
         KWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774935564; x=1775540364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HV8dmt1HgzHPMJw/ZTQseF87igS3ZBKLE6u0ax+TN+8=;
        b=ncb/PGIaXltMSQ9uJ/Q3F8mssQ83XUelufjU/MLEuoQtWkv0bjrvCXm7ESK3Zm+ZnH
         lzNEiBN0Hv6NGOHRvjaRdlymUmwEUJKuQgj/S5vFGcJ+V2xhMNVyn8A4vVhI8OdnW/pA
         zZV6RpiCYGj2r3iJiKL23yAVH54P0t6g0MzUofUiiu8dW9hStA7TosKMz65NgOX1cUfC
         VDNDHOQ2ir/Qr5KBP2OHCmORUx/cHNNq6SCG64ykGW1U5qBm25siUxUqxYnoIkTvZ+Sb
         h75XxiFH1otL/1dckb6jpfmEXdlegGMceRWQP7boOm4d80gvOyB99z9wglbV+AhORbVA
         eSfg==
X-Gm-Message-State: AOJu0YwAi09cUtpaeXCOJwRjJc+RktC9t9UlIqwffRdkHTjGfTVBP2pL
	4PPeSHSEyxbeekoWfSZDIftFgsRPzofsK5kO3K9XT2MFPTAU4VgjQCK2
X-Gm-Gg: ATEYQzxVtGUI67/xrgG0uIT+2E5TIaJ9WBoA3d369S0sZSzcW2X10E7j1Pcd3lIsUfj
	cM+lOlKBMwGQ/IdijiL3sN8/+etSIxP5DUSXqND+PUYzaC0xZAhCuql/FTJJB3pVSHEQGMxMYFo
	DrzyIWyGIyjWO1aDwmPcw15SobHU66IA7R5CN7c6nicdwcYWqW8y/ozO5Vw5SMohg1Oii9BOKSJ
	vItKhiK1pzletkJxVuwvx6Mintjrdh/nEkztL5PYiAIDYR4jvg5aumCTwFYJx4s1jwFAXLYnSYJ
	JGvwCHEOBbXsYS2BK6AIDa8/RIatMCorhwQKvR2Jh1T0BhKT0V5RiHaGMcdp02o4/YF+YPcnucr
	2kz6l1Dq6iZ04qYTNkITVCGRl527QM0/DshBulgIEr/qe/ZGVV5gS33bGRcj8BRcUqppHUxdG6M
	sfsPfSFBIbbxxnpvcSbJ3kalqCG7SS8KKiGBe+FlIt5w6ElClCM40imzjs0etRY1OaUA==
X-Received: by 2002:a05:7300:bc08:b0:2a4:701a:b9ba with SMTP id 5a478bee46e88-2c7bc937c3cmr929977eec.14.1774935564304;
        Mon, 30 Mar 2026 22:39:24 -0700 (PDT)
Received: from localhost.localdomain (104.194.93.216.16clouds.com. [104.194.93.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c747e410sm9271157eec.25.2026.03.30.22.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 22:39:24 -0700 (PDT)
From: hkbinbin <hkbinbinbin@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hkbinbin <hkbinbinbin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: fix stack buffer overflow in hci_le_big_create_sync
Date: Tue, 31 Mar 2026 05:39:16 +0000
Message-ID: <20260331053916.1856760-1-hkbinbinbin@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hci_le_big_create_sync() uses DEFINE_FLEX to allocate a
struct hci_cp_le_big_create_sync on the stack with room for 0x11 (17)
BIS entries.  However, conn->num_bis can hold up to HCI_MAX_ISO_BIS (31)
entries — validated against ISO_MAX_NUM_BIS (0x1f) in the caller
hci_conn_big_create_sync().  When conn->num_bis is between 18 and 31,
the memcpy that copies conn->bis into cp->bis writes up to 14 bytes
past the stack buffer, corrupting adjacent stack memory.

This is trivially reproducible: binding an ISO socket with
bc_num_bis = ISO_MAX_NUM_BIS (31) and calling listen() will
eventually trigger hci_le_big_create_sync() from the HCI command
sync worker, causing a KASAN-detectable stack-out-of-bounds write:

  BUG: KASAN: stack-out-of-bounds in hci_le_big_create_sync+0x256/0x3b0
  Write of size 31 at addr ffffc90000487b48 by task kworker/u9:0/71

Fix this by changing the DEFINE_FLEX count from the incorrect 0x11 to
HCI_MAX_ISO_BIS, which matches the maximum number of BIS entries that
conn->bis can actually carry.

Fixes: 42ecf1947135 ("Bluetooth: ISO: Do not emit LE BIG Create Sync if previous is pending")
Cc: stable@vger.kernel.org
Signed-off-by: hkbinbin <hkbinbinbin@gmail.com>
---
 net/bluetooth/hci_sync.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 45d16639874a..b84587061ae0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7222,7 +7222,8 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 
 static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
 {
-	DEFINE_FLEX(struct hci_cp_le_big_create_sync, cp, bis, num_bis, 0x11);
+	DEFINE_FLEX(struct hci_cp_le_big_create_sync, cp, bis, num_bis,
+		    HCI_MAX_ISO_BIS);
 	struct hci_conn *conn = data;
 	struct bt_iso_qos *qos = &conn->iso_qos;
 	int err;
-- 
2.51.0

