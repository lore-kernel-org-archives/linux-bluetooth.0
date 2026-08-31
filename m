Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421BA446824
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185807; cv=pass; b=BG1ZQ/K+TQ69B11raD8o26ObFBE+Gsb4i4oaykCaJcRQBmtOT2WDfs+P1Yb4hhqOsx5Rnpz8dQlGib9PBO4gHtssPjbUlwwoVs3kTMqnTji4pEURkFasmn2KPu+lg/buHnMXPhgiG9Z2qu+H4HTqNEt/Xg1FB+8MjJiqqkkj/qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185807; c=relaxed/simple;
	bh=DpjeGfiLU2rTjMHQLp1UHEkEPHY/glbDSjeuGU5Hw2k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WvNBW49BzUYpp1NTJ6qINGnd5bZXRqnxJpKf2S/6Z5P0/AvvzlQtySldNDN6FEzYuM8do65agDV1Tml5cXsHzBEwmpNY82s4JeUTzSbkyWLaHcjaNokX4h5Po2pBaHj6JS/dZkAwyjHbgpGA4hjs4Uu0JUwB/eEuK3TZhH2O+sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtIldbIX; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtIldbIX"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a1981228f8so30899781fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 07:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788185803; cv=none;
        d=google.com; s=arc-20260327;
        b=dXzLWMZIaD25exN2chM319xs6ywNPbtYEtjfLyPX43LH5A20lj6je749ekcYEDWzMf
         9w5hxcu4ygYjbFZDGc5oALYPPOSpajpFv/yqAJ31poA/PhnK5WbLrV0yzQPEOxHV1RfG
         8PzldC6ukZm+EIy0zuK/RtT1bUI8aokF3WTFxnICMT0K96Ub4m3lwHTQJKSrdBdb+zPN
         rvbi178NG2I6h8Rq+9DRYpBkiOZ0XGwfrMlWc6z20TWInH44w2Yku05mdVyYKj5RvQ68
         owF9cSkvCx6fvQtmxQRr37VPyTcVQgCtCrlcl9ivUTbqgiCd2P3MwDOQAHcMNTJpGeS9
         naNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Y5kW1oC43Re3Za0mEonZCHkW7aldb420Yhm19USruTs=;
        fh=8wmIOxFCXHuVUjG4hJdt9ZexUUrfZJyDk4o5g+/RYXA=;
        b=mJ2xKxuX0ILeBxqH49FNhll5sAlwNrnTH9Hm/rA4EbD+lUB5AGJ31qVpJN9aGs/Vg0
         M36wUbXmCknJnUxVZ3bt/cicdcyeYC833usl3Kt3m7cenSv+oa5DIzKOp6Zc2kx3Iupu
         +g8m2OrhC0rKEbLQuTPp41nDLmtHmCs3a7OHt+9xLjqe/NJRFmdLhRIqKOW7O9JSPLTQ
         llV39VQ6yAZFNTDv9SyoMArrcalfELBSJjwG6jj+tNORZR1hjtsKRWrUDwCuw2TPzNiA
         vA1rU7ja51IwlsXFMvJrms5zbDVg5hoYIwFD/Q4pP9NbDiTailjh96ctL0/ACG8A1pKc
         cwLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788185803; x=1788790603; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y5kW1oC43Re3Za0mEonZCHkW7aldb420Yhm19USruTs=;
        b=mtIldbIXFRdL2/XQ/9/qOy5Kx6FDtM/7pj84tVSJ7XvcdrEonOxValmrL6dCTfMtKm
         P5AypWKtb4nmF77RrdhMlRnBhonABRQDPZxdHbegT9KDRFKGRSfpUS/JVD0GpKUpr8vs
         sWnX5XVyVOfngWpUIOXzT9xtfyC0LLLx2KCYDYpMH6gkJPG6kSFKO8vngGzZEIPM/huq
         AvmYDu3pDKIPJtSycaNT1QVAhQM429tiob2ZhiU/t0SvBZ0etVhph3+xUmqe5wQV4AaO
         g1U2nQhWgA4suDs3I3Qr6NhkR6lRnyPTfj4B48fQpmFb8lo2CxZQyoiLIjewf2VDTp6+
         q8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788185803; x=1788790603;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y5kW1oC43Re3Za0mEonZCHkW7aldb420Yhm19USruTs=;
        b=YCpcmQKeV+xMdqcXE3nPpHcjt4E0VFSUeBAhNX6irbdLdbBrJzhvS86i3fYmhhSwBo
         yFICUZeDSPS4CI+KatEnqeh1egpP5iaIfXryUyZNPjBF/03E4WuPTI+5asLvT84WIhH4
         WtS/Xeuj56ZJgj2P5ER4o9VTJsAG+l6RYgCI7xDHLkPtx4XoOXACOMRdli2tTk1VTm5E
         Rq3/JZAt9SWgFLtc5POc/rjJavOZOxcB1jtgjug1pvnbVeUjigHn1346jF4xlTGUeFKP
         4utNHlUNWfzO3rnrXHPucy3hxvIrdCuXTodnjnsoYYbFjX0YeIN7k1bQpV93fUexeakM
         zn6g==
