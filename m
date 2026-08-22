Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526AC332638
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787407943; cv=none; b=MFafgtU9EKVPcdnQSZMTHIPdjB/C8FVQASIsa4U7BGbipXpeGtoZe9hjpX401941LFmygZYlKfp+WI+zTaGVOAJH25NckP/DNKTN1e9qAnLueO7ow8ikWyhfC37ExfSQeEtaksLmTXs10hAQy8k+dgw9HPCHDXd1cT5ne/eIsJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787407943; c=relaxed/simple;
	bh=xDOQfxPkBNbbsOuEBrPL5Ba9mbUc5B/HErZUMyRz/Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bjMnz1EfyZt/z/qOJBUWaE0EWnmEe/jwMZhyziVMjoPYHmdmz9fxXcuJWz6MlcYaALiB/SWOwhiWRvu2rlGJ60VBlPRRETWV054CSxpcSCJNk7kHDNddmNUURqMBmaySzSlO1bzT3taq68wRyptlfWHe8g/uLYlEkWHkgGn1fs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyjMao6I; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyjMao6I"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso5081003a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787407940; x=1788012740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lzl656Kc/WnTsoNCqMH4D8QoNvmFwpgPRUVtnsAcOfI=;
        b=IyjMao6IN/foTY4AFQO043JCr2my550MMW02KzYaTRG70YyNLhzc1qIOz+OHad50YD
         cN0Ue8IqYcd32V6Mmb7z9UbyXHe/i+ed9waOemhE/0eE4hikHo4CjE5Q6lx26Of7rmXZ
         QwtYsLlyJM7vr2rglgJeAsnfZa9FgIBQ3u2lZVFRubdGauMzweLrJUTs2FQFQX5MtgNe
         6Yer+V5+hVCC/2USKz3HZduYBAMIVkvIH70ZAuWa/o06RTg2l2uhqfC1y2d9yvpWEYWx
         Ot62ykw5VCeBuunrA39tvs5dH0v8y5oAS6A5aoGOLc6145a2akmbHtuonRYq86j+Ajrx
         Mu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787407940; x=1788012740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lzl656Kc/WnTsoNCqMH4D8QoNvmFwpgPRUVtnsAcOfI=;
        b=H6xc5VVNlx01ePFR6PK94jY+WTK+t2tNJSw/SrhjDYuHCnos2ylvKboZBH7PYLZFOg
         D6/ec8e+PD+VNb7ctvdPBGrM+mZHDqeq2XmkBBi9tMlQ2yyH4twoK3Icbgtnc85BqTnc
         Hvj5Son4DSPW0d7ZYQD3xaFIfNsr/Z7gp7n+kiamRhTvhyaOk9HBkUi3J0p+tfF127sm
         xKJnKYTll4zXznSiJHRgkWNF70GLibew1sLk1fGlJFJ6N6B+uttp+5VuU8wpSFkJaZL1
         kUoI5XhN4Q7h2JovkaQUmFA/kVuvI24YY36UmPlgLR7YMY51XeNk7ngOpU1MZrkjaUdl
         wWCw==
X-Gm-Message-State: AFuF++nEx7gXL6x849o2K87Y0tB8JBYyQr1ERMOwse2w1r9HlF330gcC
	cb/Iq53JgymLiyrzOR8MZ+SkE+8dmHgSCHHe75+7TFKsHKgqKFr23np22caw9K+y
X-Gm-Gg: AR+sD122DzVscn9roMBPNlsdBOxhyh/lOSSJcLs4ZknWKECg6Mgd7kPv+IeCkWEWx7g
	J9LwOBrpF7YE7/D7sUW+XzkoM7IwC5MBgAwfBJKNiTIbjBoOsb0CtKXVmR9N9qaKU0d7QUQpOmx
	ntK08bSaaL7WCq++ltzydvFF8jHhdKqoFJrHeYJrjc0K3Ow2tbn/X6Cc9VWe6mDxjc2vVVwmZz5
	sC2sSFkccVvDi7F1zfKNxOONtkhemSkMoM7d9ORlWLRYDLPcQubNE4gAZUwC3twDOvTylLdrWLH
	56nLX6gMbVNMwPXGAcYqwEyTBtCtIw9BlbnveqkP9JxU/6aCQEkaMnCYpxFBLxseE5wfbsW+M7k
	LtTQl02z7yeg7mvwQ3tJZhkLJyCVeBdd0VKnQcdtT0IITmMkWn9POH0VzqRhoZgUo9Rxw4Tkiqz
	qBb5pNdlpN9AitV6Plk/WisVVCVWNCUTEWwsfLK+YbJ1hCOen1WKQGbuqix/8tW03g00c8vU5cH
	EQXaoBvPctU0GJ5nhmdwPJP5530J+HyYbcybLc2M3J5nnCFIUE/CeYQMX6yTob3/gl6LQ7X2XK0
	5jyzgLpfh4OchFUimXU=
X-Received: by 2002:a17:907:a88b:b0:c1c:2218:f317 with SMTP id a640c23a62f3a-c244d45ad2amr1712327066b.2.1787407940275;
        Sat, 22 Aug 2026 07:12:20 -0700 (PDT)
