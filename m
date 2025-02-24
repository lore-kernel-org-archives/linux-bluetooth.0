Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507062571AD
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 23:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439159; cv=none; b=HvjmxRJd2BO0WGvMiva3kruC+3cxtoBYnECxPTn0zReUMXETO04VsytY+jGG0cHeR4Yj/1d9mcA05XXL/BJbDXdvVjEpg5kVtEwDfCGQ8172aPUgQqIQ38/XjCM4tDIJR+hWS5s5CwnvX3gNRmOSJyggLWzhIp1BiVNzrEsVKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439159; c=relaxed/simple;
	bh=AS4qEe2KwjfRMkjBjQ0LZpvsLr7ZEckT1914U8hZFMI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=m8ELlwAnw8RXU2v2qcHHHi2GORMmI2i/bRTB10N5ZlCAfB+vez0UiBVIlNxCZHpLR9dJHFj7lwig+/QWEGye9FOY5cCEh/1bMPr8P9hrxR003UsQzqRV7QlRPjnFKwFx1F7rY6uEDoKZ3XVczHSeYAphl+o2wca193g9lEILvHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mtroyal.ca; spf=pass smtp.mailfrom=mtroyal.ca; dkim=pass (2048-bit key) header.d=mtroyal.ca header.i=@mtroyal.ca header.b=Yx/bPmol; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mtroyal.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mtroyal.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mtroyal.ca header.i=@mtroyal.ca header.b="Yx/bPmol"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-867129fdb0aso3083350241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 15:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mtroyal.ca; s=google; t=1740439156; x=1741043956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GuRFtnqzOvN++oBIrV5T+lf1eDJDM1x/dhBQ/VYuL8g=;
        b=Yx/bPmolwW7VKlSJWBPyyAbglTLsFDyb9WoAh35y707Mz9eR6sAF21ODSgnBTxqdFp
         fa9LVI0/krv17Z1JaGFSCkyd04O9Oqs575H8Xtfp31NX3q8/3dimNN68BXxiJq2wtO7z
         vPkt9dyjX/ZdgJ/OrhW3TxuLJRybtz7AzJuGuDk9cRniqC3L96sy/LT+MC6UcKW4E4w+
         9cS47WT586nYtaglmgDo7mM+lFidvrgmc7CJgMHGdzyMotfy8abFUKPS7toQNs+zKBVW
         CeRNkitKEReXEmac8vQj+h39AeVDDZfHQ/6U2UGLRmJOrLkTMVVy9REq3AY14zI9Kcs+
         zkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740439156; x=1741043956;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GuRFtnqzOvN++oBIrV5T+lf1eDJDM1x/dhBQ/VYuL8g=;
        b=G8sJZ+46ugo15JkIapDIc1+eVm38qKYKKen8FBW1ZZ/np8sF90oDiTXJV9TSg2efTR
         fXhto7/slIN8JjnUBJBCkV22MhIQLvw8AQASYDk4IEsvB4MjlcGWc2Y0MNd0bg8EpFfz
         euMStU6p/bdAndrQLw41j0dJ+jyW9zidWTIJ3gjFenzSbDMVjza/DEwKbxMZvbOrqd26
         HAVaMFFRiz0qs+uC9Larnxrs9cDG1JmClm9vRjQo6IuCQ4r3FPQ7FASIvm46KeW2vsEX
         d7FQ/fQ2YYf62L0zzniESRrVReysxIp1Fgf6ep6PrTXc/eJG4JTMhToj46AA/F6vzdui
         1WXg==
X-Gm-Message-State: AOJu0YyGuYlysFf88VQW9XQXQa2aiNyOHwgSFytq5brxmQ5W0sL3ak9y
	+4TnNVRZc15fB3VzHwlubHkqInrIf5sCBtNMNfF/eFZAm36Mg8BbJRd05c+z9+qCtoVKPZM2SPQ
	RoDp3eXwyCULXRoDK7CStHgLn4Ln/ASvFk5FdzJZx0bH5QH6GqCt9VGk=
X-Gm-Gg: ASbGncvM6F5QU/SzzeKvHBSeij/mxvSokqhyS1NAJYhTfoMLkxhetT8tJb2T0aVnebb
	3YI05eoPTSLhgt7Bty8KEB7KF7xcOOLV95LvYyMSnOr/s3G67zQzL+Q9ve/U6/1/ukGTmiIhgxa
	N27pxbrutR
X-Google-Smtp-Source: AGHT+IGYi3TFV1knpagsXrJFIT1OTXzSEi6UOIqgGDwlyusUS8jAdEQpch5GthZNkDwxGVoLs0vSD3X3axxE+IXPDpA=
X-Received: by 2002:a05:6122:608a:b0:520:61ee:c7f9 with SMTP id
 71dfb90a1353d-521efc81796mr8092816e0c.7.1740439156082; Mon, 24 Feb 2025
 15:19:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Matthew Hrehirchuk <mhreh594@mtroyal.ca>
Date: Mon, 24 Feb 2025 16:19:05 -0700
X-Gm-Features: AWEUYZkVyNDjLRz08sAhp9N4kN8XjE6IKAo1sVYWCI9zA79cKQ1bHYlHLmxKqU4
Message-ID: <CAF3zC4zY=uLsu5LOOb2B-yDTWQdgcHJ-uGiKL5aGmtX4j-bOqg@mail.gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add support for Realtek Bluetooth device 0x0489:0xe112
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Matthew Hrehirchuk <mhreh594@mtroyal.ca>
Date: Mon, 24 Feb 2025 16:19:00 -0700
Subject: [PATCH] Bluetooth: btusb: Add support for Realtek Bluetooth
device 0x0489:0xe112

The Asus PRIME B650M-A AX6 II Micro ATX AM5 motherboard includes a
2-in-1 WiFi+Bluetooth module. However, the Bluetooth component isn't
recognized by the btusb driver due to its missing device ID
(0x0489:0xe112). This patch adds support for this device.

Signed-off-by: Matthew Hrehirchuk <mhreh594@mtroyal.ca>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 90966dfbd2781f..ef07e54e6ac2df 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -519,6 +519,10 @@ static const struct usb_device_id quirks_table[] = {
      BTUSB_WIDEBAND_SPEECH },

  /* Realtek 8852BE Bluetooth devices */
+
+ { USB_DEVICE(0x0489, 0xe112), .driver_info = BTUSB_REALTEK |
+     BTUSB_WIDEBAND_SPEECH },
+
  { USB_DEVICE(0x0cb8, 0xc559), .driver_info = BTUSB_REALTEK |
      BTUSB_WIDEBAND_SPEECH },
