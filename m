Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B9737AA97
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376400; cv=none; b=P/y9d04nIA/ndOzILbxxlHHfRjzrS/HyxYv7fyTtWD7jMQP324Gz4ifaiqztw8OpYmSH+oX884fwDWVWonGrUtqbdpE+l0e9bKexqQF7ab1RC2oudfO1ExsSaAG0BLziWqQKhN46rUBmpZ483vK3Wr+sfarfs9qCNVj92m425E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376400; c=relaxed/simple;
	bh=hh2uBalSQ/PIRlrrvQVaeqgCaFk8ZMHgJhXGIuYAE7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbnycWEwYYTPsa6Q3iAilpCjKEvJ38twO45WtyYHnMraJkC2nPyOYSJLMOUuODNoU9u/Vfu+SlPtLRF6AXaxexuDwImKNrj7DcFqENfR+OzUMjDT3589/U5iNHcSqkDCjOQE/nw3rjhiOo2E8OuLqON2G3Rgb4slzaSKvjQWrkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpPANLe9; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpPANLe9"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5ad536cd0c6so2234835e87.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 01:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376397; x=1782981197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBM+2W/bupZP++Px/FdVPXBLk2VrJnzXIwmQOwThRz8=;
        b=hpPANLe9bR1a11+yCd2NlFBqz1U3o6+k6YdsY7wSJF2NAhWQVB3ct07DeIkuFOGHu3
         OBUUU6wbEAttk9Em73vI8V4A8vDi17aNBStCvsZmdlBd50oTOc7tKrMJv8aGuwwnEq1J
         mbG+RthaOxzUvs6o2Vdqp2n3z4/iSZa5c7Eh5p0XO3v2T+85mtM9tyfu3usqgLUC5yvk
         E195+SqcBHeONM6glmUauFscK5PJABKlNFWokrzbPu2hanwFVdI/o4tMoR+4JCS8Q42x
         UDY6HheGfaqfLuJa0lJh2FFYaIwI25a8fwUY/DCAbgHXWUBPT9xQIZG0yqTCeLuDChdX
         ZS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376397; x=1782981197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hBM+2W/bupZP++Px/FdVPXBLk2VrJnzXIwmQOwThRz8=;
        b=S5XN86Kbze01uupte3x9HmS169qXXtDpySK3x1wSKFD0LoFlHvE2JyIy0fN2EksWUF
         IN+KH9gtAGgeEQ6+VYZTR0GC9bJbK/4utvZnoq1HtH+aRT/D+acxX0tpTWJAtkgAp0uX
         2WF+IH8oM4+pb4tWRg+gYHptkLkRWU6Maajx8UKOQv594hYzg03LPmEca0G9Qd79pwtW
         65VO7KR+e5KNxY8kJF89aHs6vQg/6EdKb4+nDulW84491kQOMai8cRainWfcuVl8pnXk
         7GRgPY1XMzAWD9i5kbp1Inh7pkZcWgsku1LmnrH5B4RTLua7hT+OJMJNVAosiyRq6OAs
         ULVA==
X-Gm-Message-State: AOJu0YziKICQUKBtEgHxBIu6MlAG4z4PtJjIXHNEHDoBgLYt/Ze3ImwU
	SdjTWzHDoQyvSsavebkRQ1As3Qbld/s5eU0HZje8r2y8UTqG6A334XD5
X-Gm-Gg: AfdE7cn6+EbT7etbGHkE7xZWF/H0WBDoUumqHGxU4wMLOZQGxS7vnGOO4H5Kk9Cy/UR
	N1EFZe/rzLwETeombRecj1qYL3qqughcM6laJidfTh0vpSBDG1+s98ESvXZ9L9cC7fmodQZA/Zm
	akFvADCdQfkeg1hJ9Zpk4UqUY+1dsNphlhYhLpUH2f/fx29isNtlyIBIOeSIEN1h6DuOBwGgQ6+
	wt+lA4UC9tSlDS9YtlddRu7sHUPzTQHtWjsPPV3HEwt5uejFl0aHor62J2WSmyoicCSg9kCEXLV
	M2OW8QQZCEaMxNayyyx9E0h/7bkIC5i5MDHLZOXN6Hnj/94+MxUEad5tBNJ0W8VqqFPzDpf3uFm
	TTe9DlJdJu3WNRMYVl8ZbS5GRhDOlqoNC4Ro25HEm54rSeG75FEPXb7bbfMlZPAKYnbMlsqJxVZ
	p92deghgA528ez6Mg=
X-Received: by 2002:a05:6512:6090:b0:5ad:5346:87ac with SMTP id 2adb3069b0e04-5aea1f3c251mr479800e87.13.1782376397185;
        Thu, 25 Jun 2026 01:33:17 -0700 (PDT)
Received: from KonecFunkcii ([121.127.33.175])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999b156f18sm40009711fa.24.2026.06.25.01.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:33:16 -0700 (PDT)
From: Gustavo Evgucci <monesss315@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Gustavo Evgucci <monesss315@gmail.com>
Subject: [PATCH v2] Bluetooth: btusb: Add USB ID 13d3:3625 for MediaTek MT7922
Date: Thu, 25 Jun 2026 11:32:30 +0300
Message-ID: <20260625083230.300651-1-monesss315@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623114937.6385-1-monesss315@gmail.com>
References: <20260623114937.6385-1-monesss315@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IMC Networks MT7922 Bluetooth adapter with USB ID 13d3:3625 is not
recognized as a MediaTek device because it is missing from the btusb
device ID table. As a result, btmtk firmware loading is never triggered
and the HCI reset command times out with -ETIMEDOUT.

Add the device with BTUSB_MEDIATEK | BTUSB_WIDEBAND_SPEECH flags,
consistent with the neighboring 13d3:3627, 13d3:3628 and 13d3:3630
entries which use the same chip.

Tested on: MediaTek MT7922 (Wi-Fi 6E combo card, IMC Networks BT USB
interface), kernel 7.0.11-arch1-1.

/sys/kernel/debug/usb/devices:

T:  Bus=01 Lev=01 Prnt=01 Port=12 Cnt=03 Dev#=  4 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3625 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:* If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Signed-off-by: Gustavo Evgucci <monesss315@gmail.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---

Notes:
    v2:
    - Add /sys/kernel/debug/usb/devices output to the commit message (Paul Menzel)
    - Add Reviewed-by: Paul Menzel
    - Resend to all maintainers from scripts/get_maintainer.pl

 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7f14ce9..f829203 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -798,6 +798,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3613), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3625), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3627), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3628), .driver_info = BTUSB_MEDIATEK |
-- 
2.54.0

