Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793044531;
	b=FQqYO2ihL2abxxiuo4cld7zb2Qf1tkJ0wBqVAChoRmUN0pyB3uSqJw/3zD720VQxl4wH
	 DIZvMenmvO1o28JMJy/6UBw9sxf9p7q1O1EVIuMBxwVlA6lqp0cib2acPbw7aD2DXCoFR
	 uOBoy9hbVxZusMSCx4SZ3fHGI84If48i4Pf6Auw3YODhQT/g35p4MZBNXUTlPHCQvNnnu
	 Kk6aGExeN4zry/GO25IdF14kxS3X3pv1yx1BE0JrWle4eCeo8pYav9GsWpOJkk1yZViV0
	 4QGr1bkumN1hyCdYIsKmGXo+BAgPkFBYFAyGK38vNMah6lh/aYDhgDpyGaUzFClSh6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793044531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=KFWLY101kRHD9mssadgRRPoV47HkqjA/2NAH0ex4JXs=;
	b=Wnr2g6QHlSO9ID/tKYLMIUVhkjqEXsF9LKZM5whESYescKX4UsbEQT4RWpFebXemyqd+
	 11j32c+ZbLxSVp7u6TjgqbfjYhm3mtWAoq7DZLZdqQ8PHbEHs2NU2Qt6a0YBG8j5RkMMx
	 QJj6WMcsp/iamkeGdSFzMzTcoeBfRpe0iIiahNyj4SRNixdTBfDwWRDdobv6c9/mzrbF8
	 /nlgvoZjUlZTKqkF4OCwZxRoa9Yeo7oYI8aWWzed8UibI9lCmADHBvsI08IrcDliEAMqg
	 aRsHyaS0khilB+tmLtROgLrfd2dTux8vh5ZFsk0MCQF3FNDpic6zRzjnAaIxwi8e5FQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pnTn02j5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97195606A31D
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 19:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97195606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pnTn02j5
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e8246b13cbso30063145ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 12:55:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793044529; cv=none;
        d=google.com; s=arc-20260327;
        b=dUlmJk2W1q5TXBIiur7kTqh47TSxcIoTxNjvDqzEocSHwMHIZEpTGnAontoh5ts4nt
         5d12/zciSOw3akdaC3nnlN3YZHlM8qjeJHVOFBfNjsGzTn3x3wuBF3eeLLEItXZrYT3s
         BWRxGnlWM+6k0IFya58k5hmTktyAAJLant2V1tXw94OrKTtukNH6cm8boU9HBlRtBFqP
         iGVdI8kaKbWGKBts4Lf1tWsg5sFcn0pClOUtjuNiy9ZRKllMnNka18sLUh0uyFM49zYv
         f9fvRXmSPP3Zy9M9RSlwDoY6N3WIXRdn90+Y8LYw+phrNoYYBplDd9lxrFXxBTLx1sUM
         ed8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=KFWLY101kRHD9mssadgRRPoV47HkqjA/2NAH0ex4JXs=;
        fh=KX8oQQsdwHZEDxIjK3rm0DF+tF80/skxmPBnrW0cwBA=;
        b=raaVufAqOx/UItsNL27qAe7TgzJX+DNoLs7b0JPQhPc/DjoeqqvrAmSALriF/kGOo+
         82XXGn29kSEbyo6RVKPBiu+8NYpQBc5epOVaWvEMFl/gVjA6/paw0JTD6njHjs/0d9fz
         TOpjWn1hajaIKVubu5qhwTA/zTRU9jiyXdx8/uNG2NUa4L+PthiL8XHHKf3q4u9B0hU3
         ufBhGeMK/wG/v+/m0AYSu69K+/DkEyD6DGBT/Ps19fidzqIcKrS0dydNMwycHRSUk/A2
         FHHvyyAD7+lWjbr0EcWJHPzwum3JDi9qm8rIPKEeFAUMRLWjCVSGEuNDeZUK9m2Z/uuc
         yXGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793044529; x=1793649329; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KFWLY101kRHD9mssadgRRPoV47HkqjA/2NAH0ex4JXs=;
        b=pnTn02j5dljxn90Fg5vBA5cheL//cy2a41aTckacUQD9EKGcBOYWJ020Kd+XQy1ZJq
         vpsG7s5j7TmJCV+eCxFbX53lo/kKQi5DB04x6XVPsL5xxa9Jq+z97iptcfjOF4byI7ZN
         4chCqm+v0QCnAeLB4lHza0rlKZ/BeT4FQQMVwM8mzR9weKxxpRrPoPNGnrifjYHNCtbU
         Nb0lOLELPiLs9u9+FOkSuWHLYMW+2ktEPqgXh7Wuvvx31Ob7xT9h1d/C8/4wfyGcyHXy
         7ZcbgbyAkOFU1UlAlPiozxwfAvV/PgbEF5c/K0KA9OU/XujPv36U7bm+DEvX29x8BjVb
         nnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793044529; x=1793649329;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KFWLY101kRHD9mssadgRRPoV47HkqjA/2NAH0ex4JXs=;
        b=V/f+632Wu9MkxgVkiGL2y/az3apa7k323dixITVE6Kbdp1wud7G7luINGBOHgqZ3t7
         W5ktQiBqiOW7bngoLxuAUAypq92CrQpRCLL12xkgsxrE7XZdxtneQeoi0cPiBfr4e0+f
         jYoYCj20CEQHGcqooEFglcLyjIZe+IVf+WumNFifLpxkrxzzpk6IaKseNonPgtlqMAug
         cn0USZL77CeOnFiVa8c2YDqybruIFqcZuxkUiu/ulGs2yyu0n1V5dGXI3gpvEU5drUES
         7+xe0LvCYOtE5EcgTm0IE3LDfSoKhxwAeIVK+3pptlbetgd3D09nWdj29T91BAeOtJ/p
         xt+A==
