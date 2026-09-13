Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCC83AAF45
	for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 06:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789281496; cv=none; b=Yjgcp7pwsT8X4ifC8sTHvtXYojtSHGGoQHRiLmGwxE5e/LdjkpKSI/3thFvjL8+ESimHD4Ana1eaP/hgTCz5cQF8Ze0WqaNOSyG1YjMWCbO+/LPT5CoItTfo8A64AdfEETn33LTFpLe0VqLZzyGB1RtRqmL9QQZtO52QakH9/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789281496; c=relaxed/simple;
	bh=XkJcif5dcBzpvsmXwkcxaAEjy4wyYzdqijNgi9jRcMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sVPaJbGrcRNQ63ufB76/wGcPixdncpgPiFN3ARxWOaKW/HTTUfR2nLSQ8nxlW4vhphAp2mOQ4hgMJnGu0NBmJhZUqdIQFFqFpnvyudXxwM78X3Yc32gNKw20SGtzJX+s6xQeZwGeZ2952svmH1xcXnwxA9NjMVyWgeCTQBQNiQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kckRwG4G; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kckRwG4G"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so5096655e9.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 23:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789281492; x=1789886292; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UdHQHlHk9UsHBXmZU/z5eK4ERMmFW5VRKPVR0HxzUTE=;
        b=kckRwG4GdOIpFVMrZqHoZpCfI5KKgQerFSgt0PvPcTZEzb8y5/Nd8VWK0XX+Bnubqr
         a9UMAAEK71OMJVM5RBAAwjKnX0vvqOfj2vWtxnpT1+orclRWbCJOVXnztSG/2AvZLOVJ
         i/bSlzsOCxdai8zjRp2UsM/YaHqiNKrYAuELAKLLbLG/x/rftR4DA4T7MwbExz2ozbQy
         WtxqTrtjt6T4GnrffTldEK/2UZ0T/NZBv+wISLjPDIPVzDMOE0WP+/2kpukyFRi1ttMf
         XrxAlYxTn72WpCTFPobD4E1xcDEiPA3taJQ77IOjrh0XeQ7s1JYEsQCn++ayJjDIqi+D
         D/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789281492; x=1789886292;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UdHQHlHk9UsHBXmZU/z5eK4ERMmFW5VRKPVR0HxzUTE=;
        b=iJ+cX2zp8CHxHUkZt94JMBBSlIfHxYB5bo65wFxbmsKadQSDGOwqDvM8V6J4IVix4K
         gA15MiSLxCl97HSgspaC7+SbTWlrF3s9saHIEdnGpgVRInOK6wLs6xqC6gXxeJLSC0yz
         zJkN86KYeunQFiw6ICprFkw1somHa7mW77lu+s4mplYAHx2ZWeYu+y0gnPYU+56pWizT
         n+egsExXYp3jUFlPDhLz2aBvnxDZflY9RDRy3423w2L2WRS8kKm8vUZKNo9fikDBAHpo
         O/ihjI1wjHyDgWDptG/PiaX2apAiXKNTl44qWRaxfqOnQAvhr3xS0wS3yA+sqreoz7CB
         u8Xg==
X-Gm-Message-State: AFuF++k8vyv3wqJUzkAAY8Z8Jm4I17NrVs+n7LT6GQFpJAaVdw4nAjSb
	9zuN42tBiHDiRcx5kEqGBdF2Pn4xcAypykuVVT40atygPpQq6PQNAqZuO368u3lvst1fjg==
X-Gm-Gg: AYBFou2wl4MQWvDYp7ixajn9BdK68vwA11XEMulnU6ADOSGJDEtbhUn2Ujv8FRYmh39
	BoPRt6BbOSwQfhHg1N/oYUVFdSKxU1H5TaHFehp9Lu7sNAEn2cdAjr1MDODAXGN0t2Xoj+dB1DS
	z83uOXh3DWrFdNCyWadbmCGad8z78bOyV3Zl6wda28qPsd0+WlIUjdJZvrw+T70doZFLD6BqjN6
	Qb5bjLRbLoGebmgujZ+6m2D48ZRULSLsJeGVr2TkuV0HH3oYhrY5fN7ug6dfnHNIe9y1UgC+tUU
	UvbY2e9ebsh1YBG0wO4zJKD39x7IPEg+S3PpJ4VtK/cBTMRSJdQ1yHfNH/tZTtYsGCIR7qIgz49
	aFDKQ1LdV3TJw7Z6F5E8vzifRiVeHQKRLQ2ejBCFy2G6SQjOOesQYRfttV/EzJZplxMi2lJEDTs
	9GzsaxGbBiVCSofjPLb0c5RC1sv6MbNNrGhreUYmklmije6mvxA9MtkpnNL3xVydQDvb0ljZSIt
	13q
X-Received: by 2002:a05:600c:c4a4:b0:49c:fa21:1c86 with SMTP id 5b1f17b1804b1-49e6cc11515mr48755455e9.27.1789281491881;
        Sat, 12 Sep 2026 23:38:11 -0700 (PDT)
Received: from [192.168.5.54] ([149.102.27.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ad0614sm231263885e9.10.2026.09.12.23.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 23:38:11 -0700 (PDT)
From: Martin Luker-Brown <mlukerbrown@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2] Bluetooth: btusb: Add USB ID 13d3:3626 for RTL8851BE
Date: Sun, 13 Sep 2026 07:38:10 +0100
Message-ID: <178928149096.19047.17192117267904511764@gmail.com>
In-Reply-To: <178924584937.116572.13159457162680472249@gmail.com>
References: <178924584937.116572.13159457162680472249@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Teach btusb to recognize another IMC Networks / Realtek RTL8851BE
Bluetooth radio variant.

Without BTUSB_REALTEK, the device enumerates and HCI comes up, but
btrtl never loads rtl8851bu_fw.bin, so discovery finds no devices.

/sys/kernel/debug/usb/devices reports for this device:

T:  Bus=01 Lev=01 Prnt=01 Port=10 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3626 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms

Tested on Dell Precision 7820 (Fedora 44, kernel 7.2.4) with the
combo RTL8851BE Wi-Fi/BT card. After the quirk, dmesg shows:

  Bluetooth: hci0: RTL: examining hci_ver=0c hci_rev=000b
  lmp_ver=0c lmp_subver=8851
  Bluetooth: hci0: RTL: loading rtl_bt/rtl8851bu_fw.bin
  Bluetooth: hci0: RTL: fw version 0x048ad230

and LE discovery/pairing works (Logitech M720 Triathlon).

Signed-off-by: Martin Luker-Brown <mlukerbrown@gmail.com>

v2: Wrap long dmesg line in the commit message so checkpatch/gitlint
    stay within the 75/80 character limits.

---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 83d122de5..91e739c96 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -549,6 +549,7 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0bda, 0xb850), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3600), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3601), .driver_info = BTUSB_REALTEK },
+	{ USB_DEVICE(0x13d3, 0x3626), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x0489, 0xe112), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
-- 
2.55.0

