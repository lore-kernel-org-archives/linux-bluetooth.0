Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5B8146588
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742243929; cv=none; b=QPr8ah1W+J9UYQKW9AcWlw+RLH4dWwhuq0cEpCdXiW3eEUUk2nTeSUgZ7Ypa+ZvS97kjtKyvZ8a4bOI7y5hw+AWGJM9zcLPheLRTZhqbPeQ3PvlB1NWJVzyeDgZJeWn74/xEtBrs1GSYF1p1RhAhrvgb8dkTK5syXAAOFbfPIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742243929; c=relaxed/simple;
	bh=uHi3Q2O22VhMP0V2t1kcrlC9kFM26XkRcVlpxwoU5CM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uyCeSNqWe8e9rgngAF7svI0B2IWOHqwHnC6Rubq0LyRLDoEvtVkdGQj6U80VXz6sXen+NQO+VcaODvrrIYK4hEqjHF8zdZg6jfTINy2nr11A2Hrh6v5ZdwfcYDMWB/7EqRgAgC00nkL06Xuy8/KbR1gt9Sl/iLhCtLhuWCTGx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KctXY9HD; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KctXY9HD"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-523b7013dc8so2051432e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742243925; x=1742848725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6RKH5X1aQ4R1sfYyXMyS2FCQE5YgN7124d3NFATAnX0=;
        b=KctXY9HDWxANPvDO3q7N5Gu2xF9Xhd+1Ovf+IcucH6Oi67wPgPULoUCg3SRt2MGcyR
         8SfhZjL5Hoz9AqMfZ1dZXMnQfZ0g5qP5fg5WuXjR8/CKaNOfUZx16aRy5M1Zejy6s4LM
         vYsE0Fb61z6ITuh7AV8RRIa5qhCVpccVR9MWVBQEFg2jeuAMh0y52haaNunFHIjqi39h
         z6w34fca8AHDaDR66SQGyj8QQ8KY57S8c7F5cF+YmficKex6Cuz4tmey/R995tUNSuIm
         mNUorF9sO7EeIpPZINMIM/S0by2T2QyGAUmR3U76iSLva4lE+HCaeiMHDu1PN04CuCBR
         Q3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742243925; x=1742848725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RKH5X1aQ4R1sfYyXMyS2FCQE5YgN7124d3NFATAnX0=;
        b=A88K0E51QZ1YS8g6DdbLBSYr6fOZoKAT9FbuCTzgQVlZzQH/c0lw8mxowlPzyLXCPR
         +PBajw+z93DfHfowdT2yqno7XVef9l2RRpCJx+LY65FblD0QZTEd9tAQZ0vzCM2tXrpp
         U1hudjj1fSfYam0WGwDeyoQfrL8NMHJ/EJkuM0sHzs7u+QjCJ6ZZp4SnsXL51+H/fi9p
         ls8QmoKctXTa0xim0IpHqeH+FwH7IDltCWfcTuQ9Qb8cGkUNm3Hbapv4CC+rNNMcEYhr
         SKb788IhwEiLDP/fCZAgZvpFbuX7QkQGy/TLWhjiyuKmExGcBkCwpecD4jWEtwGIcJfF
         VNYg==
X-Gm-Message-State: AOJu0YyxMGdyLk0uOYvV9V1fvRqMvdt0mYfksMTM3khY5fWzKZRYf50C
	CmfnjdJaubA2U6GQ+Lv33pPbj6BaJQmW7VMYK5a04u1EWXKQvTwC5ASq5qvvbiE=
