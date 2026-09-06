Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73849156C6A
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788707878; cv=pass; b=dyQuIAwcMrUQWyEb0YKYwVok51Iv2uQn1AypbS6Y5s48VZxRriQzu1MWMCOY0kg0+SLjUwBUGPjpxTGd1/85ry9bjUOQT6K9hOzlPI0JoyDWb3fARhF0qXlR9Vi23vUAckWByRRrbLBKGz4yf68Ahj3ii7wW4lpzrqAYUoXeGpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788707878; c=relaxed/simple;
	bh=IRGvIKccOZH41uBwpwuqU2Q5IFTm0YelVVkwMotUQHY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qxtGEjw2P8iMzjtA0Zx0ywokDpBHEU3aY5Chv7VL/+FFzf7VPMw5VtRx9r3ELTjtdpNkF5qLZh0OhZ80sr3+iW3nNZzJRzIVLGMIFA3Acb5hPy4515gdO3O6hXinMCdcPHAlSjAnMzczsSW/JB0hFXqQiaJoLP5DbXsRsWMx3X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oF7MKdjZ; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oF7MKdjZ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso2628552a91.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Sep 2026 08:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788707877; cv=none;
        d=google.com; s=arc-20260327;
        b=pb/+ntstudcMnOA4cBiz0BQzirychOtfnLbSZSFE+dMt1OasWAa29gx7jBxWfXcc7l
         5Y/FK+O7kNQqEC2fyfIpkzGMsyy3fSSysCHxdl836XL6fiAIuverdsm3EXtZNN5DW3pe
         CdQDqNVErBxHo7bg93VrzoGUS+/L+H/cQklz386NH7CO5tief3bEMGMt7mb4ke/Jo7bE
         MMn56iF4uFMlspct9fyvoDz2uFdTA4lR0/5gdrIV++Ez0/pbaddCuv4LGIoi/L33/LDX
         F6IhAp1qCFsS/R9UnJRY3srf/ltcMlmUzDvbKJLuVtXQlvO8e6oEITvkdLBmU5QwqzmU
         /kZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=IRGvIKccOZH41uBwpwuqU2Q5IFTm0YelVVkwMotUQHY=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=UCfNqPGyqKPmYZnG5TFPVttao0S+hycIxvjdv63rL/zHvPT+Jysy4uSngAxrPud7CG
         N9GooWmrykjSoz/QGgLoinFV+UOhU6dYZb03NHtTyP3vJyRnXkPmZLvIAfJ5k36oDKY2
         Zus2UBumy0ySP4CNYWvgGBP4l/5U4vSd1H9lrZi0O0DxWVAHuvgK8C8NcoEq/TM4+3uA
         AMX4yOWGshimKmobrAa0wiQIOYxNYi0QUmyKNE+uV8k/zQaLY1R67FU9ZLONOM0MAOsG
         gzjGccP15abBg+1rbUdIdb9mZHQ54EwGB5y4bcnYdg0Y4FA27lNEuGDJTEXgXCbFi6Bb
         s3Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788707877; x=1789312677; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IRGvIKccOZH41uBwpwuqU2Q5IFTm0YelVVkwMotUQHY=;
        b=oF7MKdjZly11GvW2tZu7qs48Nhe3AVj2jXl/zVIiiMjgJiaqrEFXoMhPMIx289Wdx4
         Pe1PtBVhSRsyyY+va5kMM0T62QUETj+PD7T0FWQzwFvPIKbBgHm4hfmItC/wQMfLPy1k
         srYZQRejyLDZ3xQko0tdOZzULwNZUuPBmpdaAQ7GNb3cPXyPHUMZ1zx55cncvu3UZDhP
         ctFT8tp2MO6TvWte8N9kNUhQUAKlPXljpsRQpUWU7ILCz/hHNx/LPIKzcUad1drcJgaF
         +3IgJb6JADTEZx9JRvCu1vTU0FEE7WeiGZ0vX5pLECst3mw1CYU2tH0baTPv4OIXpiNx
         vFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788707877; x=1789312677;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRGvIKccOZH41uBwpwuqU2Q5IFTm0YelVVkwMotUQHY=;
        b=SSKxL9eXs0MNlVwXFcpauLOd0wurnVfvfW97Y956yf8B7y9gHj+m7v4G3oMfb4O7uJ
         ZmVlM++NvbPAVU14Ozqqkdif6h6ED4Rcxor+KXTb77aVILAZ1suiyWM6Bhljjp23tyrF
         LnjlVi1Pi3Vz3IOzRDcpL2i774T82dq/FLO/L8qVrTatI7CRIWxCNs4jd3pIxUm9IAUc
         yScGR2uai+AqZSk+h/KkGPQngZlfIhWnd/sSNJ2O/l+SE4/v8ziDsTEfJ2fMsDfbzU+J
         51yYVz8ori4RAXl5X9ksmiV9Y80zpCEsjozEFl4AtPIzQ3d82D7HR1kANV+I5YX80x10
         69qg==
