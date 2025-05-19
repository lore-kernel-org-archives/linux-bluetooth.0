Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AF91F12FB
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747682706; cv=none; b=dlj4GYNXZTEQ6eUa6jNHTzW1bdshUgRLTxMFkSr4Rvie8T52kWvOzoHS3BCXZK+hi21Y9p60yl8O90k85K8lBnMwDaJV6q5uHrJ/XEAyeDskkdPl8niNwP/IQ3mJ6uDlVAAU6L+NvKBJyLPAfAGKPQN7JeTAtHCrzsHy8656WhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747682706; c=relaxed/simple;
	bh=XlGorKDq2GqCXsZmwkxPEx5MiX4QwUtt+77L7zfKhW4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NE94rsJgA1pdOGo4b0E7bNWcJXN/aa5fJUthEj3LVf6OH+jQTZ0wCIz0QfrEIc8aoG0g1qExi+yxktgGi2YeWYjed860t35j9/UTV2v5T8+gjZRELfoxrk3PlEUiWOsqTt5gkZaqc3/Z7RF2p70sKfZtD9P+V1QfHrPsFpQ88l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQkSDZwy; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQkSDZwy"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30f0d85a092so1127439a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 12:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747682704; x=1748287504; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Ff3XGEc5N8FPLjv7ILKdZqBZcmaJWGQrz3XK25oW/I=;
        b=OQkSDZwy47fWofS6FjbMzqtyu2q8xCdgjUjfGEUWaUGifHe3iWvtCNb3BobaJNXdvJ
         rjyIpRBO64ONbDRiQmT+9npBZyM2WwZH/kMIbdPeSQwCp6+Rz2nUaKlvcd22eMy9fX+w
         VZgb+ZvJYpkSzRt6M7RBM0Dw+q52dmAE9SuUsizX+sDqnUpJpulTGIgyOqXdMxXwhUfP
         vS7cjctvOepP9T/y/zsztO27V+opTHj89TTWuxE6xdjiTdzCmwTR/jCaBWW+y+EL3pUP
         USEIutKaxw7/4odwqzDtlP8c4B3FGZVx2aLV6bgeUsNiVnlJzWnCp3dCtqJYupkIo627
         qIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747682704; x=1748287504;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Ff3XGEc5N8FPLjv7ILKdZqBZcmaJWGQrz3XK25oW/I=;
        b=BDplcTk5cX3Ox/sT7f8IVM0ZlXVmU0sAtl7G1btCZ8TX2kUf1f7eQiKaWhXoHc+mdp
         lfuzTplDqApqHVItlO8gOuOyFB3NgzvqVTFbxUpfjy+unUGEH3CVRWIVBqjgZkC6/UPu
         kGhL3mEIi9dV+Z9zt+/CDu/WH9G37OF7dWoWwLQyQ5tlKEiDV5PLywUfN0NZ6M45lial
         SBy2Fm0HcEh62WKDbKDnpfrziKyUMo+BJ5dNCDIIUdi8DEOTkWUYylyK6MOjHk6s2hJG
         sL5zfXalEMzoisuRtIXtqxmK1BRQs3yFHP1crXaz+DlRhLcxKXKcqdI5o+jfX/5Lsh1E
         RNMQ==
X-Gm-Message-State: AOJu0YzQJSOVZVUzQjFeAXnVBrQhVI58wFT3Ndayw05AdJOVWpBmAnAI
	vV1mORSBXQJ96pd3Sh0T+kP2Nu+CadaOeNeRXz3z6OQjIWaHd/Btzt8PQxhAOsGa0rBACVh7uLr
	OwYWomDqEyspT1LOhvD4Xd8lxJM10dNnGu0J0oS8=
X-Gm-Gg: ASbGncv4By9QTOcTKvNBoO0Qri80F/XmKrGo9ix6F/mkOHWhG01UbuZvdq0yN7u6+pj
	W5Us0/PkN1MPbkuEBBwTVH8v49pKpMbUek6uaqdkzvJdPuxda+Du0L9P35E83O3Ww2lCbD8Z8QP
	p2qfBT6lC/r6ClkVJ7kj1D/9CsxZAtpKvbeqot2A1AOVqHePnZpTEi9ptLQrmjqoRB0sh52Wu/l
	4I=
