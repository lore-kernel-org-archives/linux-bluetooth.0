Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA627274FDC
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Sep 2025 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757833000; cv=none; b=ZzIqSk38zuUJTWN8Gei0MFtIhzLyVWFSh3s8+ixOCDyGIqEq+yUOw0MoQx4RR5yUipsG8lEzgVhTX58RFWeVKaY91FGfsyCSfm1CrkVtUPbBE+TRCKLFizVkjSMqpdTsCmifQC0vHRKdesVbmVdYFJh8/sqPRiVSnRqs4yMisDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757833000; c=relaxed/simple;
	bh=Q812AXx6dejqCWgirZNijQXyD/Rb4pPDTgkvtVVfJtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mTlIfV7/QsXJnDwW9HJNy2qgby3bdlQqXqtAJi8ODMP8MvTG8r8ocqp/D1WhtKN+f7l/O2mkdIvFbDIaL8Qbat7GXYx4t5OmdCsEwL47DJoyiNqMI5vZ6/BfrFxJ4cvMneX78G3NJNrOw3HNJt1NtzPVrdg0OpBKOXkprNQI244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+W4DQlK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+W4DQlK"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7725de6b57dso3977519b3a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Sep 2025 23:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757832998; x=1758437798; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3j+6RFJp8fBl5UFi4n25Nhq071AJDVG4+e0E5+b4Qw=;
        b=U+W4DQlKYhCsMuDEhJw3Bj0AzjKY0PDui+fN5SISBCuL2fXCJXRHbF1AJgL4NtBqPN
         dmXD8WzYcbNozXJh7co8cC2f+wP7lZl91sj5xRuxjQ7RtoWxVb5HyKnh9+BaKfeAaNnC
         a6Vno9HpBYoxzq6rSuiXd7sj2GrZEGDBfBUWGRL1H2bB2OqUc5HPrDJniCflaY4ECd6w
         CxAX+cV+fvyNQlCT/cIFGMQATHZ29NMnxIDRN1LKEGbEhjgYb3w/RA+sIb+ndkjEcOMd
         v7QFc14esfwfdGKGrSgVknb5GWjhw2xQoZ4L2PBUpOGpZ0VU3bvkU0CnUTf7zJXa7xqo
         yeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757832998; x=1758437798;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3j+6RFJp8fBl5UFi4n25Nhq071AJDVG4+e0E5+b4Qw=;
        b=GFeP+7ojRSNzT1o+MWYQybIu9GdyxQAz9EfX0kkuA/yoyYIXc25MdM9PWk2DtXtz2S
         bQv8ESRbDLIwOf8maMFGDjHbHs0w9sxovR7w8iyzEEsmgVb7ZmKy7YB3KuM+7K9VNMRG
         v83Y7L0gE+kHbfOuJ3N/nc7CDl78QGocoSHGJHuW7FBQJKSnzKxjTEdtTTtVrNFQ8lL8
         glR3KbTcJTsXLFLmrplP887PLXo63+cAFXdd/RkPrtB8OvB0CqMiBSVP6gJmYYwOAvn8
         UnjjlK8AqelkwD8rPBcxkZvj8h8FnijzdqzPy5VsC+EWXdYOkGlywk4CbtFgytehfGzK
         xfMA==
X-Gm-Message-State: AOJu0Yw0WGdBqIfkGCPcu3vn7Gz+kT7zmgX0OUrusNjQ8H9bFPwUcxyc
	VS0K3HFJ9qgM/uklHo/n1dAtLYY5xRrVry1CGCGQVY5RSg39ful5nlFS7CXrpETT
