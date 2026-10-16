Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B593932C6
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 02:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116655; cv=none; b=ca7ru4bXb1UxBvbxcH2EMEZ5OXVNLzy0jK+zdvqww499yc7uZstBpiVHqeXk9SrqOke77c/uCVmtqyftj9IseRt/IazgUPeJdRO3s2V06Jl9k4+v5VFihx5hqdt6O0xoZPCnG7uP5LOaz70H/WKNQi6mTXCDNa4sxQ99tSMB1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116655; c=relaxed/simple;
	bh=KW7Gxhb9Rs7qDsVvu/Q6QOOYw2rabRWMk5SbCksXKzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHQZQSxoZ8gubfeYDLpErrIOzOliRp0OqB0pmDh2+m8VvFXnzMzcTj1ZH9B8wMm8b92koRdxL0khm4/wSTanZaVkrF2h3zIN8+oBtkWyf3Cl8KhiN23snNdP59gTf30gHtgvpIFW9/pcHhkzhOfD7PXal76LJqqMULl3ajJ0vMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=eb1ZUjcB; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="eb1ZUjcB"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so4219004eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 19:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792116653; x=1792721453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cv7YGJljtETyHQvSebav9gk0BxMvhnrylSgDpKzc0l8=;
        b=eb1ZUjcBOQpCvH6YlIrE4Nbd+BbLhike/naXXFfZYDLEKxkqwFtS7mHeONUl1mfOTy
         ugys6CgeQL+rv5WEb4kkE8oD3TtRulRoHLHUtB6ev+uMIf8Yeu35/DUKcR1wxYTZ9c6X
         qZb68keuuwpfyEsvjh13cRqiF7ZRC8FHvlyFp5AVKfyz66Vdf+eGY15GO18qJTJFx/VP
         /q4nFquEjqM81gHRPw5v9jZn9HqFY+SXutmS//HY2mUjtdPsC5FBJJ3AH7oQFwGPVtSj
         xdsV3yIVVEzMPPE5N0/MkE5mmqzIYyyZjWJzOxNAYBcU+HUWP0q11awxxTsxo82RNRoF
         lt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116653; x=1792721453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cv7YGJljtETyHQvSebav9gk0BxMvhnrylSgDpKzc0l8=;
        b=2fywy3+9nrqgHFqz4XoyqwuVG74siAQEgj10Dpq1d4Bc0G2uNI0/2/GjN36OEZ2d+z
         R68yZXhRIDbzzWwpASQMiEDuX7LQxpg4pQRXe+yK06tjb6yRSlfbAV+79mNO5aCq94G7
         871wrHsw9n/8I6At5fiP2bHfIKuO8lZovzcBQmken4gqk240v2+jO9UA/zcmwz+8dqPk
         AdC57qp2CrUMS2FjXTmE2PcCiC7KBOMK71LxWHsR9/Q8K4DJD8Brw58dVJpLriX5jDq8
         NGKkuihE6jF7v5KX7Uqu54maTS17GP/DuuuvzD8oCjESZfI3FQZCLwhwjcuBxNgZ4EMf
         24OQ==
X-Forwarded-Encrypted: i=1; AKwUvBziHlgujXtnnSaSYVAgTSmHFm7jUVVZoBbtuPudg/XwjUeFYQkt5K3VGMl00M6xIygRhVkcrB4AQ6CcpEfMYlg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMHx9vtoY4dLTaWgibbTZSZDoklXKmN3Zrdc3VLpr+6y++kQ5f
	RMRv89bFlg8EPKsHDSU7LXBM+WMm+a4Ee43bpYRyKCNcBv2iweO2lby2sJKKJ3dBYuA=
X-Gm-Gg: AYBFou0hUvkAt75lCzCCBPLgG7CZvTNJNxZJdJVVB62+r8KokG2zjcYyagxL4z0IJ3W
	oCW7WOHmaf4dst3kNS+mtkoD5a6NDyBD3SJlYDtaav2XXeyd++JyJVoyohhhzOBV1Lw+8HwZV3w
	5AhvNbV7w6yZF8L3Xnbc8X5WaZv+N2V/1hIjv4hkjR256bTPErwPbi7hdGztEukbkVz8mZW3ZeM
	xTZuKKZ3cBz0W/3FltyUUFTDbrmD0fJs+TkpIDBSEPKSX9n4hEHdV8h3ayz1ycVt8HaIg5brcl3
	RWpv9DqkD9RsfAxJsxNFx4/ql53WIPogRqj6RShtVNuvL5kjj/ah+Su0CqhqGuhYU1C4Ib6yNo1
	ELlo3i3R0PqAGMNECaBBUBdwE8885OrVwuofjqmglmGRW55lwX2lGb8cLIcsRLTdS0QCnyO+s5F
	tlf/o5ktdsXzBj+KrOgsZxq5uZWA0kLR+DVj151jmAmA8EWkkQY6HZyTbCQ3YEg8dFYoP5oRT9C
	IDRNObKrGfZ9Jdv4V3vxDJRpVyWi640ldIZDDJZTzPAj8T/uvaIWt7kRJvTDw0NsBrbiQE=
X-Received: by 2002:a05:7301:6e9a:b0:358:dfed:d0fe with SMTP id 5a478bee46e88-358dfedd5fbmr22336352eec.5.1792116653426;
        Thu, 15 Oct 2026 19:10:53 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d66:d0e8:dae3:3257])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608308a87csm2638280eec.28.2026.10.15.19.10.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 19:10:53 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: halves@igalia.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org
Subject: [PATCH 6.6.y 1/2] Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close
Date: Thu, 15 Oct 2026 22:10:46 -0400
Message-ID: <20261016021047.16461-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016021047.16461-1-artem@trailofbits.com>
References: <20261016021047.16461-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heitor Alves de Siqueira <halves@igalia.com>

[ Upstream commit 525daaea459fc215f432de1b8debbd9144bf97b0 ]

Since hci_dev_close_sync() can now be called during the reset path, we
should also set HCI_CMD_DRAIN_WORKQUEUE. This avoids queuing timeouts
while the hdev workqueue is being drained.

Fixes: 877afadad2dc ("Bluetooth: When HCI work queue is drained, only queue chained work")
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2026-63974 to 6.6.y.

The code changes are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 net/bluetooth/hci_sync.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 607667cc357558ffefa812e1cf001ca923fdbf78..0c96e048d8816016c44f8d1b90c99f4addda8ed8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5349,6 +5349,12 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	bt_dev_dbg(hdev, "");
 
+	/* Set HCI_DRAIN_WORKQUEUE flag to prevent queuing work during
+	 * reset/close. See hci_cmd_work() and handle_cmd_cnt_and_timer().
+	 */
+	hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
+	synchronize_rcu();
+
 	cancel_delayed_work(&hdev->power_off);
 	cancel_delayed_work(&hdev->ncmd_timer);
 	cancel_delayed_work(&hdev->le_scan_disable);
@@ -5367,6 +5373,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
 		cancel_delayed_work_sync(&hdev->cmd_timer);
+		hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
 		return err;
 	}
 
@@ -5467,6 +5474,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	/* Clear flags */
 	hdev->flags &= BIT(HCI_RAW);
 	hci_dev_clear_volatile_flags(hdev);
+	hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
 
 	memset(hdev->eir, 0, sizeof(hdev->eir));
 	memset(hdev->dev_class, 0, sizeof(hdev->dev_class));
