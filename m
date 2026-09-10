Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA15616A5
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069103; cv=pass; b=Pbcri+rZNgmcBnUtn4xGyetSlZWn18HnvxfzaKdEFxBMVqoJbs3ra9uuDl95h8tukRSzZYtQWWjAECFDxue/ovYhH5scAJfi1UjoYurMpmm/QWV7ay11H8xY6Iv+58TzO8Me+3tkuOfjCmtL7yfDaokkyBVhT4T1wqzlPqSFq3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069103; c=relaxed/simple;
	bh=QwfUjTsPcCrR+WsR07JjwB4oBCESRwvkyTXKa6tz6Ds=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cnwwdgncnSGy5wAMjYnlW+c/E/ASbF3FiN8N06bp4EgmJlrmHfrTkWfCXi3Yk9Eqty1uKFF80zvxgYLC4RYsJVqWno0IJ6N4p2v2r6SbKAmDuXrtTem4idOpIBwz+aJ+CIHsbfCVESFW/qRO9Y8dNjKTcx33DA1PE21vtr3PKds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIA4ojCB; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIA4ojCB"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so194385a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 12:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789069097; cv=none;
        d=google.com; s=arc-20260327;
        b=f/NeDhx6+8aIab9qvQM9arnqCQ0qYV2fcdC7htnqkjmCpANyeE1eunY3Klk+3bpkug
         QMLTTqM2i4eBrxzsmUdaWJhU3z8AyQdzGvG297wPqFcQCanw1L0PUGRy4Mz7wmIbIYwJ
         jIiNmXCChFWwScjGDN5Let7RSYsnX4oP9xD3qmigFT/0Sx+sgWIyIGusKf0mlmD+3jl9
         K2dnepvX+UQ5b+7JbjAuyUtnAeChgFe2JhTDhNjekNII6aNct0RcuIDV3C8hLJB++ak+
         YnVZ6Og8H9QnKjO/L3jrCI44qNf+Joh7F7iEZf6XWp0WQP/P8Xtip5rgatSuxf27hB7g
         hCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=vZImdanCLbw+Wm7Sn8/G+c9FIIp9Rw6Fv9R7mMtLeo8=;
        fh=Zule39596HsbGOl1YEAPf5mOdTMaxUdVpZJP1P11V6M=;
        b=U6HwXgatwR+OOE9wUPspH6cyEUxe11Yli/o2+XYspQQPODaUDpPYS4U1rJBfUBtPZl
         IfrMMR4hFqeVQnSXbE4+YZO+x/qYXEkpJHMzx7yPdeXC67miRNbucuH6OXfLDkcpXKv0
         rFY+gnNLy0sbw/UBd8IonhuiWXz0IvfJusT5Z0pTM2db1zFSmw7PidJ53e74Wt0lkJWo
         YJcCKqXYaFHZU/f4JioezNuuaszjqJxGv6w1aZXr32leG7j7nmkQKPEdz9+iZ3/YkzTm
         fhrHksC81YGdNEc+AmNT0s6bjlnVdzDyDUxQAu5JakZzgyFsTy+wHvQtpxuTcXEz0AZT
         Iz0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789069097; x=1789673897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vZImdanCLbw+Wm7Sn8/G+c9FIIp9Rw6Fv9R7mMtLeo8=;
        b=gIA4ojCBbYFy9wvo2BBkX1BSISCrLKwyeVlorwUGBBVYRGoRE9hMCrVHMrOZSiIEXo
         fSyxW55VWUFxE2e+zMAloY4sSXSZTNo1I12pCUDoQE1WUmCRI4VErh1A9/KOtovfvV6D
         7kTe/xyQklpVu83n6drhGatw3BT++zASJJ9YA64d9bphH35l9HlVwNr2WNY7B2CF0LBx
         xbhdgWnUrGG7x6KOew977BI0Hs8t70D6MSSSq4vCquL09BJ8RudE4yqymd79usoGrMMj
         0KdaddZasI9+ikskBKM9KCJo/sZq4PyphJ+CjPepJol+6xo6WDsr+8HoWlA6hcW8su4p
         qvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789069097; x=1789673897;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vZImdanCLbw+Wm7Sn8/G+c9FIIp9Rw6Fv9R7mMtLeo8=;
        b=AcdmutBLMTLcy3vnYybNiJntFxwdj5iBXXxjNYE/Et0zycKi2VeFBk8yXo1kCo6JfR
         IGD30sHug+/bx1P/DPI4+tT5moi4phSaOOTVOm9Dla5zgBpf28i6fSL0dyMYf/A8LBZh
         yk4BctT4HEyXgWDp7yqbaefjDO8/tHD4dJe/yzrBgtGx4fWPlav0tT0EnxjVJQLDuTHq
         d92DvR17oTxm20zyFDwHKFMRL3J5lMvVts2uE33MFbhjckGUIjdSQBwsq5FrFg809vcf
         GnCOByEaxMU1m5offpws0kBYJC5lCLwCOavGSrCn+PFWsjjJDWZ9pZgh9fQewlpb0Qx3
         l8uA==
X-Gm-Message-State: AFuF++n6JPQ24rx5Cnbm+gHgg17IUy5IpQvyyCerRKWfytj4TjNMOuUh
	yyulJMkj0B6t5yZ16YRkaTsqSnVbKnK67KZrQAS4K+APgfbbRPU7BV5Hx6WQVDmSR6do5K04ukk
	t2rI1bQVfm+Nf94apKWiRQSGCBDHQkcmM93gBTIA2Vg==
