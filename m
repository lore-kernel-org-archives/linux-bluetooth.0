Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276010F1
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599851; cv=pass; b=Mo6Mg6x1+FW6a1jKNrK+9dEYoR9t7W12yK5yK61KjsOHLCPtwl91n7s9mAChdVN40Z6F2DVQ6doNGFFCrz1vg/zfRKfLhADrjZRq6j7iUhT24Hbg/N/1wScoR8q9Ui98zPOg475+1xHWfW8qGWROkVPUl96eMOrnzoTzI4D5Bc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599851; c=relaxed/simple;
	bh=1dIpHQsevSfQlf9DisDaFsKWICHPyLtn7XOv7xQYkoU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=O+Os+n+qUF5/h8mVw3m//LvbHKj/wGUWH7gIanSyrqXAQeDZ95OcK4k6tDfU7fBY4odh5I0nvVZ8M/IobJHdg9e9JTw6VUDyoQC9uJvLX4uhNCAVchM+oUzLfT9CXJmXpN8IlGkJiL5lL/BTCOj/jsxNIDuA/cuWzfWcm5QwOxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvE5/gqV; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvE5/gqV"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ef7b7651ecso43146476d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784599849; cv=none;
        d=google.com; s=arc-20260327;
        b=RN46s9WCQIjcC3VfGwXtY2II1/Wx6iORkQHXmvChjO35yoIMixeSvyNKqOrrBRnHuZ
         /WvsDINHB1a+QEqArTW4I+/PgOCKpVn/voA+Z1YUkJjytcJW+RP1kGVkLkzCxdTJsEGD
         wfyPXf2Ef74LjZIIvl0zhfznGyX0/M+GboJM54VQbSaZ+d0b2K1/SYVWA2IQlKGxnIXX
         zPZNZN+4W83d8ax7ilhote8dt1D6IxJsp+PNbJAxOpzlTKbVvQRLXnnltl0z0ybKVUvP
         E0LgaWLJ7ApaqBLPq2DWX6rm1IU+p7dydOJfJHxu9aS1wqdo+fLzqLpi6fBeraVjFsUM
         WYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=GgYKG4AoJstaGEOQTQS0RzISCFiGWfsaq4PDHGbU77c=;
        fh=57qyEZNdGrDPmxvVGEykGBW4sEu+txlrN6w+N80qi4o=;
        b=NzQl9CTBWem2AbBfL+ebZoa9qwMq1vPNwfF8VxM9NRHu8gKxeGWrSEFRK6J2c3nIHB
         IKBpLmgiIcGsC8BIu4OC53SDhtb2R8z8SZyDbINwsjkhkN6dAlmqUkF6/TNJKiln8t+s
         nN2wifyDP/Qc5PVPECPN3+Oj0znbXtJ+19QpfysBpQZ2VUbjROakybJhiDB5GGb/9d0C
         JOBvFyd4G/fCWcueqIlNpxJk8QxCuSMoJPW8Rn8fcMCBdXqKudiH8uoLG7CtxLLNrMCO
         lV82l1D/k82EdaAXguXbvTlMSBKiDy4HrUSFVWlpQraPj8T84SwCXQdIQfjYv1/aPaMC
         oRYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784599849; x=1785204649; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GgYKG4AoJstaGEOQTQS0RzISCFiGWfsaq4PDHGbU77c=;
        b=GvE5/gqVwVCA0toEBQIqnSROaZgq0Zcsi7jv3v7JyTLcZes9YhRCa2oTnQtOs8cF2b
         5tFK+J83Lw+5QfNzeqDN3qvSxR0Z6Pf7vvQDj2z/tlhhHrWNH1HJfZtNkhRGs8+OVNrd
         vTSfLayg5VLT2hBTzVZS3IWxdp1LpRjQ/eB5Db8PTppxYaWex26BaRiCTMX4hcBXD98u
         MCtOCAiVJXujewuMk6KyMA4f76xDvz4pUR3ujSF71qOUB9gWDdGJ33MGH5bB8UxJGyRa
         ADLWWUN4xd0yMG4uBYf390g8JQDmy28QY2qt4N4UzFUH060TLIKW4fTDn9s8dRR6y3IK
         +l1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784599849; x=1785204649;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GgYKG4AoJstaGEOQTQS0RzISCFiGWfsaq4PDHGbU77c=;
        b=aYmHXmU6tYzSQoBPw4x2rWcAhcsEd4aie0Tzcx1COfncGQyK7UEtIDCn7BVMecgI/A
         RYJR0gn2BKKD4RFhC5Qb6Jvx2lrE4vKemjxjYWIh01uTV0gGSmZV3RmsptpQzn4QTEXn
         ukuRc3Ywh2MfTryBv4bJYib//0Wklng6n7rzb7j7dV7hnb9rPiTsoQIGbD549b4MBM3a
         IvEB8/ykQIaHjW5Ne5Xm0xl8kWRdeN5ohnUq1LNOonGvSlf5SQDkHIu3SJCwJxyGqlhc
         XT/DDJOQpKbF9R3Kd0dCbqjydliiIKjJbrRwkhVtG7ZaaoOY8FhrhcxZZby5GPAjSz6j
         yTUg==
