Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67120F9E8
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476744; cv=none; b=AW3SLlaZPaJjJQ3CWXOepH8wOiHOl7DyFZkmiSS/9BaE4kbuYIWgTxXoM68C+V6sLxho7YV8wC5ptsDNjK+Ed72sgBzvSAmC/yYEsrCABuwlyDGBM+WlwiRBCGy4k3Us2co2XKlm+ogQoJDrzvJULd/iEysAo5kMftuwie5Kk28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476744; c=relaxed/simple;
	bh=nyGS+8CdRT8plw0NP0Z0523hGngAcdySnS8t1JQEnic=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Za6CJ6L+/pdg/k9rNTMVPm6lqm4eZhA2B/yLEq3j7Pdw1yQy28moGkDgvfPSvPgF8vHKV8A9YZN6cTu4DPPExf4UFXPuhw1DXgp5QZVc+7VxiFPjtFIeDVz4/lyrYj1Gc1qx+VCPuJdh5qoe06aYQlBEcCXRFYb5LJ+SPe4q/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTlDPIGV; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTlDPIGV"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-492aae5fd78so1611701137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 08:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723476741; x=1724081541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XnTlJTIn3gGbaam3/l4MmjD64A2xbXGNtEPBdy4Ltqc=;
        b=VTlDPIGVDLueaP0LEtL6TuEWBA92SfnD66t0Ut94ckUQ+ZG5wcVS3fDF+YCfSvV8G9
         3z2PI41XFdll+cxUK8/NWyTJQ4PJ6Y8P5SjJM9af7qQQYhkPmIOZFkUW/3hlnz+hHROG
         pc8zGfTvLPymWmgnvkqN9jpzEGZxR4+C7SNVSOvSCuqb6TjODHDtOdhfS3d80w+kMyIe
         8MfjIx9N5NhcSKvn7x6CSMNIg+UVyC9KeYGJ0YvF0KAVNiyP1SvAL/RMmeQPu4kMFJpB
         jGSiknohVfB6vTA9AIjtt9AmcUmexoJpGi0Zq0c6fEF8XN3ItM0BN+0LAqZqwt2t4Tv3
         fR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723476741; x=1724081541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XnTlJTIn3gGbaam3/l4MmjD64A2xbXGNtEPBdy4Ltqc=;
        b=sUYBzghdxQrEKT53BZBT1R6UIBRAWqGY07vGMtiEpn3Ga1dOW68xAWtRc/kX2hFrfP
         Qu3uFIFkzlwMjIx30enW0nP7pQSk5jeqg4LpTTvrPLFgo5knspOYFCNzUpZ8IrKOhzu8
         IwrdzrWIi4x2Kg/K+UwQSLfU1XlCBxXDW8jEJ3aIlAZ5QsYmvo8NTJyZsLUrGDfovSiv
         N4iVDnkw/PXgqN4y+eSzCx5ch3wN+23bn2CAHUNyiExMJ2VW3al9AsYZmIhoz5uZDM4z
         1OpoQfNMBGzjDVDZ/pnsBoCrNcnSpQ1saeVzEpIQ2hIMSe9Gu25e2DiByjtWcV/6bYQa
         HvEw==
X-Gm-Message-State: AOJu0YwXbK9/X1El6WZHMiHTGWrZQue77QiCMi/TwkRELD1PJHXZCz9K
	lGi/8ojmDm3l09DcN28JFLbAiVNOK7ChGShd8eHPQd9BrF9OtI6885gqYw==
X-Google-Smtp-Source: AGHT+IF7HX9T3AfVuhjueWG7ywQZCPHBdffRcsAZXQfNV+QnqxxqisVYIOZRVKcOfWINpw8CmhqaCw==
X-Received: by 2002:a05:6102:2aca:b0:492:a11f:a878 with SMTP id ada2fe7eead31-49743b2da4cmr907951137.23.1723476741538;
        Mon, 12 Aug 2024 08:32:21 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-49709fa317fsm838647137.23.2024.08.12.08.32.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:32:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_core: Fix LE quote calculation
Date: Mon, 12 Aug 2024 11:32:19 -0400
Message-ID: <20240812153219.290388-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Function hci_sched_le needs to update the respective counter variable
inplace other the likes of hci_quote_sent would attempt to use the
possible outdated value of conn->{le_cnt,acl_cnt}.

Link: https://github.com/bluez/bluez/issues/915
Fixes: 73d80deb7bdf ("Bluetooth: prioritizing data over HCI")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 06da8ac13dca..f25a21f532aa 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3664,19 +3664,19 @@ static void hci_sched_le(struct hci_dev *hdev)
 {
 	struct hci_chan *chan;
 	struct sk_buff *skb;
-	int quote, cnt, tmp;
+	int quote, *cnt, tmp;
 
 	BT_DBG("%s", hdev->name);
 
 	if (!hci_conn_num(hdev, LE_LINK))
 		return;
 
-	cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
+	cnt = hdev->le_pkts ? &hdev->le_cnt : &hdev->acl_cnt;
 
-	__check_timeout(hdev, cnt, LE_LINK);
+	__check_timeout(hdev, *cnt, LE_LINK);
 
-	tmp = cnt;
-	while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
+	tmp = *cnt;
+	while (*cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
 		while (quote-- && (skb = skb_peek(&chan->data_q))) {
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
@@ -3691,7 +3691,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 			hci_send_frame(hdev, skb);
 			hdev->le_last_tx = jiffies;
 
-			cnt--;
+			(*cnt)--;
 			chan->sent++;
 			chan->conn->sent++;
 
@@ -3701,12 +3701,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 		}
 	}
 
-	if (hdev->le_pkts)
-		hdev->le_cnt = cnt;
-	else
-		hdev->acl_cnt = cnt;
-
-	if (cnt != tmp)
+	if (*cnt != tmp)
 		hci_prio_recalculate(hdev, LE_LINK);
 }
 
-- 
2.46.0