X-Gm-Gg: AYBFou1OAYsU+EjDGZl6VAqTwrWS+90vMIG36opfigo1KxDpk90ejwytNySNhRBBhRj
	vCO/8gkWZvbCDNybo6ZbQOGeYcHZmkVgo9Wjz4wzl9BZlUTe8F5zcFa5/TbwCgZ8fT7GFoNI/zN
	sRvudw4Aj+FC7nzCHt5qh0Gz9saNdBMil49lTOdRtR6iaWpCvp6LarHACAckPfcK8nBWODtYiT9
	qIzEpl3XD72n3Ic5OsyiAdqHBGvD6mBJ19oKCWLSf83qoiih+yrk1nfuB5yZda3KDHNureN/IZj
	bskngPGjyY7HmrDTjaFt8sviXKqaPXxUnrgsxtDTqT9fy+vX2Zq6LU8ZWO7DGplpW4vMKiPOb1l
	m24+Ab3eJiOwJCT9D5PI6xgP1KxUEJwlx0rwNKwWsz4u0tPbWrfTK0nVVEjj/0+ITi78iEFP8
X-Received: by 2002:a05:6a21:d8a:b0:3c2:dcdd:a85a with SMTP id
 adf61e73a8af0-3daed5d1834mr758790637.13.1789069096914; Thu, 10 Sep 2026
 12:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Lomas <david.s.lomas@gmail.com>
Date: Thu, 10 Sep 2026 20:37:40 +0100
X-Gm-Features: AcwNN1Xc0oKMxqTRsEswAamAg5ei2rtw2jhkZBD1Uxekf_h-Wb-VKxk2IgOYJQg
Message-ID: <CALjEBWRoqHa=833_dpDxaWpj-tAiAhLuLZBfRQkOkSGgGF5gQA@mail.gmail.com>
Subject: [REGRESSION] 7.2: restore from hibernation hangs while btusb boots
 Intel AX210 (8087:0032); 7.1 and 6.18 fine
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, johan.hedberg@gmail.com, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

My first message here, hope this meets expectations=E2=80=94I had a bit of
help from you know who...

Since 7.2 my laptop hangs hard while resuming from hibernation, and
the hang goes away if btusb is not bound to the Bluetooth controller.

#regzbot introduced: v7.1..v7.2
#regzbot title: restore from hibernation hangs while btusb boots Intel
AX210 (8087:0032)

Hardware
  Dell XPS 13 9360 (BIOS 2.21.0, 2022-06-02), Kaby Lake, xHCI
8086:9d2f (Sunrise Point-LP).
  Wi-Fi/BT card is an Intel AX210
  Bluetooth controller is USB 8087:0032 on bus 1 port 3, driven by
btusb + btintel, firmware intel/ibt-0041-0041.sfi ("Firmware Version:
202-5.26", linux-firmware 20260810).

System
  systemd 261.2
  No BlueZ is installed: the controller is only ever set up by the
kernel's own HCI_AUTO_OFF path.
  Root on LUKS + btrfs, swapfile with resume_offset,
HibernateMode=3Dplatform, mkinitcpio busybox initramfs with the resume
hook (systemd-hibernate-resume is present in the initramfs).

Kernels (Arch Linux packages, unpatched apart from Arch's config)
  bad:  7.2.2.arch1-1, 7.2.4.arch1-2
  good: 7.1.4 to 7.1.10 (weeks of daily use), linux-lts 6.18.49 (12/12
cycles under the reproduction below)

Reproduction
  systemctl suspend-then-hibernate with HibernateDelaySec=3D2min, lid
open. After the timer wakes the machine from S3 it hibernates; power
on, unlock LUKS, the boot kernel loads the image and hands over. On
7.2.x the restored kernel then stops within a couple of seconds,
within the first three hibernate/restore cycles of a cold boot (it
happened on the first cycle twice, the second four times, the third
once, out of seven tests). Screen is black, backlight off, no
response. Nothing is written to the journal. With efi_pstore +
hung_task_panic=3D1 + softlockup_panic=3D1 + hardlockup_panic=3D1 armed and
a three-minute wait, no detector fires and nothing ends up in pstore.

  With no_console_suspend, a good cycle shows these lines on the console:

    [ 2043.009649] atkbd serio0: Failed to deactivate keyboard on isa0060/s=
erio0
    [ 2044.588080] Bluetooth: hci0: No support for _PRR ACPI method
    [ 2050.400042] Bluetooth: hci0: HCI reset during shutdown failed

  and eventually the desktop appears. On a bad cycle, I see these 2 lines:

    [ 2750.173700] atkbd serio0: Failed to deactivate keyboard on isa0060/s=
erio0
    [ 2750.959900] Bluetooth: hci0: No support for _PRR ACPI method

  and then a solid lockup.

Other info
  - /sys/power/disk =3D test_resume (write the image, read it back and
restore in-kernel, no power-off), each preceded by an S3 cycle: 8/8
successful on 7.2.4.
  - Fresh boot, `modprobe -r btusb` before the first cycle: 4/4 clean
restore. `modprobe btusb` again in the same boot: hang on the 2nd
cycle.
  - A systemd unit that unbinds the two btusb interfaces before
sleep.target and rebinds them after the thaw: 4/4 clean, Bluetooth
otherwise usable. This is my workaround for now.
  - Thermal-zone state (7.2 moved thermal zone resume earlier) was
tested and does not appear to be involved.
  - At every S3 wake on this machine btintel re-downloads the firmware
(~1.4 s); in suspend-then-hibernate the hibernate starts while that
download is still in progress.
  - Plain `systemctl hibernate` (no S3 first) has not hung in the few
tries I gave it.

Happy to provide full dmesg of a good cycle, try patches, or collect
anything else that helps.

Thanks,

David Lomas
