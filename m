Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071C924A05D
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965945; cv=none; b=pnVgtUHgKJHvLLnSJZu9UCEBpsIjaGKUN2nTJI/LeriHAG4enl8pV37loqdrheUVi15l0dVX4Iv4pvmZWqnzE7IJyi7eEFeEqNl7DZjnxwJaSNR761vN75/ZPHMQYOQ0iu3PB4ehRfGx4Q+XrbHN5fl3rS2OddI+WozVqyF2W+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965945; c=relaxed/simple;
	bh=i5Lkc+CfTOB6sVCDMMmytd48xWAQjMlbhbIYU4nobVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSYwsS2IDZIEUIrOcKHRU64O8Y3xRo81/HpAHd3Gwn22q6A9fRiwv+jet4JGj/6wOph2rmE300ROJTlVZgbUDPMjLQneKJQ2+7RpDdlzhjZaWzTrDZdKAa0+uAwySbbG7T8RDnvqmnwkTTNZirSTVmh4HN9rq/axfLIyljp+Il0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAxH9rpS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAxH9rpS"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36505450d0dso3299926a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2026 00:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777965943; x=1778570743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsCgd4r/SEhF0XtPggJxVG8eYmhOHhrTRShufNC28F8=;
        b=VAxH9rpSySKR102JcEvhouByS6BBV0/riiZR0s/in0J7HiRAe/98rH67r01JD0cANW
         F8y+YLcjD8nt1iQyzW/tDLXnG5LFX3llZiDOTGhBU70e3lWsMG6WPOqQxxeL3haOq54x
         mqlNf9k+bzglc2YKTJfhqSsHaCuKuPKTElDT4Dz3F20Is5+tF04clQ0TsV16PLs5CW8K
         APJwHAo5cG0NNmXLKKdzAGesOuTDb70XZMLbytl+vcM1hSVGkmkqUHhqnkS+HdUxojz+
         Ni3MTuvI1qcO6JaeSsKHl8QcuQGLu6VHq+sciqQYYVnIqV26F5L8kgOZFlTbJH63D8R+
         BZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965943; x=1778570743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IsCgd4r/SEhF0XtPggJxVG8eYmhOHhrTRShufNC28F8=;
        b=ioFuLFipaPs4cRBE8ejwIKDBspDSIe0vNn03beVRz4Jovrwd908jw70ar6GF8ZKzRf
         b448k+CxEvF2o2arJB/7V1mwTqj8kcgTZnST5l2G2qrOvF81BHwcYs0+gcKQA+AMxBhY
         qH+h0g3hbfc5BybpQqzq7Tyz+vrypJ9FkEJrkEgqjihjjx6j19hcmwu3U/RY8HucV2Y3
         ogFxu4vxi7gowa0opfpJmDweWRyuDI67u1RzAGFf1IiWug/t04MbiJTvrufEX7rfMnzN
         dD9gaqdl6n4F7kAbiJP3JWfBvDoHafrtLuPv0VxP4U3mwXGjhBuWSAfnc0qH06VbqqGL
         ZU3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+HgNT4tF02s0Zzbi20XHmw4LmEO0Ezc29nSWCdVuWpnykLxhb+l1WHjJ+E9YYo4hiUJVhPHN7T5eTgklCwxWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwupURLzCnxddp5vX8Yigy36mnaLEZXNb9NqQrCeePlcX39Zhw3
	aVo7/vYr8IPy5ZlQrViBkRXLgTgsEDPIrt5330xS0gCK9cgZfgeMNr8H
X-Gm-Gg: AeBDieuiNrHjryunrD80ta96yJIeWrwUEu+qTj8BYqNnkrJvFokCBNk0pXkhe29XuFW
	0+uGypGSSGVQGyo8VTZCuJyOWJQl9A3tccUL3acMekzIVtLt8tnNgfCzY28hShA0PGPkODnGnyH
	vV3tBIk3AFLCxhJ/x/KTr/SLnvfp2ktimdmnohO5pVpPQEtAKDEN+5jh+h+5i0SY2vhPkeRlwMm
	2M3JuVk3CaxSBesmgtGPGpM79vX4bh2Q9SOsTV0G9GOc/RJ2ZbWOwtn2+oxUBwFEnPtbVCBg8L4
	HMayXH5gX0a3yWBGfKrMvAgMEmLysL0HuKNMecmcHMqOjsr6E6G69RL8tpWFBdMYSchPsFdDXff
	SWFNNAJA2vqk0Bj55ZEO9acVAJuMlg55ycr4Z7knJnpxVo2lxxBb8R0mLiq7ElwrotMO8qIwWsR
	QjDdI3Q3SWRXpRf6pbRzN3yCe/2UiwDjIW0IzHnZwlsByb81YhvbxGCBqFHM7Imxg=