X-Gm-Message-State: AFuF++mfRbXBJI7fTxLZNN0UitXzOixnZpOpf+KIshmOhY6M0eFmOPQe
	kzo2zpHRNxu6vE0qJeDuM3WA8c6nihpIFwCJgcj1vpRhnQL4UhrpEl8Kpb4aaUAs00hvymFsMW+
	JDdIi6tZm7TLZDlSVIWoWAbEkg/HDBNHCmO40
X-Gm-Gg: AYBFou0HWMRAjBsFdtgzzv4dy7C/sew//r1QabQ1zVFBrUU8EW5oktEoxRwKaOutG16
	9s7QCIZ/dhbdGw3AxPBt9SJVUnsRDSyNoZhhXYqIQ/v8QKy0iEqcV2ma10b3n6tvcStVyCxzwQm
	2S3jktoaB4Onj22Tp+D2t1j3WEFTBFpSAg8VTDhNdcJPDu3YIt2rDSaNenSL6HUlZy9jDgl6KTA
	8dem7ZaWnWjk2alO8C7b08mmhgU34yIWeEK+cbZ6rfRFL4FNcU0X1LQ95TGUR/l7O2Fm/lLFs9L
	TqazJMLRme95jW8em1Mhe5XgC4hEIziLc+dYLjhSTeSy827/Fyb7Vqtuok11vCJv6K2L4vnmLwy
	6Gc4DL5MSUQNz
X-Received: by 2002:a2e:be11:0:b0:3a1:9562:732 with SMTP id
 38308e7fff4ca-3a30187d050mr51927301fa.1.1788185802655; Mon, 31 Aug 2026
 07:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Quoc Vuong <dqvuong2111@gmail.com>
Date: Mon, 31 Aug 2026 21:16:30 +0700
X-Gm-Features: AcwNN1Wl79MjMeEklWsfp-yq64uWU70SmsqHw9Hiw3WYHdybmPxHyyOo_Nh6s2Y
Message-ID: <CAC1EGRsx7XFd+=rv5a73Mw95x5F49hUfgt4ouu5nZOYOTGbrzQ@mail.gmail.com>
Subject: [Lenovo ThinkBook 16 G8+ AHP] Realtek RTL8852BU Bluetooth (0bda:b853)
 never initialises: hci0 stays DOWN with BD_ADDR 00:00:00:00:00:00
To: linux-bluetooth@vger.kernel.org
Cc: max.chou@realtek.com
Content-Type: text/plain; charset="UTF-8"

## Summary

The Bluetooth half of the Realtek RTL8852BE combo card is completely
unusable. The USB
device enumerates and btrtl successfully loads firmware, but the
controller never
becomes operational: `hci0` stays DOWN with an all-zero BD address,
and bluetoothd sees
no adapter at all. The Wi-Fi half of the same card (PCI 10ec:b852,
rtw89_8852be) works
perfectly, and Bluetooth works normally under Windows on the same
machine, so the
hardware itself is fine.

## Hardware

- Machine: Lenovo ThinkBook 16 G8+ AHP (21VS), BIOS TDCN21WW 02/26/2026
- Bluetooth: USB 0bda:b853 "Realtek Bluetooth Radio" (RTL8852BU)
- Wi-Fi (same combo card, unaffected): PCI 10ec:b852, subsystem
17aa:b853, rtw89_8852be

## Software

- Ubuntu 26.04 LTS
- Kernel 7.0.0-30-generic (also reproduced on 7.0.0-22-generic)
- linux-firmware-realtek 20260319.git217ca6e4-0ubuntu1.2
- bluez 5.85

## Steps to reproduce

1. Boot the machine.
2. Run `hciconfig -a` and `bluetoothctl list`.

## Expected

`hci0` is UP RUNNING with a valid BD address and appears in `bluetoothctl list`.

## Actual

    $ hciconfig -a
    hci0:   Type: Primary  Bus: USB
            BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
            DOWN
            Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00

    $ sudo hciconfig hci0 up
    Can't init device hci0: No data available (61)

    $ sudo btmgmt info
    Index list with 0 items

    $ bluetoothctl list
    (empty)

Kernel log at boot -- firmware loads with no error at all, yet the
controller is never
usable:

    Bluetooth: hci0: RTL: examining hci_ver=0b hci_rev=000b lmp_ver=0b
