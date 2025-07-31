Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1F1C07C3
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753981665; cv=none; b=t1LNn+E5uoExjwuL7X4ryn3qjojowSn/zcbtme9eLnzCqpewG2zh3ie+XFOURaoXaVg++kzpADFeEvs41Mi+Qp+LI+vzsjCYKLIy3akBCYruLxS6Rf4a/Jk07xI3K/mb7oA5UVhGnmx+Fztn3XtZ4u0aAVd+VNfzpeJpIVE4P2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753981665; c=relaxed/simple;
	bh=0Sq8h7En/KNHGFx8APtpdxjH8sROUBjGKHtLGw4WUZI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=l9rnxpWnFT88suJbLaPEXifTceqL8AeQS7qFvmgsuBoO0aWhX/fM++gSfS1nJ4se1ZiHKZ4NVHk8GgVci4thOr8HUEFN71OO/5Ynm9fXbZegrXoLP+oFRsIdOt/6tsXnmX0bq4ixc0q+SW1Z90q2sRBVJ0DxXnX4AfdogSjJqgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmEEeOWu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmEEeOWu"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae36e88a5daso140190166b.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753981660; x=1754586460; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lnL4yUhacFQWsAf4vEL8ZouzIo08hmLLeT4SRBxYim8=;
        b=MmEEeOWu/CfM49QMRSSQ4WiP57jbyAaC4+FtN1azRiFbS42SiXRVh9VOuTvv+8Tzje
         H4JkIEgRZ2tO21DKaXc+AnBc9Yveh1ZAeuxNOuj6NoD0IZQzYx8/ukfStQdN/EqqAcWi
         qwWI+BH+P69DcRwhEWi/0p6wqFXxMJSvEFSO45V59f6FeQ+pCMCYCIkVsEO+HcuBBepp
         ZKbGaFdAnaz3I8DO8jed8YLHtvS03JWA9OCzcOpaC3rb9fN0lEXzUqdkoMFfKnvV9wXE
         S0j03Q+bzRtWc8n3YqFCKVVl85An/KCUSjaWYE78G/5d9Zev2f4nr+ufbH6HzGI+0CEQ
         XIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753981660; x=1754586460;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnL4yUhacFQWsAf4vEL8ZouzIo08hmLLeT4SRBxYim8=;
        b=v41OmUQOCnaJ96EJLy+HKrFZFanx3fCw9d56bTUzTIs0CpCUJiUDsmj/3R/Fmt5bkq
         JO27Zmnw+xv4xJ91j8dKsFjGFkT8lTT+ymjzyBdxtKeIHA3uakYPd+K/R6xhagrYNuQB
         75f6Rs+dJ/ZGUFKiCF9ffkm+f1eD9sJXYhTmME8neobbNKR+eYNCPxTm66LHwsknUmm9
         I3Cjy/7UXuCW382PSg6ghFPTXCtdwgINvBjOyIFFR3AOuqMUS4jAPyl3VbLa4xtcuG4l
         +PUNCYYSwSSPWOZ2WJDt91AcjdZgaXKRj15bqMGukhWWpQSsEHNHI6+NXHHQyBgHMWd6
         3f7Q==
X-Gm-Message-State: AOJu0YyHuXt0vNdFFyvHoaf1hYI7NZFWazwdqEawDzIopeGSxxpHk6Ft
	KWkXP3Tt4LSGxZjuHGWT8VzoO4+fbPWRHl+eUd+7ZSGnrXfRgAaDgTrvCHw+VkE7T7+rD2h3cr6
	jLosUU0hRDNEOnN2DVlig9wy73O3121AxyZBRPf/3gEWr
X-Gm-Gg: ASbGncuaJFwE8VHT+UUVOaO7FpeAPIH0jwV/+KfrhLzfaiz9G8X/zQusf6Uf3VKLl3h
	AiUWnyzhmbSTUG76m25Zl8DezboK8LgYEYxyKLPO4YDX5FTfp/clMYjAhJ3j9T5SrWwLCkN81OM
	brQ58bp/uMoa6e22zgG2r34MmfrkqIn+LdSmCIs/bdhMkkjs8hzOnB58mD/eT1jU9WxTQ=
X-Google-Smtp-Source: AGHT+IFO34Xezibo3Opt4LAJVo/JIkHMn11RYfQEC/n6FyYGCF1ldTr4gOIdMcVlj/G1YsCSRbuYf1GqbTL99/sCf94=
X-Received: by 2002:a17:907:6093:b0:ade:42a7:dad2 with SMTP id
 a640c23a62f3a-af8fd972bb0mr847005766b.33.1753981659522; Thu, 31 Jul 2025
 10:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Antti Garding <antti.garding.oss@gmail.com>