X-Received: by 2002:a17:90a:e7c1:b0:35f:b306:5d47 with SMTP id 98e67ed59e1d1-3650cd85defmr13039460a91.1.1777965943359;
        Tue, 05 May 2026 00:25:43 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-364ebefe7fesm13737453a91.5.2026.05.05.00.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:25:43 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: max.chou@realtek.com
Cc: hildawu@realtek.com,
	linux-bluetooth@vger.kernel.org,
	pkshih@realtek.com,
	zenmchen@gmail.com
Subject: RE: bluetooth hci0: Direct firmware load for rtl_bt/rtl8761a_config.bin failed with error -2
Date: Tue,  5 May 2026 15:25:33 +0800
Message-ID: <20260505072538.9503-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d6274785e3644bfbb0bf6a3c6a6bbff3@realtek.com>
References: <d6274785e3644bfbb0bf6a3c6a6bbff3@realtek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Max Chou <max.chou@realtek.com> 於 2026年4月30日週四 上午10:22寫道：
>
> Hi!
> The config file rtl8761a_config is not mandatory. In ic_id_table[],
> .config_needed is indeed set to false. Please rest assured regarding
> this matter.
> If you would like to fix the warning message, it would be good to
> send a patch to add rtl8761a_config.bin containing only the header
> to the linux-firmware repository.
>
> BRs,
> Max
>

Hi Max,

Thank you for the clarification! After adding an empty config file,
Bluetooth is working as usual and the error message doesn't appear anymore.

$ od -t x1 /lib/firmware/rtl_bt/rtl8761bu_config.bin 
0000000 55 ab 23 87 00 00
0000006

$ ls /lib/firmware/rtl_bt/rtl8761{a,bu}_config.bin 
lrwxrwxrwx 1 root root 20 Apr 30 22:24 /lib/firmware/rtl_bt/rtl8761a_config.bin -> rtl8761bu_config.bin
-rw-r--r-- 1 root root  6 Mar  5 01:40 /lib/firmware/rtl_bt/rtl8761bu_config.bin

$ dmesg
[  550.038863] Bluetooth: Core ver 2.22
[  550.038897] NET: Registered PF_BLUETOOTH protocol family
[  550.038899] Bluetooth: HCI device and connection manager initialized
[  550.038904] Bluetooth: HCI socket layer initialized
[  550.038906] Bluetooth: L2CAP socket layer initialized
[  550.038910] Bluetooth: SCO socket layer initialized
[  550.070541] usbcore: registered new interface driver btusb
[  550.077485] Bluetooth: hci0: RTL: examining hci_ver=06 hci_rev=000a lmp_ver=06 lmp_subver=8761
[  550.079510] Bluetooth: hci0: RTL: rom_version status=0 version=3
[  550.081469] Bluetooth: hci0: RTL: btrtl_initialize: key id 0
[  550.081475] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761a_fw.bin
[  550.083538] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761a_config.bin
[  550.083853] Bluetooth: hci0: RTL: cfg_sz 6, total sz 22646
[  550.167668] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[  550.167674] Bluetooth: BNEP filters: protocol multicast
[  550.167679] Bluetooth: BNEP socket layer initialized
[  550.659710] Bluetooth: hci0: RTL: fw version 0x0e3e4380
[  550.800287] Bluetooth: MGMT ver 1.22
[  550.819174] NET: Registered PF_ALG protocol family
[  550.857408] Bluetooth: RFCOMM TTY layer initialized
[  550.857422] Bluetooth: RFCOMM socket layer initialized
[  550.857433] Bluetooth: RFCOMM ver 1.11