X-Gm-Message-State: AFq9FYI9FXpzk21cMBGNbOZ8VRR/FoN5EAhMiauUPGqFXFT5gVUFig9C
	W4RB1O4gqt0LYQybL3j5Ii8sEiK0l4+FosebSDhNmdhuQD4hGXmoBIUiKvMZE1SD7k0XzV2RvZn
	HEEI8d7LtwdoaUV3DjPwu8xr9YBOqnLr4/zjEbTM=
X-Gm-Gg: AYBFou0DlLyW4uZrpHBDfIoHhlEHFdnyToG98DbRfY+hbSvGbn5whtPJrl3Tlmbd7/6
	cRP/DSzYdT60hRTUGw7ynptNh9IGN8Lw9tpjE3D4uVQGNW+Bo9M5LXgI4qSgcCPpJhMOOkVDevR
	/Ps+qT45Urw1PB6lFFsnlbtSEnk/sI+uEKmM9NeV7eMZ+02PQ8QBiqughiodcvfAEdOWOzFs/VJ
	m17XLpSbg6d4mWM46bTGvYbVjjtuJjnwVx5YBahNuMuk6n4vwHbPxyQsT3TjLFEBLhsyV+zzxIz
	NKSPEm0QxYvaoJffUo/m9efh/mVmF2TxlXDGBWRbJh8HG+ggJ1UADTGVK2nMjOkkfreiaceVOjy
	F8ilhR8UGvoQzW6DeCSireaN4Tq2/wlAiuMmBgICVSdiy47lSCIb82NlaOsO3rPzA5+i6oywphm
	H5QWgs1SrnuRQua//++P5nuNSydTx2BhH1e5SuNkzssjEGQc6Re8uW3XzcOKPXfrXGAuCEtZFwl
	et1hu0wzXtY
X-Received: by 2002:a17:902:db0f:b0:2e8:4066:d247 with SMTP id
 d9443c01a7336-2ea9c697792mr70723705ad.33.1793044529481; Mon, 26 Oct 2026
 12:55:29 -0700 (PDT)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Athos Andrade <athosandrade04@gmail.com>
