Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795214010;
	b=sH5MIU1+0Q1Vicsq9D1XfDAiN2FwDkeRa+54XccBlZJIwqvTEXbF8t1SCn1K+su9pQF3
	 0RU2/ztl1Iq0iERYpzKLKY0/mcQWKO6WhTKhGwbpzP+PlSHYWtyE4Cq8ANDxKKVQoeIfN
	 +c/DNHqvFynV7EA14leOkgJVZkW+DxtF6sunmuGrfagLBhh3/9H2ru8qqwYuS9c/fjPEy
	 RGXYsujaC7QRHCpD+jTeIykhbQhqizSgzVGNMal3ZpzDviJQxUKaMBJE+gHRFpEx4A1+a
	 k6RzigmRnNZmwIvdglLTJeOzdkYpuiXsHVHilW1Rm4AM2stTFdEE2rz9Gdn8dbFYgiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=NjGHsbldweRnr4/xsq2r1tnUyB+g32VIQ7hsyxVyeHw=;
	b=Y4q1Ft+LArir0iFrsa1+ZbXt/LWrY10tt6ee+/YaR/55EwPpUp7apZ6BNlzydvkif78g
	 8BUTIrkQ+6BQ3YeNnn5aCc5hWANNEpr0BHEjoAcZ8EaltQiOtko1/gdnd9bmIjoKEROKC
	 TL/o53n2KdHzL49TP6dVDMev35nlZAarfiWSm3idrvaMOIZ8pt8ac0sF39Z+Ge9ClI4dR
	 4T3HX0SWJNZmpFWWuF83nrDOQjLqmGNoLsr9zHE4As5B7I34MUxzLXT+oS2q9LOYIzAsc
	 aH+Ze/iwPK8QafuesN/P6E+ztM18BqiXS4gu5bA8WEb2fJH0fStm9SVt110PFZncUng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WPJt7faW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8E606A339
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 22:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CE8E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WPJt7faW
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4adae187d94so934469fac.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 14:33:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795214009; cv=none;
        d=google.com; s=arc-20260327;
        b=Owk5FoHfTI9HeZkDqflOpCVh9akxWADNpfSJuR342FdfH4V+d8GK5nYjunuz+ipyuF
         K7Au/ARCh4/sr27gvCZOPvedg2xnTNA/dWfZW1q0Yi3c5vnQAyalA9HmiApom+40RLMO
         H11yI5JElKemg/t9Uqi+7i1SIT5Jk5T9Oej0zzJav/ti37md2tncPgKpG0bGLv9qTnZ9
         NWOCzaj7eKca2+1nXEvVCZkEGSbFfws3I5KtfXVCDKO9ya2H5whpctmfMDnoElau5BXF
         k7NIcCdJwXUxt3MfpNwxloZYjBb7BtccvnQoVEGEm8jiyCjRBxE4xPb34GgBsiSFjvJI
         nlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=NjGHsbldweRnr4/xsq2r1tnUyB+g32VIQ7hsyxVyeHw=;
        fh=gRLYu96uBnDlo1nqr0VYrJMf45gY8W5gYSFQdW7R52E=;
        b=JuRLkqIxi8qDoM0M9t25Wh74Wg5m5aw5LfXRmdeIchLm5PKtqhza1FYC57KgYckPdb
         ll4wIJE+xt+MuSCafWxQTEfWFmsrzB61hvqKgKR19sRMTczF1VbNKaxffwTVHCBO3icp
         ZvQyP6MRdtUQ7jSK1A+UNFoDTYI/b1xGu5LU9mpeyReNTxH9UOU5pbfDxWdfZUPG8Eaj
         KnJMdVlM2/mFo0d+ppgwe3/USRHlRQcAcMxKgeVX2eHdhQkdtE/LmIRYDRfvie+NuUPv
         pg1jVkF1WyaHyGNW/8l/YnDLrcRThU+mlsii5uHXS/45TUeMYH0rRBH3M0bZ6pMYz2eN
         XiwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795214009; x=1795818809; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NjGHsbldweRnr4/xsq2r1tnUyB+g32VIQ7hsyxVyeHw=;
        b=WPJt7faWtOibcMTtRfHUKrLg8irqIy6bHnEZJo+hPzM4ldY0rdVyYXkTxVYRhW0CFa
         1BHjKSX2P2WpZWAg2lBqafEi1JWroqLqojTOCjIGLHX/nOQiauNYLrYjS3yjk1irqwdc
         s/vs8CYVenbkzLC+fGSZtLfqsphTISS0vMIW5/Unrg4/zjqfCPg+MpJnxvjCxx/lU1jb
         A9f3d0r28CPuSraTdpfbyz7O+kIyRZn97bX920fOni0lgWw0nkNqnIpgh1wcM4ig7e8c
         OGrNG+isEaPH6FiOWW9Xgz9kBlRHXSwAfncmQOdnFfXdmGJtRDGaHEfY8IunP9uLH8NL
         IO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795214009; x=1795818809;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NjGHsbldweRnr4/xsq2r1tnUyB+g32VIQ7hsyxVyeHw=;
        b=FAqBICUlGzpLu3NSivcDqikZVo/a+QkwyTeJEgVzYiqIKLfjcx2bgIBCLKGSf7mCKA
         JErHIC5Skd2HOI32KsYar25dZ6tomCLWfPmVDKFvU0sYfJ1uoW9MED86YIK0Fy0+D9cO
         Cy+DF95dwKQ0o1ORLM01cx05yU+jNDypjjg5t9sMni/vAbEz1Es6F2HqvcFstg6o+xME
         vHFVU2aeD40ZXI2J3aAGpR/3jYNcLAN6BgcR0XOWJpWLyNCxZ4Eb2ay8KjOzuOLxWoqo
         +8aKkpg/1hQpfMn8hCQzHThl0ME+bbzD1lz5IgjlO59OkaKWj6wpYK5fT51BsFzn4TB7
         6fSQ==