X-Gm-Gg: ASbGncvGaQrOZDw8thS3ndKWqB4qD+0QOOyiU2r1qL5TFGVdSHDNTG02umB86yWoplI
	Ki90ZJCnkszEXu3I68sFD7snSmeDDRumjtkccPTfsHpOCIFtT/k4/xhjkrCHBeTWDtruQbpoSBd
	1I6DEtaUrxZ4XWhqsB74b+Vfd8qlbU1Q/Eno3a7nQXw+9djx8eim32/0cBXsnllUxEAq/cUdQag
	5UuyXRDO0xPKet2F+vyTABYECSf6H5jmcNvnS8Rxlkz35HGyPweG5mOSAExo1eelYm5b8DDF64V
	OBfUNeA2fkDB+Qt6zC3P2x4qhaOb2fKksY5mdJwXJglMNmP6zOskfFKkp7IPM+75iGvMMJd+o70
	qdh2T07FbLJHd6Q==
X-Google-Smtp-Source: AGHT+IHQzdSZ82jcTne/l2ISXClWBAl+Hfk9twMcldQI3TPJGodYo0otvEePDBo0fV6ShiWzDKl2BA==
X-Received: by 2002:a05:6122:547:b0:50d:a31c:678c with SMTP id 71dfb90a1353d-52480dfd3f2mr1624068e0c.2.1742243925624;
        Mon, 17 Mar 2025 13:38:45 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a5a5432sm1747691e0c.16.2025.03.17.13.38.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 13:38:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] HCI: coredump: Log devcd dumps into the monitor
Date: Mon, 17 Mar 2025 16:38:41 -0400
Message-ID: <20250317203841.598380-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This logs the devcd dumps with hci_recv_diag so they appear in the
monitor traces with proper timestamps which can then be used to relate
the HCI traffic that caused the dump:

= Vendor Diagnostic (len 174)
        42 6c 75 65 74 6f 6f 74 68 20 64 65 76 63 6f 72  Bluetooth devcor
        65 64 75 6d 70 0a 53 74 61 74 65 3a 20 32 0a 00  edump.State: 2..
        43 6f 6e 74 72 6f 6c 6c 65 72 20 4e 61 6d 65 3a  Controller Name:
        20 76 68 63 69 5f 63 74 72 6c 0a 46 69 72 6d 77   vhci_ctrl.Firmw
        61 72 65 20 56 65 72 73 69 6f 6e 3a 20 76 68 63  are Version: vhc
        69 5f 66 77 0a 44 72 69 76 65 72 3a 20 76 68 63  i_fw.Driver: vhc
        69 5f 64 72 76 0a 56 65 6e 64 6f 72 3a 20 76 68  i_drv.Vendor: vh
        63 69 0a 2d 2d 2d 20 53 74 61 72 74 20 64 75 6d  ci.--- Start dum
        70 20 2d 2d 2d 0a 74 65 73 74 20 64 61 74 61 00  p ---.test data.
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00        ..............

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/coredump.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index c18df3a08607..994977a9e652 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -257,6 +257,12 @@ static void hci_devcd_handle_pkt_complete(struct hci_dev *hdev,
 		   hdev->dump.alloc_size);
 
 	dev_coredumpv(&hdev->dev, hdev->dump.head, dump_size, GFP_KERNEL);
+
+	skb = bt_skb_alloc(dump_size, GFP_ATOMIC);
+	if (skb) {
+		skb_put_data(skb, hdev->dump.head, dump_size);
+		hci_recv_diag(hdev, skb);
+	}
 }
 
 static void hci_devcd_handle_pkt_abort(struct hci_dev *hdev,
@@ -277,6 +283,12 @@ static void hci_devcd_handle_pkt_abort(struct hci_dev *hdev,
 
 	/* Emit a devcoredump with the available data */
 	dev_coredumpv(&hdev->dev, hdev->dump.head, dump_size, GFP_KERNEL);
+
+	skb = bt_skb_alloc(dump_size, GFP_ATOMIC);
+	if (skb) {
+		skb_put_data(skb, hdev->dump.head, dump_size);
+		hci_recv_diag(hdev, skb);
+	}
 }
 
 /* Bluetooth devcoredump state machine.
-- 
2.48.1

