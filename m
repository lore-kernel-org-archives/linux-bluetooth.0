Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF769399890
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116924; cv=none; b=k8A4z/xksyHegYyO0ADHjsB0a4BssYEB0eQapKagrzUD9LxmRTjX7osRS2UazkhpcImGdrEm/kaSSAwzmDenjxycnOxuLC/ZORa4kmSXxMoeMNZl/i3vPox5XpW2LgIzpo3jKNdlUybVvbGiwxVLZx/1LfnzAlYjBXvwsJtqff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116924; c=relaxed/simple;
	bh=brkVOHrBWqwYBSh4vVHXBq8X4XZ3NU20+5+9rKzi3Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ggTj8SfMKUe41A5Z0v3ozlnXuven4jCzKYPp4KRIurbv2g8tAsGtyRqQpd/eza24j3rOecwfV8koZjoNwdatz2ctpExt+rLxQM2t/eRhg+m0MZcv8so0yjBk3wJto3ghMxBur4AklK7k0rjUFcnUMcHwK760hxhSnfHdB63fUWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=cHPuRpg7; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="cHPuRpg7"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35943f55c06so708886eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 19:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792116922; x=1792721722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KetdpdwOSj7956r3ldfd9Rrxy2aA2uCf7cxzgWAH5cU=;
        b=cHPuRpg7FNPFYb6prMZIU7M4HRT2ynCv0cZBQSsU5kp4Xv4I6y/9T/UIwLTzRyxbzQ
         CvH1lbiZU/BQjH9X16OJ1RAm8CD6/jNJQaF0A6rZNxPK5y3jeFsWtpAwEIU336Zx+mm7
         Dhq0/w7MelzGOW0v9UWPzuofXc5h6YOpE8hH1gU0vYzRCWu8va7pFCUqnR4xIluT8RXq
         sc0at183zGDkIiBFihiDyJDlVfEe/yUlqyWD0qYLMCaMobnkl+LT/rourk0k2iHg/GWm
         nEHdwkovfTt5oos3xwN+2f7I6RVudiQqJYfo/SaaKA5ni5qHtMi1SMRhObqH0j/G9A4r
         fbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116922; x=1792721722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KetdpdwOSj7956r3ldfd9Rrxy2aA2uCf7cxzgWAH5cU=;
        b=ryjK7L/QELG5yHLIJhif7CLdGGTRWOFIYPBd8jlLTOSve7qCV4+BPU0FMmZvLnHFxz
         MDQ45k+aElZRlw6045yDXv8pUnCskvLZN7u6JmAfcGeiYMOQLe3t2qg68okpcSK7kfOy
         P7BfQcljnirCl4S5qf3AdD2VScq+feyjijerMynoyH+iihoZ5flv8Bn6I9TohZRLjoUs
         dXQkaLOnLbxroBOQmodexEW7jEWpyxfcB7ARHPYk8lXtYc3w5OQK8F0iU3uCHKeMqVdP
         pcgsbdeNbCP6WzjULEsd01u4dx0ZZVmpOG+Nd+6nNrP4Nuzpc5AgyDCjwmQpUf8tJvnn
         71IQ==
X-Gm-Message-State: AFq9FYJc851eCBy8Wa1G9q0/0u49T8lDc1K/kX9ueY7a3qMF8gCYJBZX
	tfWknkvm31lJmNlTEIf3hcaCU1yuRa67dGGlHsNH/rg5ybtxbKqlDw6UHTb2SbHAPpo=
X-Gm-Gg: AYBFou3G4LxH5VE6SpCd3YJp2i1QNZJpeanh68CTbM4hSghqTOkdcD4etwBa0dLt7EO
	YFzGQT7X+DhAjjDgPtA/IwtmnQFL/WXBJSP+F3S9wnnl4pm5JJEFJe3u5UyLNzwrLHM2l+fVh7p
	Wk/C3NbheWlzxI35aUpUKNNZKguJtSR9OzL7sLp2SPPUKb5O1HiRPI2EqMoAQfG5E2cszi2Nn1d
	hmHaWXYXgFF60r5HuBZ/WpqclCqN06CWHdnV7v+bmcDdkv/9wJ1ImCk2H0QcrMiAHzyGnT+Caqp
	LFOHi2WItsAdhvmMYkcnGO4i0YiYRH5R0nCwkpK86sYuvHvT5f5nG++IEtJ87uadb600xMpxGg1
	L21DjL97CbqfBZTqq/ySyS6o5v1xMOeqkHfPAGaqyVQoWKCCN2c3bz9UauxmpXeglJzAhIsAunU
	58d1SnTwdLwu7tfUu2CrOtveWeX5BQDop4URoHRVvitRZKb3w4nSXUHiq7zF3XpBOVjNQP9c19+
	n+LhwY+LIR0NTV224uBQlHKMjYkgGGAapQJJ01HgKCadLKcqODdCgFk5WI/rw5TMolfFw==