X-Gm-Message-State: APuU4Z85BZ5KZOcsfBkhcOGmbq/lZv5FYj8FrH9Ggjw4ld+A3MFMqsRU
	pjjEmCquEwoA3Y09ulf9agmY1FDcWJvgXwS+v7w5LBu7W6VtPbZJRoXjIMkE7qAyxIkaX87HP1H
	JYnIRA1VtDNk7z0gueQbJV0RJID5aJXgaMbxgOWZw1w==
X-Gm-Gg: AZFdTZfciX6J2+4fO27Od6BPMh+9hGik918i5v+XrVvAuEDckGGAUtlNJw3f41shsPq
	8bffeUQeV6BTc1PTVDT9Uex0TD1heREep+m7jajrlym5NfFmeNaM7aBZZO0PlyDxpOtfOGiZtVE
	dKiKjW3Ghz8FjlRo7MAfxEoEIHxvsdste7pA3mp4W5Hs2FaeHliPW7Xm4dshXujM5Z2X8s+NC38
	rscnGn+0v+q7DzSjM0tEbZZ4D55ntP5maLkYT9oLWsjjfqY0yIzbtWcHs/MeeAnDByvu8Yh/Hpp
	WVuJwpEIytCUZldxPvMERKqT8wrUDtwIeAQOQRyiV8nW2vGTHRG+yPfwufa5VMdTKsZZVCZHQS6
	re02h1Y99BzrNn1Hf5+ugXSdsvjV5A73sFOpgGosPv4s0TnqsPpmpY+ZPdow=
X-Received: by 2002:a05:6870:e0c9:b0:4b7:4fda:1750 with SMTP id
 586e51a60fabf-4bc84145f58mr4294810fac.32.1795214009164; Fri, 20 Nov 2026
 14:33:29 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Kefah T. Issa" <kefah.issa@gmail.com>
Date: Sat, 21 Nov 2026 01:33:18 +0300
X-Gm-Features: Aa3M54r5qC7OD7cZ5dFAwn3S3aC6uePRdeAd-x09CEG_A_eaB8vwOR9YrF2laRo
Message-ID: <CA+mvMuuSaS=s6eYx30n1n7fQwKaX-d=jaCsZwSh7n=VirEAWEQ@mail.gmail.com>
Subject: [BUG] btintel_pcie: hw exception leaves controller dead (boot_stage
 0xd0fb6047) until PCI rebind, CNVi [8086:e476]
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