Date: Thu, 31 Jul 2025 20:07:28 +0300
X-Gm-Features: Ac12FXwd5S-9ZqpmwYChDh0ckjZ6w-paZDuG6K8f15YZathjlxWRAqU7gf2PVVw
Message-ID: <CA+nAgFfu-0=hRWNOomWiJvhutY0mEBqD23mhBDF+WdVkn0MWNg@mail.gmail.com>
Subject: Headset is disconnected immediately
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am having a issue using my Bluetooth headset (Sony WH-1000XM3) in
Linux. When I turn it on, the headset is immediately connected, but
after that, it is also immediately disconnected. This
connect-disconnect is automatically repeated three times with some
seconds between the occasions.

My environment is a Lenovo Thinkpad E14 Gen 4 laptop running Xubuntu
22.04. The computer has an integrated WLAN + Bluetooth adapter based
on Intex AX201, connected on USB bus. WLAN works fine and also the
Bluetooth works when running Windows. I have read on Intel=E2=80=99s forum
that the driver for the chip should have been ok since kernel version
5.10. My distribution comes with 6.8 so this issue shouldn=E2=80=99t be abo=
ut
that.

Log time ago, I managed to pair the headset and it is still listed as
a paired device. Trying to unpair it in the bluetoothctl console
results in error message saying the device doesn=E2=80=99t exist.

Here is what happens in bluetoothctl console when I try to connect the
headset manually:

[bluetooth]# connect 38:18:4C:D4:C2:94
Attempting to connect to 38:18:4C:D4:C2:94
[CHG] Device 38:18:4C:D4:C2:94 Connected: yes
Failed to connect: org.bluez.Error.Failed br-connection-canceled
[CHG] Device 38:18:4C:D4:C2:94 Connected: no
[CHG] Device 38:18:4C:D4:C2:94 Connected: yes
[CHG] Device 38:18:4C:D4:C2:94 Connected: no
[CHG] Device 38:18:4C:D4:C2:94 Connected: yes
[CHG] Device 38:18:4C:D4:C2:94 Connected: no

Here are some log prints related to Bluetooth in general:

sudo dmesg | grep -i blue
[    2.899284] Bluetooth: Core ver 2.22
[    2.899534] NET: Registered PF_BLUETOOTH protocol family
[    2.899535] Bluetooth: HCI device and connection manager initialized
[    2.899574] Bluetooth: HCI socket layer initialized
[    2.899593] Bluetooth: L2CAP socket layer initialized
[    2.899601] Bluetooth: SCO socket layer initialized
[    2.951909] Bluetooth: hci0: Device revision is 2
[    2.951914] Bluetooth: hci0: Secure boot is enabled
[    2.951915] Bluetooth: hci0: OTP lock is enabled
[    2.951916] Bluetooth: hci0: API lock is enabled
[    2.951917] Bluetooth: hci0: Debug lock is disabled
[    2.951918] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    2.951920] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype
1 build 38
[    2.952008] Bluetooth: hci0: DSM reset method type: 0x00
[    2.960708] Bluetooth: hci0: Found device firmware: intel/ibt-0040-4150.=
sfi
[    2.960752] Bluetooth: hci0: Boot Address: 0x100800
[    2.960754] Bluetooth: hci0: Firmware Version: 107-51.22
[    3.272512] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio
is blocked
[    4.012759] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.012763] Bluetooth: BNEP filters: protocol multicast
[    4.012770] Bluetooth: BNEP socket layer initialized
[    4.684563] Bluetooth: hci0: Waiting for firmware download to complete
[    4.684902] Bluetooth: hci0: Firmware loaded in 1683777 usecs
[    4.685041] Bluetooth: hci0: Waiting for device to boot
[    4.700965] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[    4.701034] Bluetooth: hci0: Device booted in 15702 usecs
[    4.701904] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-0040-4150.ddc
[    4.704071] Bluetooth: hci0: Applying Intel DDC parameters completed
[    4.707146] Bluetooth: hci0: Firmware timestamp 2022.51 buildtype 1
build 56683
[    4.707151] Bluetooth: hci0: Firmware SHA1: 0xe2305c5c
[    4.776168] Bluetooth: MGMT ver 1.22
[    6.448715] Bluetooth: RFCOMM TTY layer initialized
[    6.448724] Bluetooth: RFCOMM socket layer initialized
[    6.448727] Bluetooth: RFCOMM ver 1.11

Are there any known solutions to this issue? If not, are there any
recommendations where to look for a solution? If this could be a bug,
I might be interested in trying to fix it.

By the way, I would have asked this on the user mailing list first,
but the BlueZ web page didn't mention how to subscribe to it, so I
decided to try this developer list.


BR,
Antti Garding