X-Received: by 2002:a05:7300:fb17:b0:341:c383:9afb with SMTP id 5a478bee46e88-3602ef82f4emr2267276eec.20.1792116920170;
        Thu, 15 Oct 2026 19:15:20 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d66:d0e8:dae3:3257])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cc23sm2221123eec.2.2026.10.15.19.15.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 19:15:19 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org
Subject: [PATCH 6.6.y] Bluetooth: eir: Fix possible crashes on eir_create_adv_data
Date: Thu, 15 Oct 2026 22:15:17 -0400
Message-ID: <20261016021517.16686-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 47c03902269aff377f959dc3fd94a9733aa31d6e ]

eir_create_adv_data may attempt to add EIR_FLAGS and EIR_TX_POWER
without checking if that would fit.

Link: https://github.com/bluez/bluez/issues/1117#issuecomment-2958244066
Fixes: 01ce70b0a274 ("Bluetooth: eir: Move EIR/Adv Data functions to its own file")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Assisted-by: LLM
[ Backport to 6.6.y: The extended advertising PDU is stack allocated here,
  rather than addressed through pdu->data. Pass pdu.data and
  sizeof(pdu.data), the actual HCI_MAX_EXT_AD_LENGTH capacity, so all
  optional advertising additions remain bounded by their caller buffer. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2025-38303 to 6.6.y.

The code changes follow upstream, except the extended advertising call
uses its stack buffer and sizeof(pdu.data); see the backport note.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 net/bluetooth/eir.c      |    7 ++++---
 net/bluetooth/eir.h      |    2 +-
 net/bluetooth/hci_sync.c |    5 +++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 7a28baa2b71feccc8bd7ff3f1d45b6b1f39984f7..2f695f1c69b36b129d9e52ed1453c91f3e2662b0 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -242,7 +242,7 @@ u8 eir_create_per_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 	return ad_len;
 }
 
-u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
+u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 size)
 {
 	struct adv_info *adv = NULL;
 	u8 ad_len = 0, flags = 0;
@@ -286,7 +286,7 @@ u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		/* If flags would still be empty, then there is no need to
 		 * include the "Flags" AD field".
 		 */
-		if (flags) {
+		if (flags && (ad_len + eir_precalc_len(1) <= size)) {
 			ptr[0] = 0x02;
 			ptr[1] = EIR_FLAGS;
 			ptr[2] = flags;
@@ -316,7 +316,8 @@ skip_flags:
 		}
 
 		/* Provide Tx Power only if we can provide a valid value for it */
-		if (adv_tx_power != HCI_TX_POWER_INVALID) {
+		if (adv_tx_power != HCI_TX_POWER_INVALID &&
+		    (ad_len + eir_precalc_len(1) <= size)) {
 			ptr[0] = 0x02;
 			ptr[1] = EIR_TX_POWER;
 			ptr[2] = (u8)adv_tx_power;
diff --git a/net/bluetooth/eir.h b/net/bluetooth/eir.h
index 0df19f2f4af94499defe78897e8c78fd0dbc2daf..4497f8fd5fefb5eed4d70477fb0fdf9feebe7fe4 100644
--- a/net/bluetooth/eir.h
+++ b/net/bluetooth/eir.h
@@ -9,7 +9,7 @@
 
 void eir_create(struct hci_dev *hdev, u8 *data);
 
-u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr);
+u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 size);
 u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr);
 u8 eir_create_per_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 607667cc357558ffefa812e1cf001ca923fdbf78..e73b4021dc6505924d6befaf667dadcaca6f0526 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1334,7 +1334,8 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 		}
 	}
 
-	len = eir_create_adv_data(hdev, instance, pdu.data);
+	len = eir_create_adv_data(hdev, instance, pdu.data,
+				  sizeof(pdu.data));
 
 	pdu.cp.length = len;
 	pdu.cp.handle = instance;
@@ -1376,7 +1377,7 @@ static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
 
 	memset(&cp, 0, sizeof(cp));
 
-	len = eir_create_adv_data(hdev, instance, cp.data);
+	len = eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.data));
 
 	/* There's nothing to do if the data hasn't changed */
 	if (hdev->adv_data_len == len &&