lmp_subver=8852
    Bluetooth: hci0: RTL: rom_version status=0 version=3
    Bluetooth: hci0: RTL: btrtl_initialize: key id 0
    Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
    Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
    Bluetooth: hci0: AOSP extensions version v0.96
    Bluetooth: hci0: AOSP quality report is not supported

On a later manual `hciconfig hci0 up`, the same sequence repeats but
additionally logs:

    Bluetooth: hci0: Opcode 0xfcf0 failed: -16

0xFCF0 is the MSFT vendor extension opcode that btusb assigns to
Realtek controllers;
-16 is -EBUSY. Note this error is absent from the clean boot-time
sequence above, yet
the controller fails to come up in both cases -- so the MSFT opcode
failure looks like a
symptom rather than the root cause.

## Things already ruled out

These have been checked and are NOT the cause -- please don't ask for
them again:

- **rfkill**: nothing blocked (`ideapad_bluetooth`, `hci0` and `phy0` all show
  "Soft blocked: no / Hard blocked: no").
- **Secure Boot**: disabled.
- **Firmware config file**: `rtl_bt/rtl8852bu_config.bin` is a symlink to
  `rtl8761bu_config.bin` and decompresses to `55 ab 23 87 00 00`.
Several forum threads
  claim this is a packaging bug, but it is the correct upstream 6-byte
empty config
  header -- the chip reads its calibration data from efuse. Not the problem.
- **Stale/corrupt firmware**: `apt install --reinstall
linux-firmware-realtek` restores
  the original rtl8852bu_fw.bin (67765 bytes); no change.
- **USB autosuspend**: `options btusb enable_autosuspend=n` makes no difference.
- **Module reload / USB unbind-rebind / cold boot**: no change.
- **Newer kernels**: this is NOT fixed by a newer kernel. Fedora users
on the identical
  device report the same failure through kernel 7.1.4, and
Arch/CachyOS users report it
  too. Someone also built an out-of-tree btusb with a 0bda:b853 ID
table entry added --
  no change in behaviour.

## Notes for triage

This is an upstream btusb/btrtl issue affecting the specific USB ID
0bda:b853 across
distributions, not an Ubuntu packaging problem. It likely needs a
device-specific quirk
or a different initialisation path in btrtl. Forwarding upstream to
linux-bluetooth
(Realtek maintainer: max.chou@realtek.com) would probably be the most
productive route.

Related downstream reports:
- https://discussion.fedoraproject.org/t/cannot-enable-bluetooth-on-fedora-44-realtek-0bda-b853-rtl8852bu-opcode-0xfcf0-failed-16/191250
- https://discuss.cachyos.org/t/bluetooth-rtl8852bu-0bda-b853-fails-to-initialize-opcode-0xfcf0-failed-16-hci0-stays-down/31390
- https://www.linux.org/threads/realtek-bluetooth-usb-0bda-b853-fails-to-initialize-on-rtl8852be-system-hci0-stays-down-bd_addr-is-00-00-00-00-00-00-opcode-0xfcf0-failed-16.64397/

I am happy to test patches or capture a Windows-side USB trace
(usbmon/USBPcap) of the
working initialisation sequence if that would help.

## Full diagnostics

### Kernel / OS
Linux HOSTNAME 7.0.0-30-generic #30-Ubuntu SMP PREEMPT_DYNAMIC Fri Jul
31 18:22:54 UTC 2026 x86_64 GNU/Linux
Ubuntu 26.04 LTS

### Machine
LENOVO
21VS
ThinkBook 16 G8+ AHP
TDCN21WW
02/26/2026

### Bluetooth USB device