X-Gm-Message-State: AOJu0Yx0JckSkhgpOXOWqaGIgj676+oQENwliisw5Amllt738Tu6weGM
	tsxVgAN3lqXxdwLRp45tTM18E7VgY3DbklyoZC/vYsETsKBSdPirm3q5xPSpC6BIPJnZfav92en
	Dk+aUTLNAgKJjcouB1h0ARC9bD0zvb42fYrYr
X-Gm-Gg: AfdE7cntWRwqeQofidiwBeAuQ/Jk4/UKslAQ5bf1yw2uEejO2C6coKASIrRNyDxvXw1
	fttZt6sRZ9MGLfvQrcyWqLv/hhcLTsfKBY8WVmaP/Ff258XAPhzqH0N/byI+OtSU95KCAfKIPkX
	gkIsOWTYfXbxWK5cnIyW5Lp3LkeTZMqCeH5jLRvSEow9YNEzP6DKHPALDI8PEvA62ca1IyGRbgN
	47EWsDmupBscDmjneMy636mk6qR6IkSPgxqRQzk+H9HHKdEM0/n4JP5PPvfTeAQeSWperVf
X-Received: by 2002:a05:620a:1995:b0:930:866d:f86c with SMTP id
 af79cd13be357-930a602ccc1mr2071687285a.34.1784599848719; Mon, 20 Jul 2026
 19:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Edgard Lopes <edgardlv@gmail.com>
Date: Mon, 20 Jul 2026 23:10:37 -0300
X-Gm-Features: AUfX_mwiOqAKRV-cY9D0nH1588VBK4-kRIW_yltAIl6pUV-wQ4jo9CNJwLTXhAQ
Message-ID: <CACUvvBVT=iVA4GjCHOwxdD9R6ukVmdM-mfr0u9NBfua1cBsUNA@mail.gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add ID 0b05:1825 for ASUS QCA ROME adapter
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

The Bluetooth radio of the ASUS combo WiFi/BT card based on QCA6174
(e.g. bundled with ASUS motherboards / PCE-AC55BT) is a QCA ROME
device rebranded under the ASUS vendor ID:

  idVendor=0x0b05, idProduct=0x1825, bcdDevice=0.01
  bDeviceClass=e0 Sub=01 Prot=01 (full speed, MxPS=64)
  Both interfaces Cls=e0(wlcon) Sub=01 Prot=01, driven by btusb

Without the quirk, btusb treats it as a generic adapter and never
loads the QCA rampatch firmware, leaving the device running its bare
ROM firmware. In that state SCO/eSCO audio is broken: the controller
delivers malformed packets which the kernel drops ("Bluetooth: hci0:
corrupted SCO packet"), so HFP/HSP microphone input never works, and
the kernel also logs "unexpected event for opcode 0x2005" during LE
operations.

With this entry the device is set up as QCA ROME:

  Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
  Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome
0x302 build 0x111
  Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin

after which eSCO audio works in both directions with zero errors
(verified with HFP against JBL Live 770NC and other headsets).

The driver_info flags match the sibling QCA6174 entry 0cf3:e300.

Signed-off-by: Edgard Lopes Voos <edgardlv@gmail.com>
---
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -259,6 +259,8 @@
  { USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },

  /* QCA ROME chipset */
+ { USB_DEVICE(0x0b05, 0x1825), .driver_info = BTUSB_QCA_ROME |
+      BTUSB_WIDEBAND_SPEECH },
  { USB_DEVICE(0x0cf3, 0x535b), .driver_info = BTUSB_QCA_ROME |
       BTUSB_WIDEBAND_SPEECH },
  { USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME |
