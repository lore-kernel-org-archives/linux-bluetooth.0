Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1D9143C41
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721946896; cv=none; b=GhF6V1MsoMyCdGNpBXOSONGoF4n8O6Wr5acPncP64vKnrx1MzYwbFa4p22c0GNT4DMd67Fv1TR2KGrmCscQYdoDVRWegGmqkMenEnaXuhXRVpQ2yBo5Nmh1yIINrELVEZbKkm3aseJSoGECxKowhp/zP0wIOu/8DzSZmUfZ5EIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721946896; c=relaxed/simple;
	bh=lalISMzv6OEBtAre1W5LUw+jOMoafGGITRWuI290cJE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OZk6brhx6YISbgfpPHD2QoFgSdf8RZwsCgpE24Yejve67VPwuGbmZFFEPrSFKxbsyGsPA/EFlu4s991BDMVepbsP9/XbBrDM8f8ruVYMISB7/nXdAKrmD/zT88LvwyBuRl/FtJB7BwKoH2j+JNIr+r87l3Qe/IbW6iAnPBFwbmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsI7ew2/; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsI7ew2/"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4ef33a09a3aso17510e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 15:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721946893; x=1722551693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=01uSW1wdxu5dPvbywwjCapFDAY+sBClHDrcrGI/f5sQ=;
        b=ZsI7ew2/2ty0gixQf+zhD6xrHCmNUalUsVavOeAQBnmy7w3cQ+Mk4YxiA81gdmkudK
         s4B8c/Lecz/ox/wOdHc+jy4j2LEWUQwg1cF8kZRflE5RVVM81ilLdZak1wwvB+GSf8/h
         qe+0MsRjB2EKjVXGu3lgB/JMF4NagLs5/vIJkH0YH2mBh7NIxH7ddoRKIsmMY7gac/An
         svZD1EcLX9Fu6RpR84S/f29irBMMkf2dSHgQMsAnJUuQzjMkOG9oSGFYMdfbSHOCi+yQ
         xmGQpIGBunOvH2a2gFPmwc5qLaBauNaC0y6lEfPvIqlAnPfXgKksn79+P9y8zYTYAEAM
         hIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721946893; x=1722551693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=01uSW1wdxu5dPvbywwjCapFDAY+sBClHDrcrGI/f5sQ=;
        b=avapLh6phWCg2QgeRD5xAYe3hNpWy//K8mSrGBTLTA2lTPNwtCoK/JDdE/cBw7GoxM
         TM8wQG0kLFRapCHgSGh6aIz5YH9jFEdoeKQpnQdavTpwQS+APW6lPTVLPS58hVXcdHxg
         dW2J04wtqzhwCGCEcyttF3mMxmvOkMYDzFO3Esmia+FmWBn1pVPEidd0yvIPOLfez9Ny
         LIksVm42obK3eUJcc0ZoZWPCpwLyqc7PJQ3T/sik7JUdPznIiSP7A/W+syVgm3IHdKbY
         R1nZ1+8dG5TlNIQP0KY4ZtleDwjHRjGWLs5acl1PUWCx0BgLmQ2SPtnuCO1g9QJYL34M
         FM+A==
X-Gm-Message-State: AOJu0YyxybfHR3xvDf2WmHofiYVqvlgRzaiyF9ldSv4t6kIChrkujZu7
	dGJpJgxBQHbwX+uyE2PA04T7Fg+aPAzApfLP1mXsJbFn8XTfZhghy5Bdeg==
X-Google-Smtp-Source: AGHT+IGSLTPuUlCLIMVBiVabvyY0HXCxat+a23GGssx4RPPGQl00VN41Vc1JAa+mS0Qi6TrJ03B3+w==
X-Received: by 2002:a05:6122:2916:b0:4f5:199b:2a7f with SMTP id 71dfb90a1353d-4f6c5bd649cmr4907499e0c.8.1721946892972;
        Thu, 25 Jul 2024 15:34:52 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f6c88a3b57sm335851e0c.55.2024.07.25.15.34.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 15:34:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_event: Fix setting DISCOVERY_FINDING for passive scanning
Date: Thu, 25 Jul 2024 18:34:51 -0400
Message-ID: <20240725223451.3208825-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

DISCOVERY_FINDING shall only be set for active scanning as passive
scanning is not meant to generate MGMT Device Found events causing
discovering state to go out of sync since userspace would believe it
is discovering when in fact it is just passive scanning.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219088
Fixes: 2e2515c1ba38 ("Bluetooth: hci_event: Set DISCOVERY_FINDING on SCAN_ENABLED")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c  | 7 -------
 net/bluetooth/hci_event.c | 5 +++--
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8a4ebd93adfc..06da8ac13dca 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -119,13 +119,6 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 	case DISCOVERY_STARTING:
 		break;
 	case DISCOVERY_FINDING:
-		/* If discovery was not started then it was initiated by the
-		 * MGMT interface so no MGMT event shall be generated either
-		 */
-		if (old_state != DISCOVERY_STARTING) {
-			hdev->discovery.state = old_state;
-			return;
-		}
 		mgmt_discovering(hdev, 1);
 		break;
 	case DISCOVERY_RESOLVING:
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dce8035ca799..d0c118c47f6c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1721,9 +1721,10 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 	switch (enable) {
 	case LE_SCAN_ENABLE:
 		hci_dev_set_flag(hdev, HCI_LE_SCAN);
-		if (hdev->le_scan_type == LE_SCAN_ACTIVE)
+		if (hdev->le_scan_type == LE_SCAN_ACTIVE) {
 			clear_pending_adv_report(hdev);
-		hci_discovery_set_state(hdev, DISCOVERY_FINDING);
+			hci_discovery_set_state(hdev, DISCOVERY_FINDING);
+		}
 		break;
 
 	case LE_SCAN_DISABLE:
-- 
2.45.2