Bus 001 Device 003: ID 0bda:b853 Realtek Semiconductor Corp. Bluetooth Radio
Negotiated speed: Full Speed (12Mbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0bda Realtek Semiconductor Corp.
  idProduct          0xb853 Bluetooth Radio
  bcdDevice            0.00
  iManufacturer           1 Realtek
  iProduct                2 Bluetooth Radio
  iSerial                 3 00e04c000001
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x00b1
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0

### Wi-Fi side of the combo card (works fine)
05:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd.
RTL8852BE PCIe 802.11ax Wireless Network Controller [10ec:b852]
Subsystem: Lenovo Device [17aa:b853]
Kernel driver in use: rtw89_8852be
Kernel modules: rtw89_8852be

### hciconfig -a
hci0: Type: Primary  Bus: USB
BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
DOWN
RX bytes:176 acl:0 sco:0 events:14 errors:0
TX bytes:68 acl:0 sco:0 commands:14 errors:0
Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
Packet type: DM1 DH1 HV1
Link policy:
Link mode: PERIPHERAL ACCEPT


### rfkill list
0: ideapad_wlan: Wireless LAN
Soft blocked: no
Hard blocked: no
1: ideapad_bluetooth: Bluetooth
Soft blocked: no
Hard blocked: no
2: hci0: Bluetooth
Soft blocked: no
Hard blocked: no
3: phy0: Wireless LAN
Soft blocked: no
Hard blocked: no

### Loaded modules
rtw89_8852be           12288  0
rtw89_8852b           372736  1 rtw89_8852be
rtw89_8852b_common     77824  1 rtw89_8852b
rtw89_pci             114688  1 rtw89_8852be
rtw89_core           1347584  3 rtw89_8852b,rtw89_pci,rtw89_8852b_common
mac80211             1933312  2 rtw89_core,rtw89_pci
btusb                  81920  0
btmtk                  36864  1 btusb
btrtl                  36864  1 btusb
btbcm                  24576  1 btusb
btintel                69632  1 btusb
bluetooth            1134592  15 btrtl,btmtk,btintel,btbcm,bnep,btusb
cfg80211             1536000  3 rtw89_core,mac80211,rtw89_8852b_common

### Firmware package versions
bluez 5.85-4ubuntu0.1
linux-firmware-realtek 20260319.git217ca6e4-0ubuntu1.2

### rtl_bt firmware files in use
-rw-r--r--   1 root root    19 Jun 24 16:52 rtl8761bu_config.bin.zst
lrwxrwxrwx   1 root root    24 Jun 24 16:52 rtl8822cu_config.bin.zst
-> rtl8761bu_config.bin.zst
lrwxrwxrwx   1 root root    24 Jun 24 16:52 rtl8851bu_config.bin.zst
-> rtl8761bu_config.bin.zst
lrwxrwxrwx   1 root root    24 Jun 24 16:52 rtl8852au_config.bin.zst
-> rtl8761bu_config.bin.zst
lrwxrwxrwx   1 root root    24 Jun 24 16:52 rtl8852btu_config.bin.zst
-> rtl8761bu_config.bin.zst
lrwxrwxrwx   1 root root    24 Jun 24 16:52 rtl8852bu_config.bin.zst
-> rtl8761bu_config.bin.zst
-rw-r--r--   1 root root 67765 Jun 24 16:52 rtl8852bu_fw.bin.zst
lrwxrwxrwx   1 root root    24 Jun 24 16:52 rtl8852cu_config.bin.zst
-> rtl8761bu_config.bin.zst
lrwxrwxrwx   1 root root    24 Jun 24 16:52 rtl8922au_config.bin.zst
-> rtl8761bu_config.bin.zst
rtl8852bu_config.bin content (6-byte empty header, matches upstream):
00000000: 55ab 2387 0000                           U.#...

### Kernel log at boot
[    1.259178] kernel: usb 1-5: Product: Bluetooth Radio
[    3.259080] kernel: Bluetooth: Core ver 2.22
[    3.259137] kernel: NET: Registered PF_BLUETOOTH protocol family
[    3.259254] kernel: Bluetooth: HCI device and connection manager initialized
[    3.259285] kernel: Bluetooth: HCI socket layer initialized
[    3.259310] kernel: Bluetooth: L2CAP socket layer initialized
[    3.259407] kernel: Bluetooth: SCO socket layer initialized
[    3.309027] kernel: usbcore: registered new interface driver btusb
[    3.316049] kernel: Bluetooth: hci0: RTL: examining hci_ver=0b
hci_rev=000b lmp_ver=0b lmp_subver=8852
[    3.318024] kernel: Bluetooth: hci0: RTL: rom_version status=0 version=3
[    3.320055] kernel: Bluetooth: hci0: RTL: btrtl_initialize: key id 0
[    3.320109] kernel: Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
[    3.322041] kernel: Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
[    3.331283] kernel: Bluetooth: hci0: AOSP extensions version v0.96
[    3.331374] kernel: Bluetooth: hci0: AOSP quality report is not supported
[    5.563024] kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.563091] kernel: Bluetooth: BNEP filters: protocol multicast
[    5.563124] kernel: Bluetooth: BNEP socket layer initialized
[  367.559111] kernel: Bluetooth: hci0: RTL: examining hci_ver=0b
hci_rev=000b lmp_ver=0b lmp_subver=8852
[  367.562073] kernel: Bluetooth: hci0: RTL: rom_version status=0 version=3
[  367.565092] kernel: Bluetooth: hci0: RTL: btrtl_initialize: key id 0
[  367.565228] kernel: Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
[  367.565292] kernel: Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
[  367.571085] kernel: Bluetooth: hci0: Opcode 0xfcf0 failed: -16
[  367.574073] kernel: Bluetooth: hci0: AOSP extensions version v0.96
[  367.579323] kernel: Bluetooth: hci0: AOSP quality report is not supported