X-Gm-Gg: ASbGnctseLJlMoXu95ySKpiq08sh7yHbkbwQJzZ4dekR2SbJtKMnv+ydtvD2Sc41HAP
	mrlATOABiA77TIUcRFWtVHfMiYQElI8tGXNxdTvYvTikj5Rp2HrL1RM12IkTGONLcEg/vwp3YNw
	oqfoCJ7yU6CcKGpX6vK/9bsWvuXjiF2CxKmmJu1gpa/iwVoLDu3YnknAQNatveCYG5b9ZMc3awG
	3Tbp/oJZhWDhNNAGwokyD4QHguzoQGp9af4wouH/i/QlMqyrvndQ42Tczle6Dqw9LxYHQqKPGYN
	h27YBji7Ws4gmgQ2EGrXvRz1Tge4q8PA1+hoAXswYhl5rgsGLexloUTfJ3FiY62dC48XrzNT48D
	D2UNWfX31bqi89jOQIo9tyZCpT4Dl5Tk=
X-Google-Smtp-Source: AGHT+IGznuor/LGxwCbRZQ1XmIF0s2BXLDSzFLDiBks6mLGDvb81hNwtxuW7F5JOgR4jeZyqmWNTwQ==
X-Received: by 2002:a05:6a00:3d51:b0:772:5513:ba3b with SMTP id d2e1a72fcca58-77612077d87mr9562392b3a.5.1757832998188;
        Sat, 13 Sep 2025 23:56:38 -0700 (PDT)
Received: from localhost ([159.117.70.219])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77607b18ec7sm10171435b3a.54.2025.09.13.23.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 23:56:37 -0700 (PDT)
From: Nai-Chen Cheng <bleach1827@gmail.com>
Date: Sun, 14 Sep 2025 14:56:18 +0800
Subject: [PATCH] Bluetooth: hci_bcm: use str_low_high() helper instead of
 ternary operator
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-bluetooth-hci_bcm-string-choice-helper-v1-1-05e05bf0e21f@gmail.com>
X-B4-Tracking: v=1; b=H4sIABFnxmgC/x3N0QrCMAxA0V8ZeTbQFgfOXxGRNsYlMNuRdiKM/
 bvFx/Ny7w6VTbnCddjB+KNVS+7wpwFIYp4Z9dkNwYXRTf6Madm4ldIEhfSR6I21meYZSYoSo/C
 ysmGM7EaayF9SgB5bjV/6/Y9u9+P4AeoxQfJ4AAAA
X-Change-ID: 20250914-bluetooth-hci_bcm-string-choice-helper-aae05c9c18b2
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, Nai-Chen Cheng <bleach1827@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757832995; l=1308;
 i=bleach1827@gmail.com; s=20250730; h=from:subject:message-id;
 bh=Q812AXx6dejqCWgirZNijQXyD/Rb4pPDTgkvtVVfJtc=;
 b=KFujJ9fybEPgVWX3e1HODwtSS+x2VXNY21xe436FpBVJyjq65+B8JpNBYc09NOVfTF6ClgkUd
 qkNZqgIwnraBHy710hekebvsj59+EQdtU/Ti6iez22l7o+TI9SHmg96
X-Developer-Key: i=bleach1827@gmail.com; a=ed25519;
 pk=jahFPRplw20Aaim8fIt8SxlFMqkHbJ+s8zYBGbtHH5g=

Replace the ternary operator: 'dev->irq_active_low ? "low" : "high"'
with the str_low_high() helper function. This enhances code readability
and maintains consistency.

Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f96617b85d8777972137ca146ab99a3d8da12584..65740b86c49c42b65a67cbd892daec2358a09394 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -26,6 +26,7 @@
 #include <linux/dmi.h>
 #include <linux/pm_runtime.h>
 #include <linux/serdev.h>
+#include <linux/string_choices.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -1213,7 +1214,7 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 	if (irq_polarity != -1) {
 		dev->irq_active_low = irq_polarity;
 		dev_warn(dev->dev, "Overwriting IRQ polarity to active %s by module-param\n",
-			 dev->irq_active_low ? "low" : "high");
+			 str_low_high(dev->irq_active_low));
 	}
 
 	return 0;

---
base-commit: f83a4f2a4d8c485922fba3018a64fc8f4cfd315f
change-id: 20250914-bluetooth-hci_bcm-string-choice-helper-aae05c9c18b2

Best regards,
-- 
Nai-Chen Cheng <bleach1827@gmail.com>

