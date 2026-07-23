Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF282E2663
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825047; cv=none; b=T5KbqqsPzrEupPzv3dM8IDYe+QQCoq1XX1Kxeu+m6rP9gTQvJblKXSzdrNP9ei8EzeAVd1o1ElBN4SC4Q70jRLH49sVMO8ctkjhrOp4gvI74WJt0T/s4MwmiSPcdQifIyL2huX6M10sFT7sbVoaxd0qpn0kPEWPD5dCVOWX9bB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825047; c=relaxed/simple;
	bh=qeLZZ29fTRrX+xSMcl4SVCTIqwjnq7+uNxKq1GDXDH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9oM9AZLnXxVoWMLGF/Nd9sfwwLN/A8z1kBL2rW3LTsRNzThuXsEj9SnvZXUD6GoyzEdh3HIp3fLpv4Kh1zUNZIuhqNBiwf2nY/ZyD0MEse9ywqSmJQgQI46ivjV+m2UVQ0I9jzTdZNd3C381fdDzMu94hUCOCE9bxGfWnmtbTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDvZaI34; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDvZaI34"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc61541f8cso7887825ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784825045; x=1785429845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Evd7O7PI4xaLa2YZZmfvf/wxcxbA1V/T4p9Rf11Lvao=;
        b=fDvZaI34SSPmj5Crr7XEralkGbqLEsVT4C85EwwFzfw+JfbtsveFqMYGqut8seJ09E
         P78MH82GcNslKk9ztBDp3siVU6VR6CW9RIAwW2Kch48DOaic0jc5kIEDI9NZWmE1Vlnz
         t4Qrww9PoGz9mxdXF/s+TD9CHLd0RXbtKmFnH1BRXiX2/HX4iAI96FvqTjHVVo/Fk11H
         i792+PiOCVJHEryi7KpPJFqfmCa2CllpUvU2C18acHh3TkcbixfxuBHoda56G9+Hw62T
         lB9Z/l4uBq/720LrKwRNMXSBltunI/3SzoMji6iJDHvsAtkfFqV/RrEZ9cNM7xRFvUhC
         2wLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825045; x=1785429845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Evd7O7PI4xaLa2YZZmfvf/wxcxbA1V/T4p9Rf11Lvao=;
        b=gOmFsjat57TadUwUK2JDWmERrNbkFARSkZ8KCNhuBC3HF0kczmKzNv26GkvwWkKWFi
         hjp6sfQ6tFQgvRwKsL6WwH8D22LGbE7VDsOkL5onAuPBcy56BxqBc1ln6f981yga5GkX
         /PeQxA00bUL+ftpdFVL2/4p5LxuFXg+9aaeK515vcV+uWq9ERPZJgjrcb3jPg/wFs6AB
         UxlVG3y801860RsZBdk0Qct4WbpgEkKg1VXQHco+NMG+YleSoO5BM8LEE/mVNfhYKbeC
         8Yo2Mf7Aencoke9Ap2pUn0cn4Xb1tCZCcVHiFyjYTNkd9vzEG04/fYSVY45F6QF2hquV
         rhKQ==
X-Gm-Message-State: AOJu0YwdrpxNhKHJD/IbmEy3LkaLw8FevJQuznqjFFpBpSbsZ/G17t+t
	eheeZWirYUiDLSK9OHoP0fJYbWtWlk6Q31L/JJ5fTghcVPonnPHH4Kqpd1L1a9M3yT0=