Date: Mon, 26 Oct 2026 16:55:18 -0300
X-Gm-Features: AclHuK8hIyLF2cY2Je-JDB_x2NuD_QbnLgqmgjFyM3CEYmAXLDMd_z2lD3A7og8
Message-ID: <CAAErAfLhrvtQOEqtGhEOmNX+0Lkq7ckLekmgSjot4-7jFD0shA@mail.gmail.com>
Subject: [BUG] rtl_bt: RTL8852B BT USB FW 0x127C_FD78 stops delivering BLE
 keyboard input, 0x42D3_4E04 works
To: linux-bluetooth@vger.kernel.org
Cc: linux-firmware@kernel.org, hildawu@realtek.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Since linux-firmware commit 4ca3317e ("rtl_bt: Update RTL8852B BT USB
FW to 0x127C_FD78"), a BLE keyboard connected to the RTL8852BU
Bluetooth controller of my laptop stops delivering key presses every
1 to 4 minutes. Going back to the previous firmware only
(0x42D3_4E04, commit 8bcc91d1) fixes it. I did an A/B test and the
result is repeatable.

Hardware and software
---------------------
- Laptop: Lenovo ThinkPad E14 Gen 4 (21E4001GBO), Intel i5-1235U
- Controller: Realtek RTL8852BE combo card, Bluetooth on USB 0bda:4853
  (ROM: hci_ver=0b hci_rev=000b lmp_subver=8852)
- Firmware: rtl_bt/rtl8852bu_fw.bin
    bad:  0x127cfd78
    good: 0x42d34e04
  rtl8852bu_config.bin is the same in both cases
- Kernel: 7.2.8 (Arch-based distro kernel, linux-omarchy 7.2.8-9)
- linux-firmware-realtek 20260916 (Arch package)
- BlueZ 5.87
- Peripheral: Lofree Flow2-68 keyboard, BLE HID over GATT (HOGP)
- Other LE devices on the same controller: Logitech MX Master 3S,
  Logitech MX Ergo S

Symptom
-------
The keyboard stays connected but stops sending input. In btmon:

- The last ATT Handle Value Notification from the keyboard is a
  key-down report with no matching key-up report.
- After that, no more ACL data arrives from the keyboard handle.
- There is no Disconnect Complete event and no supervision timeout.
- Other LE connections on the same controller (the mouse) keep
  delivering data during the freeze.
- The keyboard does not advertise during the freeze.

The only way to recover is to reconnect the keyboard from the
keyboard side (Disconnect Complete, reason 0x13). The kernel logs
"Bluetooth: hci0: ACL packet for unknown connection handle" at each
reconnect.

The same keyboard works without problems with macOS, with Windows on
a different machine, and with a phone.

Connection parameters
---------------------
The keyboard sends an L2CAP Connection Parameter Update Request right
after connecting, and the host accepts it:

  interval 7.5 ms, peripheral latency 44, supervision timeout 1500 ms

Ruled out (all with 0x127C_FD78)
--------------------------------
- btusb autosuspend (power/control=on): still freezes
- reload of btusb (new firmware download): freezes after ~1 min
- Wi-Fi radio off (rfkill block wlan, wired network): freezes
  after ~4 min
- Num Lock LED off (no LED output report): still freezes
- new pairing on a different keyboard channel: still freezes

A/B test
--------
1. 0x127C_FD78 (package default): 3 freezes in 6 minutes.
2. 0x42D3_4E04 copied to /lib/firmware/updates/rtl_bt/, btusb
   reloaded: no freeze during normal use.
3. Override removed (back to 0x127C_FD78), btusb reloaded: freeze
   after about 1 minute.
4. Override restored (0x42D3_4E04): no freeze again.

I can capture btmon logs (btsnoop) of a freeze and test new firmware
builds if that helps.

Thanks,
Athos Andrade