X-Google-Smtp-Source: AGHT+IH+OlFG4pnxXbLUgztM7BeIQ3dtXlUyo6+32yxEVsts5JlIcsMdnObmAqBrZleKvSrwNq2qrxlfMi86/6LtgwA=
X-Received: by 2002:a17:90b:570d:b0:309:fe2b:306f with SMTP id
 98e67ed59e1d1-30e7d5a8b14mr18079497a91.26.1747682704036; Mon, 19 May 2025
 12:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mokshraj <mokshraj20@gmail.com>
Date: Tue, 20 May 2025 00:54:53 +0530
X-Gm-Features: AX0GCFujv-AzvwlF8VWZxxzu9z3yu6G0yBD4tvROySvajESqfLmpmaYuudlMvwE
Message-ID: <CAJRNte4YKufb12O7AUH02s6_ia9X=41nYvFOp1v-UUxfMQ-WHQ@mail.gmail.com>
Subject: [PATCH] Bluetooth (btusb): Add quirk for Realtek USB device
 (0x13d3:0x3601) for proper detection and connection
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: mokshraj <mokshraj20@gmail.com>
Date: Mon, 19 May 2025 20:07:26 +0530

Dear Linux Bluetooth Maintainers,

I am experiencing an issue with my Bluetooth USB adapter after
installing Linux on my Acer Aspire Lite AL15-41 laptop. While
Bluetooth can be turned on and is visible in settings, my system is
unable to detect other Bluetooth devices, and other devices cannot
detect or connect to my system.

My Bluetooth adapter has the USB ID 0x13d3:0x3601, which appears to be
a Realtek chipset.

Here is some information about my system:

Problem: Bluetooth is enabled but cannot detect other devices or be
detected by them.
When it started: Immediately after installing Linux.
Bluetooth Adapter USB ID: USB_DEVICE(0x13d3, 0x3601)
Computer: Acer Aspire Lite AL15-41
Linux Distribution and Version: OS: CachyOS x86_64
Kernel Version: 6.10.2-rt14-arch1-6-rt
BlueZ Version: 5.82

Through some investigation, I found a potential fix which involves
adding a quirk for my specific USB device ID to the btusb.c driver.
The suggested patch is as follows:

Diff
diff --git a/btusb.c b/btusb_patch.c
index a42dedb..3789e03 100644
--- a/btusb.c
+++ b/btusb_patch.c
@@ -564,6 +564,8 @@ static const struct usb_device_id quirks_table[] = {
                              BTUSB_WIDEBAND_SPEECH },
     { USB_DEVICE(0x13d3, 0x3591), .driver_info = BTUSB_REALTEK |
                              BTUSB_WIDEBAND_SPEECH },
+    { USB_DEVICE(0x13d3, 0x3601), .driver_info = BTUSB_REALTEK |
+                             BTUSB_WIDEBAND_SPEECH },
     { USB_DEVICE(0x0489, 0xe123), .driver_info = BTUSB_REALTEK |
                              BTUSB_WIDEBAND_SPEECH },
     { USB_DEVICE(0x0489, 0xe125), .driver_info = BTUSB_REALTEK |

This patch adds my device ID (0x13d3:0x3601) to the list of Realtek
devices that require the BTUSB_WIDEBAND_SPEECH flag. Applying this
patch manually has resolved the issue on my system, allowing Bluetooth
to detect and connect to other devices.

I understand that the individual who provided this patch does not have
the time to create a DKMS module for Arch Linux users. Therefore, I am
submitting this patch for inclusion in the btusb.c driver. I believe
this would benefit other users with the same Bluetooth adapter by
providing a default fix.

For further information about my device, you can refer to this Linux
Hardware Probe URL: https://linux-hardware.org/?probe=b58f50ee34

Thank you for your time and consideration.

Sincerely,

Baymax(moskhraj)