X-Gm-Gg: AR+sD10w5E3OmbtgFRsTipCthhI32oOIWf/EalK3x0ZneSUIJVnUZ9FSj9fgM9zp4xK
	Z9bBvaz+CblK2TyUhitDpZm8nOoV8gzj7/B0s0wdGAtE0FUX41bUrkdt3p6mz3/IonFgy6mw3vV
	Dgkmt0lE1v+H+/+UCOlrBg/dFaEXhxG/YhQO+MNcCacCDO+6r//pNS28mMDk1/6aLNff6zM+uqF
	rZnETYKnV3rngCwrEdyuQk3e6gHI3N7lil+33S5cnxxEM3QuW2/1poON4vonrvBynUOdoVt2BWb
	VGv9/WO8d2NI6B9aIMPtkAe9FWY9E/M7YAJDcsL7HZZ6W6Ru7lSJ4Um+lmuZACFtIc5UWncldnu
	cwAOV3tkgJ/qnSGrytL8rVzQ6Vz7EwgLfTYG+1PZoUdk3xX7LVleUgS/3+l4V/hN96afAN3+tY5
	eJ0WRUvmcR69HVMMtnWFM=
X-Received: by 2002:a17:903:26cd:b0:2cc:bdb9:3c04 with SMTP id d9443c01a7336-2cfa95215f5mr37282685ad.17.1784825044569;
        Thu, 23 Jul 2026 09:44:04 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd7157sm37049025ad.18.2026.07.23.09.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:44:04 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	dmantipov@yandex.ru,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH 1/1] Bluetooth: mgmt: fix pending command UAF in EIR updates
Date: Fri, 24 Jul 2026 00:43:46 +0800
Message-ID: <4f040d289a0df7b7ee9e9035c8637d2b02083d7f.1784746530.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784746530.git.zihanx@nebusec.ai>
References: <cover.1784746530.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

MGMT_OP_SET_LOCAL_NAME is handled asynchronously on powered controllers
and can run set_name_sync().  When the controller is BR/EDR capable,
set_name_sync() updates the local name and then rebuilds EIR data through
eir_create().  The EIR builder walks hdev->uuids, but the UUID list can
be changed and entries can be freed by MGMT_OP_ADD_UUID and
MGMT_OP_REMOVE_UUID.

pending_eir_or_class() is meant to serialize management commands that
can change EIR or the class of device, but it did not include
MGMT_OP_SET_LOCAL_NAME.  In addition, it walked hdev->mgmt_pending
without hdev->mgmt_pending_lock even though pending commands are added
and removed under that mutex.  A racing command completion can therefore
remove and free a pending command while pending_eir_or_class() is still
inspecting it, leading to a use-after-free in the pending-command list or
allowing a local name update to rebuild EIR while UUID entries are being
removed.

Take hdev->mgmt_pending_lock while scanning hdev->mgmt_pending and treat
MGMT_OP_SET_LOCAL_NAME as an EIR/class-affecting pending command on the
powered asynchronous path.  Check for a conflicting pending command before
copying the new short name so a rejected SET_LOCAL_NAME request does not
modify hdev->short_name.

Fixes: 6fe26f694c82 ("Bluetooth: MGMT: Protect mgmt_pending list with its own lock")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/bluetooth/mgmt.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1db10e0f617f..60d5d838ccb9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2696,18 +2696,28 @@ static int mgmt_hci_cmd_sync(struct sock *sk, struct hci_dev *hdev,
 static bool pending_eir_or_class(struct hci_dev *hdev)
 {
 	struct mgmt_pending_cmd *cmd;
+	bool pending = false;
+
+	mutex_lock(&hdev->mgmt_pending_lock);
 
 	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
 		switch (cmd->opcode) {
 		case MGMT_OP_ADD_UUID:
 		case MGMT_OP_REMOVE_UUID:
 		case MGMT_OP_SET_DEV_CLASS:
+		case MGMT_OP_SET_LOCAL_NAME:
 		case MGMT_OP_SET_POWERED:
-			return true;
+			pending = true;
+			break;
 		}
+
+		if (pending)
+			break;
 	}
 
-	return false;
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
+	return pending;
 }
 
 static const u8 bluetooth_base_uuid[] = {
@@ -4043,6 +4053,12 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
+	if (hdev_is_powered(hdev) && pending_eir_or_class(hdev)) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
+				      MGMT_STATUS_BUSY);
+		goto failed;
+	}
+
 	memcpy(hdev->short_name, cp->short_name, sizeof(hdev->short_name));
 
 	if (!hdev_is_powered(hdev)) {
-- 
2.43.0
