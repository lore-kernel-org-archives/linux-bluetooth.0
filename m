Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792929821;
	b=thBkRCmphMH09Vpt1emhqVtzsCoNT1nk1uy6lCIueDu2r3IBnsxnWvha9vXWi01aki93
	 RZLJPciGEhiMrwEzeyiEnjXCWFbG2GX5F5FWByFL/RQZBWpPDh4ePDUgg7BWuriXChIKt
	 kKo38l+XaVrn1qbb3jf/+v+4PyIeLvXSxhKDYjaPJ5QGliBNGMMzzKev593Qn3luhYv86
	 i2oE2dPVZJqq4QQXmQHqx2eFKQdY7nCBWzKniSmCSNEeGmU1gvU/NpSpmotIe10wguvR3
	 TUrz3muX2E+oke6S/1AW60LW5mf9Hvq7+7pvhoto2OPpF22Ypr6zGJXp3mM0r0HI9yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792929821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lS6FkSKLepK9WNXRPUJcPanRUSiz1CS44f0JGtdiWYM=;
	b=tiYKhRkH3K74SohCHVx7aWE8kqoyX6o+TxFJZH1pDdvjF150Z9bHepCuztoxbIaaV053
	 TLEKhrr5PjVs7doiSsS/9PZo0onAXqf4lYxDkGH1w+4zsEnEbEM6PzWv2QVTAKw74oEXY
	 vuP8zeQnlly6K4uVEvE31R3WtM+5+c2h07y0HZFFxVsQ1iiPtYdJBYKKm/k12XocpFXll
	 YoFQOOVWG1M5FtP93Hxb8l5mqFYvu4zqL+YZzBJqmjrnaS03zzVhdZBBjs/6DW453B6DD
	 P5vvNxt1i7WcPuiL4+5ly8vB7mfFdmUj+k5MXGYvaEBKsdnUnwB4ICLkBi6hj6yOGIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YXwnv65s;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A38E606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 12:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A38E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YXwnv65s
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so13266285e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 05:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792929820; x=1793534620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lS6FkSKLepK9WNXRPUJcPanRUSiz1CS44f0JGtdiWYM=;
        b=YXwnv65ss5ROwHVBdgkBcGHY02RZTVD1ZrhPRejcwxZNFJDTCRoo6/uJDI8wzrS/ga
         21vPez6rJV6nmLFsA4g5D1jmD4meNdRKz5CM4Q0jT2GO7/yqccwf7SMwo6eednJzIhsE
         M1LxvwBsN3vTBW6OIbm9JoX6oBTmQvOwVXrkQn6+uFz6S1JhWptdUNm7cDL5CjAqIL+I
         X+cjyVa6kxSFNdwVn1r/qU7iKCVewhn9e4sBPtcGBDKgdMGz2zXUFzr0mLqyytA72VUC
         /vN/SlmicZHtZRdvbBNW7MhLcS7D4kG4aI5yBAAD8G8uTq8peR6PE3PbVr5/TlGRl8bv
         WN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792929820; x=1793534620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lS6FkSKLepK9WNXRPUJcPanRUSiz1CS44f0JGtdiWYM=;
        b=kn6jaj6E01Piw+u8MQUB1GW6eyCf4wvg5iwuXaiuDiGEsjw7ZWJFb96wbSrXOKBJnE
         05F+86ON5wrxXD3g9Er8XtNTPBMu8BVLHxWbCkEV24RxGG7AUryvEKzdyyDmeg3dvGwP
         00N3UH0Fdyas0/frMyd/bxBNsosXhwKyR9i4ZUlZQqAdfnAqIVGT6nYadg1dG28BBkdA
         hQYgqzdW+T2WZsNHWtSfyExMgS8fsfrrseCyi2WnolMVihQQJTaE09FmStQ9m74i8di4
         6sGbuomf6jMu8R3o+ooGwDHG9u1ZGpjO5REbX9kThzVeWYpUdinMhbJbtnIpgG/J/uSX
         TTcg==
