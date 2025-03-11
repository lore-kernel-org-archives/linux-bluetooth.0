Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940923774
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722939; cv=none; b=Y2Ybv1gAiT9Ypf+TJ0WKsjNXfTAi7r8UVb7PeTYnE3+VUWODotWeksscxXnHDfe3igubMF9p9YSUcHfqsWkxzMaOZR4xFrkKmUhNeXm1nY9bpH9ou9ZnpoqPNyhGZkiYgUXuZ59KkpHX9KRrPuBi3xfqsPIbBex31DUCRBKsZj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722939; c=relaxed/simple;
	bh=x7DJ43O6OFaiFqLQReY/wki62pbE1P84CEV0HQZzgv8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZDXwDo1Bl61T9a6u73Zt4SdCgKOc/18kFPZj8r5yhR/2YbnperHxVGPz4p+9XDspvsM4tpdsF7Io+LAIg1I8NK+kzcifQ7C0NHeJ+jEOX0IyiJ0rFFq97dGoVaPnVjg/1iJaWM0TUYLzbZySjYyVk/wLGKJNYBJEoNiCgDvsLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9VIUoAK; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9VIUoAK"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5240764f7c1so1224784e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 12:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741722936; x=1742327736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYfAk8FrBNezPEVCH+yQ9hkmmdOp4rMGm8XAUYcDWUw=;
        b=L9VIUoAKgJYDH2QyWedHBgW01NhrZNKaq53iQODZMqQgW6q5JTaZJBzN//DKGESgUq
         2J0UJsaxT8LiM6rcUeLBnxOdvR7sXAEf8m2IrIHSMXJKhZb30vCzyIMLzgDOla+ExB+9
         v1H2iKnYpOn+m6P/9dbh8fvXba38I0Epa9CVA6dDT2lJbSXWk++Cwhb51630aZH8caNT
         sjvDJJcmfKmKrtoLNaMRN3Z/BsagSgNe2kTjXzhLybkVISA2MUqD3PJJfazURyN1iKVP
         QTWQqcjV7Lb1ip/0hRnc+4etnZg6L1bEHtr+yrJ7TMZzQgPTZoPI1g96pJwNSoNmbsTK
         z7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741722936; x=1742327736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYfAk8FrBNezPEVCH+yQ9hkmmdOp4rMGm8XAUYcDWUw=;
        b=mpxyf0UqI7LZxrQtqjHGu2pRIujnd87VVEkVUhAOyZu+/8znO/3+uFYe+F9yzIUYkE
         1+WBV3OdCOXbzxTJK0mEdtWfxrFPMuIBTXmIgJrXkBfMp5SHkFoVeFaF/dswXTyFsg1g
         sOfhey7/3RlJlb1pvm/d3KD1vvzoTBkWWaZ0vryWQzAcsYZ9xK+lxfyBq6U6Zi2k5cfV
         5TWnW8JI7FvRT/aXNqrl3mTK5qrEpK/Ei2xkTwzhJe8Xb9h1jMw75t14yNLHwdfrTbos
         Gj9o1He1QvPg3lrMuq+j8eCwkcKEHAPi/vYCClbrSSD11S1J4SDbOqVUeHKlr1FFC/YD
         nC5A==
X-Gm-Message-State: AOJu0YzJG7ZAg8FymyyLbL1isC+HdFzRoGvycnBTAzAOMxSRL7Fzx/kz
	IF0x6EMm3+9dj1zRQHFG8Lu0+ywIVXeXjLspOdqIVMVgd3XymJN7TyviJqid
X-Gm-Gg: ASbGncu50/KYEqp+geh0+ZaZ7+9nk/KKCsXWX+FpRRf366EhtGc4swg/REXtQuyzwwV
	YN8gd9Xty2bTT4Qw42j7iReQVjRCTy+rBtF0ej3+v29BJ807cXlzzo77MX03pYaeiGjWR0sXHGj
	8/7dMoqTCay70xDECU/JMJiLUP6QNkKmGYWR2yK5fSsN0DKGVtTin2HBbGHzDf/q1mniBTzn3r0
	CwKbfXiJrISulrZkbbX3bIY8Ap7ZHSERnDaeR1wnMefIomwOQrfgkincPk51bT/fcNYKiL7CRsW
	wgkkEYUb3txdfcukbVjvO3UYz45ru3ogXro726e1jzZd9M2dINhYqFSNLECrh5MgHuqegGJrSL2
	aUANmT7f9GYkpug==
X-Google-Smtp-Source: AGHT+IE60rbTOsVOsZQEEqYvMVo7z79x2ytu2gTM8kn/HrrADkvbZAhmM9JNcOk419VGqzOqIkD45A==
X-Received: by 2002:a05:6122:918:b0:520:3e1c:500f with SMTP id 71dfb90a1353d-52419948798mr3225135e0c.8.1741722936040;
        Tue, 11 Mar 2025 12:55:36 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523d8cbad9csm1896086e0c.43.2025.03.11.12.55.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:55:35 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/2] Bluetooth: hci_vhci: Mark Sync Flow Control as supported
Date: Tue, 11 Mar 2025 15:55:28 -0400
Message-ID: <20250311195528.41993-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311195528.41993-1-luiz.dentz@gmail.com>
References: <20250311195528.41993-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sets HCI_QUIRK_SYNC_FLOWCTL_SUPPORTED which indicates that
controllers created by vhci driver support Sync Flow Control.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 963741490106..a51935d37e5d 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -416,6 +416,7 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	hdev->wakeup = vhci_wakeup;
 	hdev->setup = vhci_setup;
 	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+	set_bit(HCI_QUIRK_SYNC_FLOWCTL_SUPPORTED, &hdev->quirks);
 
 	/* bit 6 is for external configuration */
 	if (opcode & 0x40)
-- 
2.48.1