X-Gm-Message-State: AFuF++lr3dd4Yl4V5RQ34DAXQUpb0x9CEp+EkJ/mVBKQ42+nMExorVTH
	xNmc4HubWRG77l2D4iU34Uuvyjg+ak5Oo6LF0z4y0IfXaAQEheQkLsB8H2NqZF2DzyE88YBWwD6
	gP3DklLuztnJoieaZXHobuVPrwfoPMyHMALDG
X-Gm-Gg: AYBFou1GS7zzGaDMTgJX8rzg7cAwxJiJ9plG9VYRH5ZH1G+A4br2cP6cGCtAjE2109x
	9FhuBL29mPEg1eHpaLXfyGDg1I4iWxiYkMXq5wXonSc27yUleEbWpMPn5YvHND3B02H7RbYp47U
	JysEb7RhI3vLmtagTD2SjbBcp7CUVAF4InVP/d8IhYc/x12iTGRDFwmIAOfnDmK83iyjnNH4+XG
	GuVfzIAyJ4J2kJTk5ZBf3bCL0cSv4lljPnTSBjQ0AzC/uZjEvRvdIMfYFfZ4hgt/j06q6TAzn3W
	CZdshLoJGqIY6XafgLmSJkdzmbZEUFRCNDPsMHE85KBFDUFOoLqElblaoduSZuzyuRnt78uk1AU
	j/ZGPrDBeuEP6nEa+9DN5CLnQMsFAK5xIJ60a2H0xu7Xt748GoRaAauYumrmnD28W7sP2ihig
X-Received: by 2002:a17:90b:544b:b0:38a:c3f:3b87 with SMTP id
 98e67ed59e1d1-39b261e3b72mr27312480a91.12.1788707876694; Sun, 06 Sep 2026
 08:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ti G <t.gossen99@gmail.com>
Date: Sun, 6 Sep 2026 17:17:45 +0200
X-Gm-Features: AcwNN1XL4bVcktegx_jdYZ9T0nJZiXw83LlNoHCy6oP72GujUYV2yuqccjzAk9k
Message-ID: <CAOh9Y1ZMDM7pKA27rK9MWutqfsza3MmSwJjR7AA8-SOo0dFckA@mail.gmail.com>
Subject: HTML message rejected: Bluetooth broken: NULL pointer crash in
 btmtk_setup_firmware_79xx on kernel 6.8.0-139-generic (MediaTek MT7921)
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Subject: Bluetooth broken: NULL pointer crash in
btmtk_setup_firmware_79xx on kernel 6.8.0-139-generic (MediaTek
MT7921)
Hello,

I'm experiencing a reproducible kernel crash that breaks Bluetooth
completely on my system.

System information:
- Distribution: Linux Mint 22.3 Cinnamon
- Kernel: 6.8.0-139-generic
- Laptop: Lenovo IdeaPad Gaming 3 15ACH6
- Bluetooth/WiFi chip: MediaTek MT7921 (USB ID 0489:e0cd, Foxconn/Hon
Hai MediaTek Bluetooth Adapter)

Description:
On every boot, the Bluetooth driver crashes during firmware
initialization. The bluetooth.service itself starts and reports as
"active (running)", but the hci0 controller never comes up properly:
it stays in state DOWN with BD Address 00:00:00:00:00:00, and
bluetoothctl reports "No default controller available" or scanning
simply does nothing. As a result, Bluetooth is completely unusable
(cannot scan for or connect to any device).

dmesg shows a NULL pointer dereference (CR2: 0000000000000219) with
the following call trace, occurring consistently at every boot:

usb_autopm_get_interface+0x1d/0x60
btmtk_usb_hci_wmt_sync+0xa9/0x2e0 [btmtk]
btmtk_setup_firmware_79xx+0x1ca/0x360 [btmtk]
btusb_mtk_setup+0x453/0x610 [btusb]
hci_dev_setup_sync+0x6f/0x430 [bluetooth]
hci_dev_init_sync+0x3e/0x1c0 [bluetooth]
hci_dev_open_sync+0xb1/0x350 [bluetooth]
hci_dev_do_open+0x28/0x70 [bluetooth]
hci_power_on+0x50/0x210 [bluetooth]

Troubleshooting already performed (without success):
- Reinstalling linux-firmware package
- Disabling USB autosuspend system-wide (usbcore.autosuspend=-1 kernel
parameter)
- Reloading btusb/btmtk kernel modules (modules become stuck/"busy"
after the crash and cannot be cleanly reloaded without a full reboot)
- Confirmed the USB device itself is correctly detected by the system
(visible in lsusb), only the driver/firmware initialization fails

I noticed a related upstream patch that may be relevant: "Bluetooth:
btmtk: improve mt79xx firmware setup retry flow" (LKML, Chris Lu,
February 2026), which suggests this may be a known issue in the mt79xx
firmware setup path that hasn't yet been backported to this kernel
version.

Please let me know if you need any additional logs or information
(full dmesg output, lspci/lsusb output, etc. available on request).

Thank you for looking into this.

Best regards
