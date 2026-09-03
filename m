Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E069847ACCA
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455010; cv=none; b=SoyXrWgEBo8cORMWZokSNTAxeR3RO44HgNQpNadQvnXmacCtoctVJSvKQhNf170CZahJkbGgKHHcZ2OeHVXEASkTfSr6RZle6hdd9XiD+gmVIWSHvsI5bGPu3p+3beHzhU8WuZvwEaAS8OfADgKzS9OvFb0i2UeYdoLlzmQEhUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455010; c=relaxed/simple;
	bh=6vLgwFypI9R6E48HnmbFTXCQiSQpFbanDrb/YELuqEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vvws1iwEXTvVQJeu6huUus2b30DyzKqxyZHIoodOYIChWTlRsH/ANwc6Y9C/tnR7axAsR5TPiyzOMpOu2dnhe767lbv0aMtqZ4fRTrxsIodlvDCksaBg3CW+xpMo3+FQSHDR5uy7MP8qUksbmwnt6zRybtt5eVHgUI3ucwYMeGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQYKnSVO; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQYKnSVO"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8588583a7c3so1197957b3.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 10:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788455008; x=1789059808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CstuSRSoRYjDy3SQPB3JE0tK/DdVcQaXoQui8YlYnzY=;
        b=QQYKnSVOlORU22HAtJfuNVl4iQiCljkEKWs/8txAonTMfEjSWpKVbcC1PEJ4X+hCaU
         XZ+MbMr2TtDnJ4Xt0kQX3W45dL09ERr0eilP00Eu+VRb31O5sxiRSw9YX3hZspdInT/v
         x9utrbLEXuB2ucQScMLqbEXH4XH0LS84nZI88VOGP1VBYyB+S4hZ5+Oc7Rxd4NCd1RoX
         d/tX0Gi3dFPtCF3ckZqv/GJ96akyWVrMVvg+6wKydPB3xovIdaxlpBSucPoMBdkUwsFZ
         lKjRMm6tHJ/5Flxdi9A4vj8a41St0A130csA9T8i1YJOoGNBf5kZhSTNDUxYB/F/jbLo
         /zBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788455008; x=1789059808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CstuSRSoRYjDy3SQPB3JE0tK/DdVcQaXoQui8YlYnzY=;
        b=hV/gymP4+ZACf/1m+HnDvblpB5C8etSq8G69OcSMvuyoeuZ6/ftCQVTNEJXc+cYIx9
         hx/Mlb6bzB3O1lfCiWDrD0UyxoqKAEaJHNv2MmePQi4/kJUbIk/BloyZYk+0fnhFREaE
         nBjkcbOY+rozJNLtlpeeeV6r+XXoNf6Uj4pmOJzFvSEmqKUCRLK2pkW0mvb6paso7zO4
         LtCwY9EoO7hb7AxZ7kbqHx0lPH3QBO6jdzzEjO9xlQC7gbxhQck/q+M2nG3H8oWoZK1d
         46TTOUHPxXZabW6ycDJRIJbEzFqfpejfmsL5zF2Z2OHTiUF8n+OOU3x6uL/EKOyrVhNO
         KrzQ==
X-Gm-Message-State: AFuF++lYXA4hXWw4TSBiDwbKpjBiCj4z8QquSurq02HQTHYnZYZI0Ivu
	2gaWaXkubH+qvSvQNceZir8drZrXyxNy+oqD0j36AWj6SJK1ANLfoeD7
X-Gm-Gg: AYBFou1GKNGsm4QQIjsICSMNxbCRhrqgNcBIJGgyHPi5nBa3wecrnMNPxFdEIzw02dT
	L79ycYpUWFw5rlcPtEMk7cXtnzENKihaQYdr8HU6+w2FPqmsGoq/LvrW9MF3r4QSo1cZ+BOyHZI
	YrHDwflqlBzlI8v6PAiXXfuqJLb0sRjSKQr54+QNSei4jc/RzB7OwP+QdHhtLEqjj1IVqfu0jPz
	TwyOqdFH9ITmH+IewLrDCLDiVgjLM653450prKPyXQe4mtsWSSkJLA4HGq8R14izAjdTSUL11Xl
	CunKEVUYD1noH6OGWXZuHaKKvOVodFDjAwbNXZ/S++AB+2wSTj2ZSg8lFAVPCeRu3hJb4ApvNzU
	b2J5HOZcpvnHADcSZu3nWiryAekkvGHgdjGTKbhfKfHm88ILqxYryuBmgCelKdVjLJxukVwKo0R
	qNkwG76i9RQBJcoGCzttiRx2nsnLG3MjH2jKm9RzOUyM5PmgSZsnZu/HhrVpHgCb6jQg==
X-Received: by 2002:a05:690c:6605:b0:845:ddf4:a399 with SMTP id 00721157ae682-8712390b41dmr2299217b3.11.1788455007588;
        Thu, 03 Sep 2026 10:03:27 -0700 (PDT)
Received: from Beast ([2600:1702:8265:324f:c600:425a:f388:aa8b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c1784382esm44343537b3.25.2026.09.03.10.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 10:03:26 -0700 (PDT)
From: Aritra Das <aritra.rohit2003@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aritra Das <aritra.rohit2003@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add USB ID 13d3:3556 for RTL8821CE
Date: Thu,  3 Sep 2026 10:03:22 -0700
Message-ID: <20260903170322.47004-1-aritra.rohit2003@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The onboard Realtek RTL8821CE combo card on the ASUS PRIME B550-PLUS
AC-HES presents its Bluetooth function as USB ID 13d3:3556. This ID is
missing from quirks_table, so btusb matches the device only through the
generic Bluetooth class entry in btusb_table and driver_info stays zero.
BTUSB_REALTEK is therefore never set, btrtl never runs, and the
controller keeps executing its on-chip ROM firmware instead of loading
rtl_bt/rtl8821c_fw.bin and rtl_bt/rtl8821c_config.bin.

In that state BLE HID peripherals are unusable. A HHKB Hybrid keyboard
pairs and enumerates as a HID device, then the link drops within 10-30
seconds, repeatedly. The same keyboard is stable on the same host under
other operating systems.

Adding the ID lets btusb run the Realtek setup path:

  Bluetooth: hci0: RTL: examining hci_ver=08 hci_rev=000c lmp_ver=08 lmp_subver=8821
  Bluetooth: hci0: RTL: rom_version status=0 version=1
  Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_fw.bin
  Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_config.bin
  Bluetooth: hci0: RTL: cfg_sz 10, total sz 34926
  Bluetooth: hci0: RTL: fw version 0x75b8f098

With the firmware loaded the same keyboard has stayed connected for over
11 hours without a single drop.

Device descriptor:

T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=02 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3556 Rev=01.10
S:  Manufacturer=Realtek 
S:  Product=Bluetooth Radio 
S:  SerialNumber=00e04c000001
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms

Signed-off-by: Aritra Das <aritra.rohit2003@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 03039ce..0424898 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -511,6 +511,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3533), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3556), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3558), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
base-commit: 6696072ffe07205255cf83621a95a1aa2f9f6e62
