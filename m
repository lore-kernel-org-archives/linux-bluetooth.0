Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6270227A465
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749147181; cv=none; b=lmZYRsknBvRCPGZhZcbSvuGypZONsM8vomdbLSbW2ejDa+7hAYqiToSpW2v5VKPrgxH+paSvIYJuddRZPHpbzPP4aO4W62/JusxicudwQAEJYVds5DL7a0+o6xDX83SCp1lJYhsH4+YqFtoPR+zd8xr8MhfMjPdCW5+GMuE4TYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749147181; c=relaxed/simple;
	bh=bLV94iYs5sO8hKgnOAlnI1xhbQCFsJ2Z6RSmyGPiG9M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=O8+UjGGf53FxGrsW7IjztDtfY9rGbcpNVZxqDXmwb+nf4Rn95tGPKUWwdPQ3DyfBHK52WFZVK7MYurkQ3llkRELIlkuGQs9UpCtBDLmIEI+PB5pL39JLCKZ7JaCrPg84A0xrtpRzHJ0fL574cixgp91c6lXVEiifbZDJknV5qnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISAPyLcE; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISAPyLcE"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-530807a8669so450257e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jun 2025 11:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749147178; x=1749751978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNiopItGaUkyF0iI7mVuCgT2YA7k5qfRx5jo7k/7fOo=;
        b=ISAPyLcEQ/wNPSK5d2BYdWg9Z0jfnY8yy+udOLd3FRaUvzgHOZPmaIgWesKywU+/Mf
         bunbsCW4arFIJMEL29ljLX6rpe1QjkBzpmQ4xjjfVbOaJHKVuIsVIGTsFxKNHVdMJLA8
         NhF4bgksiPPN7pLg7dbqpy7oWOWNlxtWHCAJ12ZiISCoHjkmD64kmOaZhrz5dquKauLN
         auw80mpreN4OnzygoPR3vlYRXUE2jQIimBbE376QLgMsptp7/hlpSI95uv3yX9/E4UvV
         GwMuNLlqQccPB96dTPsByv8HiQRrr3aR9oLIXtkv0NWH8F8iVtMi/GbLDEDp6t5RAgNE
         6ZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749147178; x=1749751978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNiopItGaUkyF0iI7mVuCgT2YA7k5qfRx5jo7k/7fOo=;
        b=XA09CT32DqZ2RzMnRaM3pFtZYAwELORfT0UAg+ZA7UKSznCUnzoce4jkovI/tmqO9D
         w5JcP9k4Ah/q/DmgtxSCcL9HTnZokZtxT6J8X0WEdPJRY2orZk+76jlaspIvTOQrEMUV
         ioXu7TcKK890t6Nvt6H2q+LyzwL6djMM6f1cmmVG1yKL9vg2sAfcf5gOBtK5Uixuq8QO
         hxdvrhevPwnqDS52Mc7cNFXAi8oYu734XjeMrPUFGxmfV/FloUhw2AhbaAX0hAAukxh+
         EqWg+Sd9FeK73IojLVyvPMoAJo6HO3V9OhtV8OEQQIr3O/muy/uyaHsg4SgrrNyz9UV9
         PT2A==
X-Gm-Message-State: AOJu0YzEHslYb6d9S/Z9GWCM5hEFIBYgpyuSBGEdom7sS2X7e8u3+2O4
	A8S2qUvKSLZpLSRhsd+19aPs7+s4uwNBupZUBAoWqjcjblxQhY1WM0jpvpyqwraKn0E=
X-Gm-Gg: ASbGncsY/Jda8vziLrZULgj+60SXpLRr5JSdSO0iLhiRBUft0oWw9AJ0MJDjeBa9kDc
	7irVA/gA02DxqN1ah24FnJxhIuYODfXTBrHdqXDbzEEQlAWr7OFsPzoZye2fn685hyVCQ9s5AKq
	Mcq++4Gvj/QvNrALPtdNZq+BpGbqGwGmaI3zY1SQZ2tQJ1vfxBI1VEL7iVM6Oi8lCXTKvMSlANM
	LNEoJ1nlHzcKjoMG5rP8A2p3XEHnzM7R74WtbUbZy9OKlSSAH/lx7njYg7Rm2FT65oapocsyjoR
	4UH8V8iqru7PedRh/Iw94qcRxFRjhFprkS+V02/2uqjKmcbRc0HS3I7xjK3wtMnBmPUaqrGNALe
	VjBWK+u2ddp3cfJfTwdLp
X-Google-Smtp-Source: AGHT+IEHCVAlLuJ2gBDlRTIPpyKcy5AfSKQzXYwtObK2cjYUftuvV+Z7CdfnjmODEUPHnF+hce167A==
X-Received: by 2002:a05:6102:809e:b0:4e7:3d55:5212 with SMTP id ada2fe7eead31-4e7729f4214mr485445137.11.1749147178493;
        Thu, 05 Jun 2025 11:12:58 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87ebd194c7bsm4173241.3.2025.06.05.11.12.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 11:12:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] adapter: Fix exposing coordinate sets if LE Audio is disabled
Date: Thu,  5 Jun 2025 14:12:54 -0400
Message-ID: <20250605181256.853484-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes exposing non-discoverable coordinate set members if LE Audio
is disabled since it may lead system device setting showing them to user
that may attempt to pair them and end up not working.

Fixes: https://github.com/bluez/bluez/issues/523
---
 src/adapter.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2417e3cea960..70141e1542d7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7356,11 +7356,12 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 				MGMT_SETTING_ISO_SYNC_RECEIVER))
 			monitoring = true;
 
-		/* Monitor Devices advertising RSI since those can be
-		 * coordinated sets not marked as visible but their object are
-		 * needed.
+		/* If ISO  Socket is enabled, monitor Devices advertising RSI
+		 * since those can be coordinated sets not marked as visible but
+		 * their object are needed.
 		 */
-		if (eir_data.rsi)
+		if (btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET) &&
+						eir_data.rsi)
 			monitoring = true;
 
 		if (!discoverable && !monitoring) {
-- 
2.49.0

