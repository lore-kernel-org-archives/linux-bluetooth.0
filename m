Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0494E2C029F
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777489811; cv=none; b=BfNpLLuchVdDe5UoDHZ9UbAuK7DlDo2MsEDYGC9I/UOgU03Zo+0RgX1hkQZZlDz4cyZqs4PgO8W48uCQcHBrCOUoogWjI8dMKNIWOxp8nNKQAXyOQaGtouFjgi1VIx7vkgh86AzraL2W/WJmmhRewIWvntJG1aXW0r/TEDPtC1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777489811; c=relaxed/simple;
	bh=/12OfPjtGnHCRUdpVBlJkOwbmkf00+adHg7a67xS//g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QEn0cGa4n3HZg3tZWU7WezWO/CDvesq3x5GnIHuXCVGpD2+QxyRhMuJqTXV+A09bRlCP0MWbySzxxJtirxuc/3dPlWvotc55FCIyVkQBccFwiDDVy7fL0Bm5MB+j8xPfQqgoTmeEloiKgDEuvMkCvi3b9qW2sV+PSWufIqpMO90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZLuc/LT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZLuc/LT"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35fc2b18363so96376a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 12:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777489809; x=1778094609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C6ZM2qE0hA6JseG05gX2C0H7luPFP12wgryLB7E9nZM=;
        b=BZLuc/LTTOIRcbGsWiwe7bpoS4a8nvRATN5F16yrVz/ndkZ3BBDno39e8DLySbzo4T
         aa4Ohb7EF0nMDUrU9hdWwj1acZ+Fx3X9Xz8TYdHmxQ2xfqDkfr2lrrOedfpNiDmVJ/rA
         wjyFG+6W+WdqWUMd7ouv8PVJLZNoNIe5Apj/UhvRU2r2h0gfmxXoigoBBgmHImLeT+5s
         myss9QrYvdqDW+ZAatRB3sCUOTcuJOHewENU+PyxL9tn+bczYsowgOARDAv0kcLCxTyK
         zfw2kNseIIggBshY3wEc5yHRUU0Aga1hzxfi62baRhZ5rgz0kEQAr2eXuBVzvzDJzrrS
         vrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777489809; x=1778094609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6ZM2qE0hA6JseG05gX2C0H7luPFP12wgryLB7E9nZM=;
        b=GC+t+6XrOmmZ7UKbosmPL7rOraLU+X0B7pO5ugivD0+//d4BhRQ/7m6/MuSDaeGn29
         L6srCXX+DQSJ+ExliiZ2gXt0Zr8w5XT+s1akmO7ib6Vn18CymnwfQXBmrE7O84aIpzt3
         FKHZ2Opx0M4+MHY56JdS1MzvzV/PtK6qBuB/ZlI2wvWIuS1yS/CGPKrJH1bzBEeeBojU
         et8Gvt1fCX5WPSmFAcSgslh7mpDs2xMmIrkT4atwkMVb9LsI92InzlARTPRS6OIgyy8+
         +HWp5YQeDzYJH+Dxep78Kd1lKAa9EPX19/w0NiiTON62wQ+l/PP8Vg6HFfy2rI5uqmd6
         E0Bg==
X-Gm-Message-State: AOJu0YzNcd74Loq3vFky4WIU56z5DcnHcpmyn4BeMNpfNQqu7SPWJ5NN
	wJu0aRf5T+owcyr3widChseUqCBE58idXuBWccJtrzguKpYfhqJIeXbuZ4SfxxJo
X-Gm-Gg: AeBDieshN5ITRX+N/CaA7MvHGg/69gtZH5kMUechvCiEq4ViyMd6KPgTX7xjmfRyzWS
	/5t6day5gEr8eJudti+TWDIOa5JXbFpWo/MHCKmbDuCjxkpJ1NfrlSUrOyc52Fz3ORgoCJNpe4A
	coYdJa5tsKd+IjrZlHDkeejkMTrfhIY+9JY/bI/jQxCOsULX4sfCYdmjV5MR40PJDsRZJ3APnEz
	cNthCu5c84vvnSSiyVFZWpS6lV4aADUZPG3pA484go+AqcohH01o0YEwIo5mTua3QIJ8bHNCLRw
	3lGYLIOXmH2pXy4OAejYx28/KBaMm6q+Av7QLeHp+RTXAIo2e9mT8Dy9oDK1Qh4m9ypc/zmu0Cb
	9oRv9Dyrfz3jHJeKLrY6DA9LuEz4bwEkYiIgoaoDpcgyyxKw3P8BXasZVXyVwYshlBiyLfIC3xD
	jUu05TJbyGwH4CzcxzP2yJdwlN0rbVoK3ZeXpJRXJAYEtESC+MRms3m9ZNIRqaOfs=
