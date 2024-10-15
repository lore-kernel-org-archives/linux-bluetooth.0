Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833301E6339
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006645; cv=none; b=feIyzQ68mXC1feVRZE/1mqC0QCUfGB/dmvWZ+NuGdyHZtg2XfIj+XTOyjFy9U93Ai08Hya/gO5xQU+jEwrkFRcXvaaV/qAJaLg0b6voLlDtcq0T5gkI6O6PROm5R6wsd6p5newXOKrFzhNacSvQnTWIwFyhpjQPJZzcjAk0svvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006645; c=relaxed/simple;
	bh=baxw4ZeXmVoTKZrA+isJgP0bKjN47uMC0Wlp1D2X8Ac=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ONPYzaD/T8ddpHxhB1pt7y+M7YTEnjkOBEqxgntfqHw+2qFGgIhoYDPxtmQCvo2H+p1Igd+9zYFYueUkXcazH+WJLrIuOy9m/ijIosHX63EkX0O59jgr0/zSDSCV/nV85eod6ryFqUAv7ryKhStVgKtQRBM4CyjZVN7ZPQN+s8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSvxFewm; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSvxFewm"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e38fa1f82fso18265437b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729006642; x=1729611442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hBCREzGq9Yso6+Y4/iEbuCLfGII3KcJuxfKA7okJLC4=;
        b=fSvxFewmsiM66VJcn5b3NVU6BNpqH0I/pTfmE0D0oSh7djjNe0jsipKGbheCIdUgFV
         rvi3feU6W3PYXXIOEVp8nJSs/+elIVJQzRds4YXUThzplBY7yljBFe5Z2VlmASlwR44u
         DUC1To9coakEogt9/OWuz7cSLx+xo+AjM7gvK23mP0y82nZsEAaomoqMOUrwX8h/e8Gj
         X7U89J3M89fWjB88kDaCXx+HShrH2RvKtBEHWlka3SUbTuzndoKxEn760P95LXmlit6N
         JdLTP+MHdwfFtU9HmCUnZzRduaapbgrBpMjzYnBwrKyWwWF5wYGfBxBmsdza5KspZyxL
         WTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729006642; x=1729611442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBCREzGq9Yso6+Y4/iEbuCLfGII3KcJuxfKA7okJLC4=;
        b=moteu1btuWHWn9DfFnpokOi27puxb857oTmfrC0HpAaD1e6JL/+2Sgry5ouXJq+DV6
         cgfURxiJgcoTAbhVAVF14r44erYtQedzvyhfXobVmsBAH/qsi4iWl5+jb5qgFihvQ6Vu
         c3Lwt4SPL/DUlVw7Fc9pnhIzy4R65o3HLig+yDlQiHFAZmTEVVHLvVQrTdD4dKIDNLSc
         LGkfRuFUL3FLpprx7pr9GYhsGt+BVvZoo1U23RTu2EiVeK2mYAif0wdCsiKNkBzNwksu
         SX0W98Wzyr/vJ3ce2hzQeZ6mdeWya2oLUY1qvc29tkv+Ut+YwjG0gY6GR+DqJUwWiJoy
         uiWA==
X-Gm-Message-State: AOJu0YzwBxqjWbcD4vsg1IcAeZJJxF6/DmBjlQAwNxMUNcP4P911F7da
	Zz2N/X5sNoHB29QViBfKqbidfCwT6kzFNjugXZQxxd+FTgMvGRrfixKwMQ==
X-Google-Smtp-Source: AGHT+IHqCIy9lV6j4xU4ONwj0n6FUsfa6HwYRsfk2ZEytdvileDv4wv5FT2WvODD9xb3TQmGcQvn4Q==
X-Received: by 2002:a05:690c:9b0e:b0:6db:cf6c:a7c4 with SMTP id 00721157ae682-6e3d41f9b66mr8799087b3.45.1729006641663;
        Tue, 15 Oct 2024 08:37:21 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5add202sm3170767b3.19.2024.10.15.08.37.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 08:37:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btusb: Fix regression with CSR controllers
Date: Tue, 15 Oct 2024 11:37:19 -0400
Message-ID: <20241015153719.497388-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

CSR controllers don't seem to handle short-transfer properly which cause
command to timeout.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219365
Fixes: 7b05933340f4 ("Bluetooth: btusb: Fix not handling ZPL/short-transfer")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c0b6ef8ee5da..f72218c1037e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1366,10 +1366,15 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	if (!urb)
 		return -ENOMEM;
 
-	/* Use maximum HCI Event size so the USB stack handles
-	 * ZPL/short-transfer automatically.
-	 */
-	size = HCI_MAX_EVENT_SIZE;
+	if (le16_to_cpu(data->udev->descriptor.idVendor)  == 0x0a12 &&
+	    le16_to_cpu(data->udev->descriptor.idProduct) == 0x0001)
+		/* Fake CSR devices don't seem to support sort-transter */
+		size = le16_to_cpu(data->intr_ep->wMaxPacketSize);
+	else
+		/* Use maximum HCI Event size so the USB stack handles
+		 * ZPL/short-transfer automatically.
+		 */
+		size = HCI_MAX_EVENT_SIZE;
 
 	buf = kmalloc(size, mem_flags);
 	if (!buf) {
-- 
2.47.0

