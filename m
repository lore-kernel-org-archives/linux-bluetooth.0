Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=87.248.110.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618276;
	b=uzreGCcIyri5VHV6L0kde+NwUTOrTk6Isa/GG+owTTlcx1e6sSHvK39s8rkWEZlMCvWw
	 Jr9TpuDE4A/V+sW9K7EXdt3B1CmoX8nqx0HxPyFGju2xS4pw9NmYK6MW0qGt1MJ51xbMx
	 Aqgbb37GU7oZZ0EbHuRIN24EPxRq4nL47Ny4xo+454YXz+20XlLkTi6WJif5vu4ir3aEL
	 SYPD4tWZLLZHRsschpDNV30Afx2dn5SClBsJ2NycTdE5xWBtIsxiglYIMii+5Wtp2K+Cs
	 74YESV7A5iOsSR+a1Kac+aenmegOVeiA4g9dNk/PVNKnThMxb0LdwnBzj3M0jMbiuWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618276;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Date:From:Subject:To:Message-Id:
	 References:X-Mailer:MIME-Version:Content-Type;
	bh=9CYaoxSjlHJ+FvXfoHxW+enGH3xd4ZAKRU72YxVRmJA=;
	b=KNeMBoFARHggRkcW20kFP19mHC1B3xQ1hlYA0Qya2mHz4hNpxgkjQjg6rIAEpzmdLTHz
	 Ii0ePcLuMBvhg71ee4bosngQDDo2Fem7BL48SPeAPmoIacQu+qeOElBY/GS2XBmNZD2gM
	 fsmlqvs1QCNus8+h/lVyt1TMmxkfNfwcdMBokwBRSE4levBIcXGlZVg63AqkVCIQzYgV2
	 lWnVuamyd4wzeHW9+kZPLPW5zsWlLMWJ/Gt0epLq9QuZtHEcfjMnMCuMiM0KZ82UGMMEh
	 tJfL/LfIdCeQtapexW83hwhROXpxAak1hb0DGreLIWHCQL/sgPAu90nLSRNKR4Vh/Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.de;
	spf=pass smtp.mailfrom=yahoo.de;
	dkim=pass header.d=yahoo.de header.i=@yahoo.de header.a=rsa-sha256 header.s=s2048 header.b=ZjOuG2G2;
	arc=none smtp.remote-ip=87.248.110.83
