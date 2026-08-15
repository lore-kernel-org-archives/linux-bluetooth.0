Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C52BFC85
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786795004; cv=none; b=dNEwLaeOcUrfBytGMeVBbh2G9zmoUf29OfuVOL+jJ5FFumPWmjBmZLo9yVYFzhreqNSMFI3/e12LAZMsp2vkbD3IzK8cLqNxLcoB5u234gRPP5IcpJHXQu1ucc9IBGszgt8DQn4evTBppIC9d2SSdE+dg6nfkyjS0zr+ZYGVi1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786795004; c=relaxed/simple;
	bh=jryRxjqTE3dL1Kz6tqHtb7AjwGT7zGFF9zHrjezAJBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxEJ3BoiNJebz8HOS9Y6hYSAzuDHOMakaqMTnliyOOCo/k29kMbY7/hUl0OijYPHABu3XpLtyCz0bFR5wom+/fkcF2zH+OHo8xmT2O4vRvSVx/28kMhCGP7k/s2CDae//6Bhbp6WHUITla52PpKYKFVrthI5QNEFdhk1zVE5Pqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmzwoxCh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmzwoxCh"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4994c49f588so15955365e9.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 04:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786795001; x=1787399801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2EvcCjXX/E/EH5B0VOq94NnG4HOn80gOVENNBtRlSfE=;
        b=QmzwoxChX9eYXhf8sV61oBYLvGLxWt5QlcG+qgxglyOgmuwSWtIkW84zy6i2ASFV3R
         2nj7VijpRp/3kLyilleS3eSFHldJYU0FfnMnjBsUWRKG4ySOd6wvLandFNsC6O/shHwa
         9i9/xOxswECYsUG9YqBrxYKfZWi1DOkJFV8voSABLXQ+nZVFlwh+hJXi+U3Y1Q4+5FuT
         vevz7uQ8dsg5L3+1NFEo08Vc3x/BdTFQfEP5zy4QEPrW5jf2Fd6XR+1uJR/1/GLv165w
         1EfOhN0Uig02/BPf+Hu22kjnrUTETZBzYPX8yn4XtGVcHrlncms3iiVNQSEKY7q9zPxF
         jaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786795001; x=1787399801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2EvcCjXX/E/EH5B0VOq94NnG4HOn80gOVENNBtRlSfE=;
        b=n5OGPgu/7X+z2zK66HxV+fqeRpqeb4qTWCAuVYUwENBjpu1RaOB/ZHtaiaQOnJ0DMj
         B+yWXvDGbAQUOGM8haWkZ00Uex62ihODWADP6TrPLZG8vxcEoKCNCz4mqJ7o85o+XgKp
         tTGGu6pHG/pLoxXK+lTLI9WEDCUphcfeLNmuW1PuSmt5rnmJIRX1lRK0bWWT3HZfBCwd
         15kJBQ/JQvTQY4EtW5bQTNVMNKWb2jGZ7RwIFr3Q0Z2W7yTtKBLz54S5UfV7hCv0QyEz
         vlRQ07hWb/dEZGNmkO6aR+jl57U8Vuw7+mibERwM2F4HP+hKnfSaTzNCGE3fVno0JMJy
         jn6w==
X-Forwarded-Encrypted: i=1; AHgh+Rq4jcUYt/pBMhn2JVvPzT2lvmDHpRqdYxJBYIQA1WH9BqJSnvF9QzOsZ41N7XMB19yocogEnjhap+WifrMnoPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVcB6dNP9BChETKCi7OP4BVQOj4H9KQCxQMUmlR6wy1tUtwSkn
	SyZmH2VRmf1o9h2EjANA5VltAvPC93+C2ak7ls27oOuD2U/IJbaW7NTQ