X-Gm-Message-State: AFq9FYLdoFAw+hWQQFr9ftC0zC7BLHoF8V01w75DF3pkWEFwdEWE1tWY
	sDisPxX5C5GrmOGRIngbq3h3JscaTICNS6Vugtk18Z7gqkw63pTT2TdcI+aKFvCKuXY=
X-Gm-Gg: AYBFou1FjNRHgjzjwZSAEqJv9A7t/PlhAwaQNkfx9TaQOUTE+xZAwiNLJkXI7lt37IT
	XJsyOtPj81EQVULu378bL0otBUbcuVtEhzn0Iq1+tps1yZs699/ceytPgJM/Jv8WVBhaQXSkSD9
	dz+rpRYDbX5d7asZv3vqECuKaiLrIj5a+dATueetpzYr6DAWPArOJB3iBijj3MkjcmmAWNaoa6h
	Iu0+nSsHDmZ65K5Z9Ut+0zS8+dPjCFSfEE4RdYqCrAj0UBeMOi0eS6LSi0760cQD9pPo6XKd6Ce
	IPqBrpw6HjuE/azF7mxIfTnJUU6TwGc44lG0SpK6Ufsi2INqC6ygnH6e6CEo+nDG01cWalRDlcb
	JWfm3o7uKwuIgWxskmEX15mMifi16QoJK+K3sGtY2V2oxIvZSRYXFavhPMs6rleGFDJi0+kOf/R
	RUxRmrb8NRgJzT+oNcoQ9Z6xDRkIQXJgqo2oSf51RHipmyn0qxgkjb6YxgrGjGO8ePuv+jbI9Av
	G1K8XQdB/ypkhpQMzu/Ib1e9Hsh9qTm9eoub5behtjGHZmunDTEgChYYWLnyXhKKLctXmg2nn3x
	lPMdxwUzb/8JLHsouYA4kKWUt3JmmTMwiFsNZBzplCbJKUiDx54Zf354GzcvzySKuK9sYcignJn
	+ybfpnpd2tAVpU8k=
X-Received: by 2002:a05:600c:870f:b0:4a2:150f:1613 with SMTP id 5b1f17b1804b1-4a35ac9983emr68238125e9.7.1792929819204;
        Sun, 25 Oct 2026 05:03:39 -0700 (PDT)
