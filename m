Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697CA283FE9
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546417; cv=none; b=LFOLqTnVFM7hJjBJETDp/GtPmPaodK85i9FFFOJSSZ8VZ7X+pUWPOguMHsHRyQVcreY0kB89R236nRyzrldJPgXLi6AzE5ZBFahsU2OlbJetGvk1XLVKWChQm/hc/TOi7SGp5Zg1XfpWgfY2ilP4xgle1SW3KFbc1jEvCrPRGYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546417; c=relaxed/simple;
	bh=65Brp98Iy9jsq0gAiMR/i6LLkL4/Qi6XYBALn7KnS+g=;
	h=Date:From:Subject:To:Cc:Message-Id:MIME-Version:Content-Type; b=nMob1EtHopiYGZ22lnDCtxItUNOwuVamr4lzamZwbEutFWSY8pN4su/R1M5XuEjQjvLoWoNZFXkkKoWkAORYNcBqfBg9dI6Sj2JaIl5jBFlglwJsV4XYHeLnPeRM5+XAPTGYgXaUjotMnKM3iGLMElEO+hUNfFhPQq1TcwBPMes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNm0eZWf; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNm0eZWf"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-329b641fda0so557331a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758546415; x=1759151215; darn=vger.kernel.org;
        h=mime-version:message-id:cc:to:subject:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hrj38xzYsj2KoUcHPhvsnT9+rwBh7sB5GUPeoOi1bkQ=;
        b=CNm0eZWf2of7FIsb5KfSoKrkq3K3lu9D3JmHtonuQ+5INzh5Dpb9tq2lC22m+7DKgs
         1OJNo1TmycFyKY757PYkyB4NIdKhMsjMzG3kJO2MixRQFIzxy/6Qw+dAlRr6FJTHKIVW
         OcXPoSzFAefM7ncra18j0XQO2wNGzMSJtfmtZtCfJeCvFPE10Gg3oW2uAGfRENgYabk2
         NYZLxKy3DrpPgA7oSvpeJS6nk9vJ0S6MEf5KlOSrBLgjeQpz5mV7HEFnx/QNSxJ6VFyM
         XM+MGxECE/bsd3NvGu5IX0o5cKFJxAv39+IT8dYuUvzn+5e8Kchob8+cthV4wKfdgLBK
         lOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546415; x=1759151215;
        h=mime-version:message-id:cc:to:subject:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hrj38xzYsj2KoUcHPhvsnT9+rwBh7sB5GUPeoOi1bkQ=;
        b=m5Zk0gY82TnyOfgSFzUBq2PxYftlH/2ZdCjz6jRsJUlbG4ohgfIsxiKFMN0eeSNfLE
         mwo3Qjz/WSd5Z/3MNxmWkSCTabcMHB4j8onu9Ztem0ELP8OG9p1J+DTkesXKvjY2gRx8
         4f/fuAdXV9xIZ6Hd86c49jd8bciNU00AR2sr5RHKyRdrWXgnEPSxlyXdoD5gPCmxBQoc
         czxAv0niZNaju87w5LTrK6yFxRcuNmoBwrBDVP6GV3gke5GiqONrU7J7DG06k0+cNyng
         NxavUoiOGfKtj1w+VLF4eFTDQhWpV+vqgGIRzCeIJ2ehbg0XgH1cnqtJGiqRHpuQhgpB
         GyVw==
X-Gm-Message-State: AOJu0YzZ1eVIcm+rq1eTgpKZil3EvXB9Z8JV+QIqRsRxdJY+ccSEZPHk
	ZuOfGC1c8OoAk5YDMXRGHDEXbtyHNyo3Kae+bprzzrj1L1+HzcMRz1op156oDjwK
X-Gm-Gg: ASbGncumydVl2otu6VCBOnagTUxx5xOknIcV3jqhwFKseRPvZFVP8DJtei//1+tN4o1
	Kl4jcYamPPsh8Z7ldYhqaxla5tc5ny18M1VyvtbwNNDlDgDn/o8+ohSqnwuWKvdQsYfk46vL0Un
	YJpiQU+OWaPkjOf2INwK0IS3/h+QtiR9ep2AZWJpJHJshijHU6R6KZRxqme8UFPbN69l7UEtTky
	YRxO87YwR7Em7eWgPnmFFTCrY7xdHegZ3qh5gP9mq4GISTDVKREtAwX31rZwYRyWg3hqusl6c82
	wOnk+8b9Sl/LwCnSoc0yfReaNtB+YT/vkjl/rdaNXEH+BIDi8dh1vNK6Qh7h/m452jtZLXOJNwl
	SxQqN17C1+ljOEfX485BzGp3Ee58=
X-Google-Smtp-Source: AGHT+IFq/pkhEQMTH8SMWVGBuiAEWW1t0qCpSxryqoKTRI3gkB41wMYFR1hCaz40NfYiP1JHg7lvcw==
X-Received: by 2002:a17:90b:1e12:b0:32b:aed4:aa1a with SMTP id 98e67ed59e1d1-3309837ab1bmr7886999a91.4.1758546414298;
        Mon, 22 Sep 2025 06:06:54 -0700 (PDT)