Received: from bobo (d163-170.icpnet.pl. [109.173.163.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496734bfcsm340625266b.43.2026.08.22.07.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 07:12:19 -0700 (PDT)
From: Kamil Serwus <kserwus@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Alexej Sidorenko <alexej@sidorenko.cz>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kamil Serwus <kserwus@gmail.com>
Subject: [RFC PATCH 0/2] Bluetooth: detect broken extended scan instead of guessing by chip id
Date: Sat, 22 Aug 2026 16:11:13 +0200
Message-ID: <20260822141115.58815-1-kserwus@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

commit 5ead2063611ae5 ("Bluetooth: btrtl: fix RTL8761B/BU broken LE
extended scan"), which landed in v7.2, regresses a different RTL8761BU
dongle than the one it was written for. This series reports that and
proposes a way out that should not need a new patch per dongle.

The regression
--------------

Hardware here is USB 0bda:8771, firmware 0xdfc6d922, ROM lmp_subver
0x8761 - an RTL8761BU, so CHIP_ID_8761B, so it gets the new quirk, which
makes use_ext_scan() false and moves scanning from LE Set Extended Scan
Enable (0x2042) to the legacy LE Set Scan Enable (0x200c).

This dongle is the opposite of the one the quirk was written for:
extended scan works flawlessly, but the firmware stops answering the
legacy scan-disable command about ten seconds into any scan:

  Bluetooth: hci0: command 0x200c tx timeout
  Bluetooth: hci0: Opcode 0x200c failed: -110
  Bluetooth: hci0: Unable to disable scanning: -110
  Bluetooth: hci0: disable scanning failed: -110
  Bluetooth: hci0: Resetting usb device.
  Bluetooth: hci0: start background scanning failed: -110
  usb 3-1: reset full-speed USB device number 2 using xhci_hcd

btusb resets the device, it re-enumerates (hci0 -> hci1 -> hci2 -> ...)
and every connected BLE device is dropped. With a Bluetooth keyboard and
trackball that leaves the machine with no input at all.

v7.1.7 drives the same dongle, with byte-identical linux-firmware and
identical CONFIG_BT_HCIBTUSB_*, for eleven hours and nine BLE HID
connects without a single scan error.

Why not just narrow the quirk
-----------------------------

Nothing available at setup time separates the two dongles:

  - same project_id (CHIP_ID_8761B)
  - same ic_id_table entry, IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_USB)
  - same firmware file, rtl_bt/rtl8761bu_fw.bin
  - both advertise the extended scan commands in commands[37]

They differ only by USB id, which btrtl_set_quirks() cannot see.
driver_info cannot carry it either: 0bda:a728 has no entry of its own, so
it falls to the generic Realtek entry in btusb's quirks_table -
USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01) - which precedes
the per-device entries. usb_match_id() takes the first match and
0bda:8771 also presents e0/01/01, so the specific entry for it at
quirks_table:840 never applies.

What this series does instead
-----------------------------

The quirk is documented as being for controllers which "erroneously
claim to support extended scanning" - and one that claims support in
commands[37] and then answers Command Disallowed is saying so itself.
Patch 1 latches the quirk right where that command is issued; every
later scan uses the legacy commands. Patch 2 then drops the static
per-chip-id guess, which 0bda:a728 no longer needs. In this order the
series is bisectable: patch 1 alone changes nothing for anyone whose
quirk is already set at setup.

An affected controller pays one rejected scan round per power cycle
instead of a permanent stream of failures, and dongles nobody has owned
yet are handled without waiting for a patch.

The latch is sticky, as quirk_flags is never cleared, so it matters that
false positives are unlikely: hci_passive_scan_sync() always disables
scanning before starting it, so the controller is never asked to enable
a scan that is already running - the obvious legitimate source of
Command Disallowed.

Testing
-------

Built and running on v7.2 on the 0bda:8771 dongle. Extended scan is used,
the quirk is never set, no 0x200c and no controller resets, and a
keyboard plus a trackball stay connected across repeated LE scans - the
exact sequence that wedged the adapter within ten seconds before.

What I cannot test is the other half: I do not have a 0bda:a728, so the
err == -EBUSY path has never executed here. Alexej, does your dongle
still work with this series, and do you see the "extended scan rejected,
using legacy scan" warning once? Also, 0x2042 carries both the enable and
the disable, so I cannot tell from your report which call site returned
-EBUSY - knowing that would tell us whether a single rejected round is
really all it costs you.

Sending as RFC mainly because patch 1 sets the quirk at runtime, while
the existing comment says it is set before hci_register_dev or in
hdev->setup. I updated that comment, but if you would rather keep the
quirk strictly setup-time I am happy to respin as a USB-id match in
btusb.c instead - it just needs the quirks_table ordering sorted out
first.

#regzbot introduced: 5ead2063611ae56809b1b113ac44cef9547c81d7

Kamil Serwus (2):
  Bluetooth: hci_sync: latch broken ext scan on Command Disallowed
  Bluetooth: btrtl: drop the blanket RTL8761B extended scan quirk

 drivers/bluetooth/btrtl.c   | 13 -------------
 include/net/bluetooth/hci.h |  4 ++--
 net/bluetooth/hci_sync.c    | 15 +++++++++++++--
 3 files changed, 15 insertions(+), 17 deletions(-)


base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.55.0