X-Received: by 2002:a17:90a:e7ce:b0:35f:b306:5d47 with SMTP id 98e67ed59e1d1-36491ff60dcmr9226601a91.1.1777489808831;
        Wed, 29 Apr 2026 12:10:08 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-364be00b168sm339871a91.12.2026.04.29.12.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 12:10:08 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-bluetooth@vger.kernel.org,
	max.chou@realtek.com,
	hildawu@realtek.com
Cc: pkshih@realtek.com
Subject: bluetooth hci0: Direct firmware load for rtl_bt/rtl8761a_config.bin failed with error -2
Date: Thu, 30 Apr 2026 03:10:04 +0800
Message-ID: <20260429191004.11965-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Recently I got an RTL8812AEBT card which is a WiFi5 + BT4.0 device.
Bluetooth is working fine but I see the warning below in dmesg. It seems
the config file rtl_bt/rtl8761a_config.bin is missing, not sure if this 
should be fixed or not.

$ dmesg
[  171.900777] Bluetooth: Core ver 2.22
[  171.900818] NET: Registered PF_BLUETOOTH protocol family
[  171.900820] Bluetooth: HCI device and connection manager initialized
[  171.900825] Bluetooth: HCI socket layer initialized
[  171.900827] Bluetooth: L2CAP socket layer initialized
[  171.900831] Bluetooth: SCO socket layer initialized
[  171.934237] usbcore: registered new interface driver btusb
[  171.941534] Bluetooth: hci0: RTL: examining hci_ver=06 hci_rev=000a lmp_ver=06 lmp_subver=8761
[  171.943635] Bluetooth: hci0: RTL: rom_version status=0 version=3
[  171.945657] Bluetooth: hci0: RTL: btrtl_initialize: key id 0
[  171.945664] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761a_fw.bin
[  171.949630] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761a_config.bin
[  171.949697] bluetooth hci0: Direct firmware load for rtl_bt/rtl8761a_config.bin failed with error -2
[  171.949712] Bluetooth: hci0: RTL: cfg_sz -2, total sz 22640
[  172.020303] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[  172.020309] Bluetooth: BNEP filters: protocol multicast
[  172.020314] Bluetooth: BNEP socket layer initialized
[  172.524780] Bluetooth: hci0: RTL: fw version 0x0e3e4380
[  172.664330] Bluetooth: MGMT ver 1.22
[  172.683252] NET: Registered PF_ALG protocol family
[  172.744110] Bluetooth: RFCOMM TTY layer initialized
[  172.744124] Bluetooth: RFCOMM socket layer initialized
[  172.744136] Bluetooth: RFCOMM ver 1.11

$ sudo lsusb -v -d 0bda:b761
Bus 003 Device 004: ID 0bda:b761 Realtek Semiconductor Corp. Bluetooth Radio
Negotiated speed: Full Speed (12Mbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0bda Realtek Semiconductor Corp.
  idProduct          0xb761 Bluetooth Radio
  bcdDevice            2.00
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
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength       0x000c
  bNumDeviceCaps          1
  USB 2.0 Extension Device Capability:
    bLength                 7
    bDescriptorType        16
    bDevCapabilityType      2
    bmAttributes   0x00000002
      HIRD Link Power Management (LPM) Supported
Device Status:     0x0001
  Self Powered

$ sudo cat /sys/kernel/debug/usb/devices
T:  Bus=03 Lev=01 Prnt=01 Port=04 Cnt=03 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 2.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=b761 Rev= 2.00
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
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