Received: from [192.168.18.67] ([190.114.39.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306db47817sm6250037a91.4.2025.09.22.06.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:06:53 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:06:44 -0300
From: Julian <hattshire@gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btusb: Check for unexpected bytes when
 defragmenting HCI frames
To: arkadiusz.bokowy@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <83RZ2T.A5U3789G2QAM2@gmail.com>
X-Mailer: geary/46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi Arkadiusz,
I tested the patch with 33fa:0010. It initialized successfully and is 
working well so far.
It initially froze while scanning for more than 30 seconds, but after a 
little bit of USB Hokey-Pokey, it works better now. However, when using 
headphones, there is some choppiness in the audio during scanning, as 
if it might freeze again.

I will leave some logs in case they are helpful.

----
# cat /sys/kernel/debug/usb/devices
...
T: Bus=01 Lev=01 Prnt=01 Port=07 Cnt=01 Dev#= 4 Spd=12 MxCh= 0
D: Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=33fa ProdID=0010 Rev=88.91
S: Product=UGREEN BT5.4 Adapter
C:* #Ifs= 2 Cfg#= 1 Atr=c0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms
E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
...
----

----
# dmesg
...
[ 56.023305] usb 1-8: new full-speed USB device number 4 using xhci_hcd
[ 56.398644] usb 1-8: New USB device found, idVendor=33fa, 
idProduct=0010, bcdDevice=88.91
[ 56.398653] usb 1-8: New USB device strings: Mfr=0, Product=2, 
SerialNumber=0
[ 56.398657] usb 1-8: Product: UGREEN BT5.4 Adapter
[ 56.474345] Bluetooth: Core ver 2.22
[ 56.474375] NET: Registered PF_BLUETOOTH protocol family
[ 56.474377] Bluetooth: HCI device and connection manager initialized
[ 56.474382] Bluetooth: HCI socket layer initialized
[ 56.474386] Bluetooth: L2CAP socket layer initialized
[ 56.474391] Bluetooth: SCO socket layer initialized
[ 56.503855] usbcore: registered new interface driver btusb
[ 56.566661] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[ 56.566667] Bluetooth: BNEP filters: protocol multicast
[ 56.566671] Bluetooth: BNEP socket layer initialized
[ 56.639531] Bluetooth: hci0: Unexpected continuation: 1 bytes
[ 56.784552] Bluetooth: hci0: Unexpected continuation: 1 bytes
[ 56.858686] Bluetooth: MGMT ver 1.23
...
----

Dongle scan fault journal segment
----
...
sep 22 08:03:31 AHost systemd[1156]: Reached target Bluetooth.
sep 22 08:03:31 AHost systemd[1]: Started Load/Save RF Kill Switch 
Status.
sep 22 08:03:32 AHost kernel: Bluetooth: hci0: Unexpected continuation: 
1 bytes
sep 22 08:03:32 AHost kernel: Bluetooth: hci0: Unexpected continuation: 
1 bytes
sep 22 08:03:32 AHost bluetoothd[549]: Battery Provider Manager created
sep 22 08:03:32 AHost kernel: Bluetooth: MGMT ver 1.23
sep 22 08:03:32 AHost bluetoothd[549]: Endpoint registered: 
sender=:1.83 path=/MediaEndpoint/A2DPSource/ldac
...
sep 22 08:03:32 AHost bluetoothd[549]: Endpoint registered: 
sender=:1.83 path=/MediaEndpoint/A2DPSource/opus_05_duplex
sep 22 08:03:36 AHost systemd[1]: systemd-rfkill.service: Deactivated 
successfully.
sep 22 08:04:44 AHost kernel: Bluetooth: hci0: Opcode 0x2042 failed: 
-110
sep 22 08:04:44 AHost kernel: Bluetooth: hci0: command 0x2042 tx timeout
sep 22 08:04:44 AHost kernel: Bluetooth: hci0: Unable to disable 
scanning: -110
sep 22 08:04:44 AHost kernel: Bluetooth: hci0: Opcode 0x0401 failed: -12
sep 22 08:04:48 AHost kernel: Bluetooth: hci0: Controller not accepting 
commands anymore: ncmd = 0
sep 22 08:04:48 AHost kernel: Bluetooth: hci0: Injecting HCI hardware 
error event
sep 22 08:04:48 AHost kernel: Bluetooth: hci0: hardware error 0x00
sep 22 08:04:48 AHost kernel: Bluetooth: hci0: Opcode 0x0c03 failed: -12
sep 22 08:04:52 AHost kernel: Bluetooth: hci0: Controller not accepting 
commands anymore: ncmd = 0
sep 22 08:04:52 AHost kernel: Bluetooth: hci0: Injecting HCI hardware 
error event
sep 22 08:06:17 AHost kernel: Bluetooth: hci0: Opcode 0x0c03 failed: -12
sep 22 08:06:17 AHost bluetoothd[549]: Failed to set mode: No Resources 
(0x07)
sep 22 08:06:21 AHost kernel: Bluetooth: hci0: Controller not accepting 
commands anymore: ncmd = 0
sep 22 08:06:21 AHost kernel: Bluetooth: hci0: Injecting HCI hardware 
error event
sep 22 08:06:27 AHost kernel: Bluetooth: hci0: Opcode 0x0c03 failed: -12
sep 22 08:06:27 AHost bluetoothd[549]: Failed to set mode: No Resources 
(0x07)
sep 22 08:06:31 AHost kernel: Bluetooth: hci0: Controller not accepting 
commands anymore: ncmd = 0
sep 22 08:06:31 AHost kernel: Bluetooth: hci0: Injecting HCI hardware 
error event
...
----