Received: from archlinux.tailbe3ea7.ts.net ([46.1.178.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd39a9sm10010492f8f.46.2026.10.25.05.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 05:03:37 -0700 (PDT)
From: Ismail Tarim <ismailtarim7@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>,
	linux-mediatek@lists.infradead.org
Subject: [BUG] Bluetooth: btmtk: MT7902 does not recover from firmware assert; subsys reset leaves the MCU unresponsive
Date: Sun, 25 Oct 2026 15:03:27 +0300
Message-ID: <20261025120328.1312536-1-ismailtarim7@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On an MT7902 (USB 13d3:3579) the Bluetooth firmware asserts on its own
while the machine is idle, at irregular intervals of up to 17 days.
The three failures on 7.2.11 came 8.5 hours, 46 minutes and 12 hours
after a cold boot. After the assert the driver's reset fails and the
device drops off the USB bus. Nothing short of a full power drain
(AC unplugged, power button held) brings it back: warm reboot, S5,
rfkill, port power cycling, the ACPI _RST of the port, PCIe FLR/SBR
of the WiFi half and a WFSYS reset were all tried and none of them
recover it.

This report has three parts: the assert itself, an instrumented trace
of the reset, and a correction to something I wrote in an earlier
patch series.

Setup
-----
  Machine:   ASUS Vivobook Pro 16X (K3605ZV)
  Kernel:    7.2.11 (Arch), includes 59c3ee19ca88 and 21b50c24843b
  Firmware:  mediatek/BT_RAM_CODE_MT7902_1_1_hdr.bin,
             Build Time 20250826211444 (linux-firmware 20260916)

1. The assert
-------------
Twelve natural failures since 2026-08-03. Ten of them were captured
with devcoredump, and all ten carry the same assert:

  <ASSERT> ../bluetooth/system/debug/sys_log_interface_emi.c #811 -
    0, 0x6455, 0x1010707, 0xFF150001, rc=0, BTSYS, id=0x4 idle,
    irq=0x2, isr=0x929A5C (five dumps) / 0x929EEA (five dumps)

  Captured: 2026-08-24, 08-26, 09-12, 09-21, 10-05, 10-10, 10-18,
            10-21, 10-23, 10-25, on kernels from 7.1.8 to 7.2.11

The firmware is idle each time ("id=0x4 idle"); nothing on the host
side precedes it in the log. The full dumps (about 1 MB each) are
available on request.

2. What the reset does after the assert
---------------------------------------
I enabled dynamic debug for btmtk_usb_uhw_reg_read() and
btmtk_usb_subsys_reset() and then compared four natural failures,
2026-10-18 (7.2.6) and 10-21, 10-23, 10-25 (7.2.11), with a reset of
a healthy chip through /sys/class/bluetooth/hci0/reset, which reaches
the same btusb_mtk_reset() path. All four natural failures read
identically:

                              healthy chip     after natural assert
  reg 0x740003a0 (WDT)        0x00000000       0x00000001
  reg 0x74000024              0x00000000       0x00000000
  reg 0x74000308              0x00000000       0x00000000
  reg 0x70002610 (SUBSYS_RST) 0x00000000       0x00000000
  reg 0x70002510 (MISC)       0x00000500       0x00000500
  chip id read (0x70010200)   returns          times out (5.1 s)
  result                      re-enumerates,   descriptor read -110,
                              setup 121 ms     port gone

So the generic reset sequence works on a healthy MT7902, and every
uhw register access still answers after the assert. The RST_DONE bit
in MISC reads the same in both cases, so the "Reset timeout" check
cannot tell a failed reset from a good one here. What does fail is
the vendor read (request 0x63) of the chip id, which times out, and
from then on the device no longer answers descriptor reads. The WDT
register is the only value that differs.

The ~10 s between "Mediatek coredump end" and "Can't get device id"
that shows up on every failure is two USB control timeouts. A
function_graph trace of a triggered dump shows btusb_mtk_reset()
taking 10.47 s, of which usb_driver_release_interface() on the ISO
interface takes 5.35 s: the interface is in altsetting 1, so
usb_unbind_interface() issues SET_INTERFACE(0) to the dead device and
waits out the 5000 ms timeout. The id read accounts for the other
5.1 s. This only adds latency; it does not affect the outcome.

My question for MediaTek: once the firmware has asserted and the WDT
register at 0x740003a0 reads 1, is there a reset sequence that brings
the MT7902 Bluetooth MCU back without removing power? The current
sequence evidently is not enough in that state.

3. Corrections to my earlier series
-----------------------------------
In "Bluetooth: btmtk: fix subsystem reset error reporting" (v2,
https://lore.kernel.org/linux-bluetooth/20260815115624.8309-1-ismailtarim7@gmail.com/)
I got two things wrong, and I'd like to correct them on the list:

  - The cover letter cites an assert in
    system/rom/transport/tra_usb3.c #764 as the firmware failure. That
    assert is produced by triggering a coredump by hand through
    /sys/class/bluetooth/hci0/device/coredump (2 of 2 manual
    triggers). The natural failures assert in
    sys_log_interface_emi.c #811, as above.

  - Patch 1/2 describes the id read succeeding with an id of zero. In
    the natural failures the read times out instead, which the error
    branch already reported correctly before that patch. The patch is
    still correct for the zero-id case, but I had not observed that
    case, and the log line is identical for both.

Neither correction affects the merged code.

Thanks,
Ismail