X-Gm-Gg: AR+sD11gLwvG8UATbTQ56M3Rr4XBklwLl19S8zXgPES0QzV4wTUbPC7gYHp28fO7rTS
	RUtbJ2gQcTriUXqYFhvLEn/Cfz1SoK3p6P6sVRijhJSSTDVU/cjCh9Et1qm/L0YmfNbx5zJlfw5
	t6AVU8WWKuM4Wtwe7x6OQmnY3E4n4VFIvv10EtMerl1C7i+TMxIDe9JaP8TYbTH7sud4LC3qtKy
	tOehE+3hq1L1rqSUcWw3HJ0W+zvY9+39IM/Zm/EVIR70bKW3q0l2Dz6pm3XdcxsFpKA4fD8GBeT
	AGffciXMJsOV5kjxNfEtIlJopXE9lD6JytLeX402D42qL4rraogbPovYtgHAiz0HU/B1Q+sVhEv
	g5spUeQCBhXokKbNlfr9EicVoMPC6fuWK0JMqvaBF4pXYXIB8z4lDsbBWT9eGsUdfH1Tr0l8vO7
	vQW9BkazOObM6jawh+AJChpcfs/G8wagVTo+BmHqyR0CETw7XjVDkYQXPstymd5LPXbCR6z8Qob
	2slLjFRQ3nmnSTc+w==
X-Received: by 2002:a05:600c:4309:b0:499:8afd:4a9f with SMTP id 5b1f17b1804b1-4998afd4d6cmr78007035e9.0.1786795000955;
        Sat, 15 Aug 2026 04:56:40 -0700 (PDT)
Received: from archlinux.tailbe3ea7.ts.net ([185.19.153.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c129dsm16085455f8f.26.2026.08.15.04.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 04:56:40 -0700 (PDT)
From: Ismail Tarim <ismailtarim7@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Jing Cai <jing.cai@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ismail Tarim <ismailtarim7@gmail.com>
Subject: [PATCH v2 1/2] Bluetooth: btmtk: Do not report success when subsys reset fails
Date: Sat, 15 Aug 2026 14:56:23 +0300
Message-ID: <20260815115624.8309-2-ismailtarim7@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815115624.8309-1-ismailtarim7@gmail.com>
References: <20260815115624.8309-1-ismailtarim7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btmtk_usb_subsys_reset() validates the subsystem reset by reading the
chip id back. When that read succeeds at the bus level but yields an id
of zero, the reset has demonstrably not taken effect: the function logs
"Can't get device id, subsys reset fail." and then returns the return
value of btmtk_usb_id_get(), which in that case is zero, i.e. success.

btusb_mtk_reset() returns that value unchanged, so its caller cannot
tell a completed reset from a failed one.

Return -ENODEV when the chip id reads back as zero, leaving the existing
MT6639 exemption intact.

Observed on an MT7902 [13d3:3579]. The path can be reached on demand by
asking the controller for a coredump, since btmtk requests a reset once
the dump completes:

  # echo 1 > /sys/class/bluetooth/hci0/device/coredump

  Bluetooth: hci0: Mediatek coredump end
  Bluetooth: hci0: Can't get device id, subsys reset fail.
  usb 3-10: reset high-speed USB device number 5 using xhci_hcd
  usb 3-10: device descriptor read/64, error -110
  usb usb3-port10: attempt power cycle
  usb usb3-port10: unable to enumerate USB device

The same sequence occurs unprompted when the controller firmware asserts
on its own.

Note that this corrects the error reporting only; it does not by itself
make the controller recoverable in the case above.

Fixes: 25b6d7593a3a ("Bluetooth: btmtk: introduce btmtk reset work")
Signed-off-by: Ismail Tarim <ismailtarim7@gmail.com>
---
 drivers/bluetooth/btmtk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 66b346761043..dc702c0a6034 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -968,8 +968,10 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 	}
 
 	err = btmtk_usb_id_get(hdev, 0x70010200, &val);
-	if (err || (!val && dev_id != 0x6639))
+	if (err || (!val && dev_id != 0x6639)) {
 		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
+		return err ? err : -ENODEV;
+	}
 
 	return err;
 }
-- 
2.55.0

