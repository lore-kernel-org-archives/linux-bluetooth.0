Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D383E2769
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766157; cv=none; b=qDWdlvrLSWMcTGfpPvGjMSF4Hw06i4SA9f7reoltGhmRDnVYOcAsnjV8kU8RlWa+35gId5DY0Nhx345HzmjNoeMiBEdTeUbe/0BZoZyADybcERwfeFsWyqA66DT7krKisWQXkorYuhPMk+sh49iGLJKKUU2OlPI1QtVHOupq5A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766157; c=relaxed/simple;
	bh=/BOSYZwdP3Y72UdeTvMYDBpuq5nOXJfxopEqPo/Zaxk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QGnMHt0hFQIBjNBm6RWlJuSAMlBMgbHaXuIE6V6YjxYx5dXUdV4P281QgZ7M/CIIwDzWJ0haR+z3xl3sVs44zP+kQzztAqPEt7TSeat7Hl9jdYqRYnW0cY1iSIFO2LgRquYTGrA+O1AgJV2OVMyuLLhVq5Jhj4mkt1ZUp8lfwvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPc+eU1b; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPc+eU1b"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-95cc1a5fe9cso2329698241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 06:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778766154; x=1779370954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uhJsZp5ktqeMqlyTdzi3zB7+AfTtFaogLD4b5p8yEWU=;
        b=jPc+eU1bmuJ/VUyZFsgQHSoeqKCq0wiHEGcDxScm1cEIFJbS6GpTztgDTFJQuxSWWq
         HgZ0jN9R8ghnFtNxoOnPVGhHQpQo1k42fcKXta1fVF/hiMFW9ekkH8q54UHmh/Kzku/Q
         FVm/xl/KyEakRQbw7KqV+BhK/qKmtlcOipVCujkWLMZU0Y7N+gm4Gkwzy8TCA9pFA9GN
         hvZzjgpGhMbf79zda29G4qisDbYWG8V4TfuRTyVRJFbPJl7sSYl6z3Yu/OAHTx06yJs/
         Ik9Yt466D6pRzckgPWmRhxaRzrQLHzxWSK847mDvfzK4APrZLYwA2T8WV9YUde2DnU5v
         y5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778766154; x=1779370954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhJsZp5ktqeMqlyTdzi3zB7+AfTtFaogLD4b5p8yEWU=;
        b=R/LrDsenkOXIcSakYb5M0UaQ4m3T79D5Se6LSGHOhysNTOHkOVe7ctIrwncDbrjqRy
         ZIIGRgQXCKeZHrtjvpnUgKPnrGPzgwJ08PUzQdy+bFuUDNrLROKRsDJpUyTmaHKMRdGn
         LiY4OM1yVygruAxU44wcbXFJMTZj/exsWVFfaEWYfyLQ4KYTxpF2lAYB5rAXGHT42t9S
         W09iR3Ka6EDBK1z5ZIuZwEg4dug43451Cif1om0E1I476R9NOd/Tbmbfw1mT7d42Zvqh
         Xr9nc27k809p4qBXktqjVZ0gMnFX5YwUBge5CjzKgKDoFgPav5ySF7HofCAaOxRgxWGE
         IztQ==
X-Gm-Message-State: AOJu0YzWi0ekCWj9iDCcVl+p+xAzY8iKmUKrEQ8qYFFTWDol/tJkDLOn
	giiH52g/Uaf4z4/I8m4so5bAp+q0s1s4zBXDE48UnmzhYoiiQ43ChXOOljtDwFoHMCc=
X-Gm-Gg: Acq92OHY2ND5E1JUFHYoeYjihPt0mlRS8KZBguLSYW9VZ8fdpAjXi+HabruAmcmTPP4
	uKi856EoR6KGMwUZy3amnnP9Wq5KTRToea0BvfdSjE2nSwa+wOG8g2203E8aJhmBA0SlnGAsP6l
	XVXUEVa3nNOaZpLLNtaz0vpCsOgbrGx4X3GtugTtlEgrw9HRHkt8PMqh6AzzxeccNoPAFoSujiD
	qm3wA8UOFxtdLeclhoEOQc19bdpUjz/Hmjt8phWKUeiaGdSYZl3Pzcz+Wr8uhtA5BNcAYohFM7P
	8f31qD9m59RSQ1ohrd1OLx8ooKDbM2YgGyrGK7fRl3A1qPDuteVrh/O1o9NYSr4Kbmx01RnQoyE
	mix7C2x3XBxKE1OzBkpYgOb3/UyOyZHXFwp9KFqDrJrC+VgfVBAmnfhr4rGx0cWc/AcjaIzGEAB
	n/QgQ7DoZJYSsv/rrMn/uyOqzUMX2Z7yHiCAs48RrKVSV4kHK+TzNaZAEj0tFfg7Hm/pOSRSIbT
	hQK4nLAEvgyz1EEexRVUUdv06Rqb8puPgsnic0=
X-Received: by 2002:a05:6102:5345:b0:62f:4387:fcb4 with SMTP id ada2fe7eead31-6376e34d644mr3999807137.0.1778766153800;
        Thu, 14 May 2026 06:42:33 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6390a6d0f53sm1145532137.9.2026.05.14.06.42.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 06:42:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix not setting mask for HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE
Date: Thu, 14 May 2026 09:42:24 -0400
Message-ID: <20260514134224.1396820-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not setting the bit for HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE
when extended features bit is set otherwise the controller may not
generate HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE causing
hci_le_read_all_remote_features_sync to timeout waiting for it.

Also remove dead code.

Fixes: a106e50be74b ("Bluetooth: HCI: Add support for LL Extended Feature Set")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd3aacdea512..aff8562a8690 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4438,6 +4438,9 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 		events[4] |= 0x02;	/* LE BIG Info Advertising Report */
 	}
 
+	if (ll_ext_feature_capable(hdev))
+		events[5] |= BIT(2);
+
 	if (le_cs_capable(hdev)) {
 		/* Channel Sounding events */
 		events[5] |= 0x08;	/* LE CS Read Remote Supported Cap Complete event */
@@ -7413,9 +7416,6 @@ static int hci_le_read_all_remote_features_sync(struct hci_dev *hdev,
 					sizeof(cp), &cp,
 					HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE,
 					HCI_CMD_TIMEOUT, NULL);
-
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_READ_ALL_REMOTE_FEATURES,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
 static int hci_le_read_remote_features_sync(struct hci_dev *hdev, void *data)
-- 
2.53.0