Received: from sonic302-20.consmr.mail.ir2.yahoo.com (sonic302-20.consmr.mail.ir2.yahoo.com [87.248.110.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73578606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 14:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73578606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.de header.i=@yahoo.de header.a=rsa-sha256 header.s=s2048 header.b=ZjOuG2G2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s2048; t=1795618272; bh=9CYaoxSjlHJ+FvXfoHxW+enGH3xd4ZAKRU72YxVRmJA=; h=Date:From:Subject:To:References:Content-Type:From:Subject:Reply-To:Content-Type; b=ZjOuG2G2bOjeu897H2JPap/m3HWoZ43qvYheRFn2DYBUhPysonoOL3eK6q7AfZSEaJ2tPM2hwed4UD92XO5ajT5pGUHn8iBFtXbN+/9eYWQ6S/QbhrDIupVnZsyBn2VlzyLPhkbEaMzw6LkhWIxQQpPlLp/adX1JCljRHuy2DirHUZqNGFzVMiTlxqn1uNmBshwv+RpQUjwQJ/Ouqs/aFXyz2Igojm1e+qbZj2yj9P7UFQWpid3e78XTsDeEtqzCKxZ5SC9zu2h2qO0s+WDsoNl5xKCzy/7nRltNsg9ah0QIMQBl+O1QzcB7uZ3JbEZptddHhilFpo4svy0Y1qbzkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1795618272; bh=aFRnzSEbGW6w4xbET7bp02mAAmBKwV/QVa69amk+VeM=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=CzSySks1y5QSe1m0YTYWq0I+631k1X3YdzN399UdewVIRfn2DQ5TjB5adYatAcQbF3bT3qx2kO/vQuJ8cKhQOK8RcCG9BQkTaGUX6SnOX7LkOTZ9KevqYU1ul8EwOdZ/N+bBJhvMrab+7cRQ1nZPkLydUUQ8wZiJ3TlvxB2osoJXZPu1er9Ja5w+47i0hvwAJHe6w89apgMGx1TINKs9OBE6hVGYsyBlbRSk7S0DOny4jStQ2X2okclDkXtQH3xBVmTKKbuMX0IoVKguyPy0ahcx3TO80rhDnW0cGZ8rG8zYXyxRM6AVgSLdPmxxgoxj23OytRNybElj8iuHAsSgew==
X-YMail-OSG: MqOe1wEVM1k5aZ4udFSBqnvyV5OiB9X8jcRw8H4xgmXwJZHELr4CVHFLvZxIdaA
 u5MhoXJkzSlhM35klcg9n9VU2ED_EuEUqhdvXI7uMEXMEK5zcuSwfMm0ccQAxrkLHA_ZCaXhy0em
 2gyhsyALhIpzyK3CH0Sq8d0AOZQpntvzU6o9vd_BTw97YiSfEOVP7_ZzyeZxjK5LaKqVjoGJ9999
 3qn7r4oJZMHWnrfFRDPrY9JQToM6tYlHNqcDFmPV8q9UaQGtvxi_Us59t_20OooKyAaO7VuAbneK
 dLYb6D7I9vJUSMczz4j5zX5s14prjcuWO5GqUcJlNxEKto9AJSu9I36RDuMr93GP3h8NqMM2dVSf
 S1FEnMn4LQGUUmLo6pa1fGeBk4w6B8dEvyNSNqzs1fH7J314kQ3rqbtD.YT3YN7Y8RLWE4q7ReYb
 ZAzLmjJvswVMudpiCVQcq3o.Zkhy_bATGz04is9Eo3pPAyKAnHzrB3GkA_jbL1cjlkDXwAC5CRSA
 D9CSB9pPFg12tvHSw4T5K_gawst3SoMBzaZr5WYIB_RTHcPhT4EXC6Ynp8WlTxtuy4gKEEE9.t9j
 fQo4Y7yIwgg1DUBjp.3V7dRqiqnGx.edh_ekAgETuKnFwVV1H_q6q3aLKFWgQn0aCAwIGAkfucFn
 4aiFelsWm6mPqiMjws5FWULL1IUT6UXiqt1X3KEZaN5konT7kWNma3.pthDvpKDv53t4Euknae43
 t6XowS1fUIN.M0dBdQz4l7Oz86uu21E5VU3Uxj4Nr8.2DWsCbtsKZVofsrBsrLG4hHUyCDDSI7xv
 OtORLaSerDli3LNYjVl6esqzply0kXoP7qlE6XAh7AhJ0WTo4nbfA.9fYygOtIfX1SNY7yhju0pd
 dNAqVuFf6mupSpwaVgsFRqGIl0zLy8SXAK5521A92dpYPHx7Ahe5XiCb.RN08AnN5vV.p.OOPhO3
 CGecpQvc1Qn9eKLEXTtNazNIlSW_7qNmNa2bD2fKik3Gyfvn48j.mn12QgrcIMVejphyVMr7q.90
 CN9zm31wvzQoDcmvQYXYTdavZJi2xcP3jSqSMOcdP.46de99jCD..qIQuk1tbAzk3eW5vFCDtgcE
 CZmJ8bJK_GkxuxCq7OKRRmg9IDuOWbcJ.Ho.AGbVNCgUwjTIe034IkA8MuDsLUsSTpkaZBTmJqP7
 Dz_E.whX7wUiviAVdIHys1tKeke8N8bydeXL1M_9Q_5NaJyYRzn_IGAl_cCxB.tqFCExjnwDsj3t
 8fGt9j..kVSD1YtTGwsxLSzm0qACRHUdQ68Cp1c6mC3pYM9Lh1U7u4tUAHzew4XHdc1lz9kEPUII
 T1hM814Ysk9CHh9c1Qq1npI43oMHAwKdZhYPIhiUuGoJDtJ7Fb0UKQsVCY1Qp2WwnUUzDjoeJiKG
 lcK5LcYChb5wgWYwXMxSNqooiWmCv8CMNqA8jq1HAZxsgpx9ZdjFwuBoMIVxj5atnSWIomWGq.f_
 aLy3sBoujD0D_iIz4cZm0wfuqxWKUzk57D2M4eY4_1p77OWJHwgnWL3JoGJ3HXXLlowGyUfitgQx
 50ije6L6HH7NGFrMW6HUNXgZD81ttWX4trCtyDSoasEjMLb7F2_.3ZV1OlXpe9Dnqwb96aQV4o4l
 g7FshU0V8117OTFEU2iB3.ac.F5mnb7jiukltc41fZ2pSQzje2FMUDgTNyjoe_3jXmmdFxPxJPAR
 F0Q3GCeeKaJSGE85.QdQ9VSctgTt6ay1kWHq68h_I2sS.LNCRTEnHZJPdcSV3UtTyBJfJ3WEks1L
 kOZRmB41xhXdmItD3Hg.yo9EJPyKgq8NU90u7BSWVZdbW6RFxZOptSHZnDlmFEIyV72XBXoDjHl6
 CRml00HfsXapgArhceQRfJHBN0wrck_5HkAP2iEy0fvOBtAh0mO7DaGyah2zs15cWCWj42n8j1m5
 h.NGdSDU2bZNm4WuLIb3i9cfv_FHbseqb9v7QZ_axNk0z5GQCEyrh7MyDTZF4jqif00rWgzbxcUB
 hf6I3M65f6Q_QBPBG5dS14ogzDo.0TyEZ6jQSnaRJ9Hds0Jfpr3Q_lj6EBeNt7kyrTumt_.q8DwZ
 5caFl9UjKDJBag1MIy7LIj7_6Drx4PuImmiMyNuebdKCwDAv2rWZnosRZly8RvkeDyNgsw5UTFmi
 LLO1zVHAhZSESE5vGPpwH_iEyF2qpwW3gurdw2N8d1gjFAs29dAQ2tedyVBXsj0U.ds0E.L1SmlK
 lVdr1IpQ8dUP6Xn7kp_Jn4qIOAlIMmaGXYeQOKJFbQUADK0I-
X-Sonic-MF: <liomelfreenet@yahoo.de>
X-Sonic-ID: 980bb0a4-4f5e-46ca-8449-7db3c6f334f2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Wed, 25 Nov 2026 14:51:12 +0000
Received: by hermes--production-ir2-7c4859dc89-4b5bc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fcd8a5f6908677769006221981b6c025;
          Wed, 25 Nov 2026 14:51:09 +0000 (UTC)
Date: Fri, 20 Nov 2026 22:15:52 +0100
From: liom <liomelfreenet@yahoo.de>
Subject: btusb/btrtl: Realtek RTL8761B USB (0bda:a728) stuck in reset loop
 after reboot ("command 0xfc61 tx timeout"), only replug recovers
To: linux-bluetooth@vger.kernel.org
Message-Id: <GEKTOT.TVVWLWVXU3XC3@yahoo.de>
References: <AN2TOT.3MREKCXKFUKD3@yahoo.de>
X-Mailer: geary/46.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed




Summary
-------
After a reboot, a Realtek USB Bluetooth adapter (0bda:a728, identified 
by btrtl
as RTL8761B, lmp_subver=8761) does not respond to the first command 
(0xfc61).
btusb resets the device in an endless loop. Bluetooth is unusable until 
the
adapter is physically unplugged and replugged. After replugging, 
firmware
loads normally and the adapter works.
The problem started after upgrading from Ubuntu 22.04 to Ubuntu 26.

Environment
-----------
- Ubuntu 26 (upgraded from 22.04)
- Kernels tested, same behaviour: 7.0.0-43-generic (Ubuntu) and
  7.3.4-070304-generic (mainline build)
- bluez 5.85-4ubuntu0.4
- linux-firmware 20260319.git217ca6e4
- Adapter: Realtek "Bluetooth 5.4 Radio", USB ID 0bda:a728, bcdDevice 
2.00

Symptoms
--------
Immediately after loading btusb (or after reboot), the log repeats about
every 2-3 seconds:

  Bluetooth: hci0: command 0xfc61 tx timeout
  Bluetooth: hci0: RTL: Failed to generate devcoredump
  Bluetooth: hci0: Resetting usb device.
  Bluetooth: hci0: RTL: RTL: Read reg16 failed (-110)
  usb 3-4: reset full-speed USB device number 4 using xhci_hcd

In this state "bluetoothctl" reports "No default controller available".
No "loading rtl_bt/..." line appears before the first timeout.

After physically replugging, the log shows normal initialisation:

  Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b lmp_ver=0a 
lmp_subver=8761
  Bluetooth: hci0: RTL: rom_version status=0 version=1
  Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
  Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
  Bluetooth: hci0: RTL: fw version 0xdfc6d922

Reproducibility
---------------
Occurs after every reboot. Not observed during normal operation.

What was tried (no effect)
--------------------------
- Different kernels: 7.0.0-43-generic and 7.3.4-070304-generic
- modprobe -r btusb && modprobe btusb
- Unbind/bind of the xHCI controller (0000:0b:00.3)
- Different USB port on a different xHCI controller (bus 1 instead of 
bus 3):
  same behaviour
- uhubctl: no compatible hub (no per-port power switching on this port)
- rfkill: not blocked (soft/hard: no)
- Power settings adjusted

Not yet tested
--------------
- Kernel 6.8.0-147-generic (still installed)
- The adapter on another computer
- Shutdown/power-on instead of reboot
- Whether it worked on 22.04 with the same adapter: it did work before
  the upgrade (reported by the user, not verified against older logs)

Attachments
-----------

Bluetooth: hci0: command 0xfc61 tx timeout
Bluetooth: hci0: RTL: Failed to generate devcoredump
Bluetooth: hci0: Resetting usb device.
Bluetooth: hci0: RTL: RTL: Read reg16 failed (-110)



Bus 001 Device 004: ID 0bda:a728 Realtek Semiconductor Corp. Bluetooth 
5.4 Radio
Couldn't open device, some information will be missing
Negotiated speed: Full Speed (12Mbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0bda Realtek Semiconductor Corp.
  idProduct          0xa728 Bluetooth 5.4 Radio
  bcdDevice            2.00
  iManufacturer           1 Realtek
  iProduct                2 Bluetooth 5.4 Radio
  iSerial                 3 00E04C239987
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
      iInterface              4
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
      iInterface              4
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
      iInterface              4
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
      iInterface              4
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
      iInterface              4
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
      iInterface              4
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
      iInterface              4
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
        bInterval

/:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/9p, 480M
    |__ Port 002: Dev 002, If 0, Class=Mass Storage, Driver=uas, 480M
    |__ Port 003: Dev 004, If 0, Class=Wireless, Driver=btusb, 12M
    |__ Port 003: Dev 004, If 1, Class=Wireless, Driver=btusb, 12M
/:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/3p, 
10000M
/:  Bus 003.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/4p, 480M
    |__ Port 001: Dev 002, If 0, Class=Human Interface Device, 
Driver=usbhid, 12M
    |__ Port 001: Dev 002, If 1, Class=Human Interface Device, 
Driver=usbhid, 12M
    |__ Port 001: Dev 002, If 2, Class=Human Interface Device, 
Driver=usbhid, 12M
    |__ Port 001: Dev 002, If 3, Class=Human Interface Device, 
Driver=usbhid, 12M
/:  Bus 004.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/4p, 5000M