The CNVi Bluetooth controller on my laptop has crashed twice in a week
with the same error. After the crash the controller doesn't respond, but
hci0 stays up and still reports Powered, so connected devices simply stop
working. The only recovery I've found is unbinding and rebinding the PCI
device.

System
- Lenovo ThinkPad X1 2-in-1 Gen 11 (21V9CTO1WW), BIOS N4OET53W (1.16),
  2026-08-24
- Intel Core Ultra 7 365
- 00:14.7 Bluetooth [0d11]: Intel Corporation Core Ultra Processors
  (Series 3) CNVi Bluetooth [8086:e476] (rev 01), subsystem [8086:0011]
- Fedora 45, kernel 7.3.4-300.fc45 (the first crash was on 7.3.3-300.fc45)
- linux-firmware 20261019, ibt-00a0-01a1-pci:
  "Firmware timestamp 2026.36 buildtype 1 build 102163",
  "Firmware SHA1: 0xfbf3efe9", "Firmware Version: 19-36.26"
- bluez 5.88

The crash
Both times only an LE HID mouse (Logitech MX Anywhere 3S) was connected.
No audio was in use and there was no suspend or resume. Nothing in the
kernel log or the journal comes before it:

  2026-11-21T01:13:57+03:00 kernel: Bluetooth: hci0: Received hw
exception interrupt
  2026-11-21T01:13:57+03:00 kernel: Bluetooth: hci0: Received gp1
mailbox interrupt
  2026-11-21T01:13:57+03:00 kernel: Bluetooth: hci0: Controller in
error state (boot_stage: 0xd0fb6047)
  2026-11-21T01:13:57+03:00 kernel: Bluetooth: hci0: Invalid exception
dump signature: 0x2cfb5a78

  2026-11-14T13:49:14+03:00 kernel: Bluetooth: hci0: Received hw
exception interrupt
  2026-11-14T13:49:14+03:00 kernel: Bluetooth: hci0: Received gp1
mailbox interrupt
  2026-11-14T13:49:14+03:00 kernel: Bluetooth: hci0: Controller in
error state (boot_stage: 0xd0fb6047)
  2026-11-14T13:49:14+03:00 kernel: Bluetooth: hci0: Invalid exception
dump signature: 0x2cbb5878

After the crash
- The kernel logs nothing more until an HCI command is sent. On 11-14,
  turning Bluetooth off and on 4.5 hours later gave:
    Bluetooth: hci0: sending frame failed (-19)
    Bluetooth: hci0: Opcode 0x0c24 failed: -19
    Bluetooth: hci0: Opcode 0x2042 failed: -19
    Bluetooth: hci0: Unable to disable scanning: -19
    Bluetooth: hci0: start background scanning failed: -19
- bluetoothctl still shows the controller as Powered: yes and the mouse
  as Connected: yes.
- This brings it back:
    echo 0000:00:14.7 > /sys/bus/pci/drivers/btintel_pcie/unbind
    echo 0000:00:14.7 > /sys/bus/pci/drivers/btintel_pcie/bind
  The firmware then loads without errors and the mouse reconnects by
  itself.

Devcoredump
After the rebind on 11-21, a 4 MB devcoredump appeared for hci0
("Driver: btintel_pcie", "Dump Time: 20-11-2026 22:20:25", which is UTC,
the same firmware build). That is about 20 s after the rebind and 6.5
minutes after the crash, so I can't tell whether it holds the state from
the crash. I've kept it and can send it privately if it helps.

Questions
1. Is boot_stage 0xd0fb6047 a known firmware fault in build 102163?
2. Is "Invalid exception dump signature" expected here, or is the driver
   reading the exception dump from the wrong place?
3. Shouldn't the driver recover from this by itself, for example with a
   reset or FLR, instead of leaving hci0 up with a dead controller? The
   device has vendor_reset and reset_method (flr) in sysfs. I haven't
   tried either.

I'm happy to test patches or newer firmware.

Thanks,
Kefah T. Issa
