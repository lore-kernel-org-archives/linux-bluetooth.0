Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B6845A29F
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790430770; cv=none; b=KDXMFvZuZ5CX9GKTGqT1DW6+O9VvfVZrgA1Fvpr56kAy6t++CGV1au/BMu7b6GHJBFozKc6SywEmoTbqmLZOEfyxNNacLxz9ybQZt1Jf7pEV/b1JgKG2ADxsEI2peXmVZSetT6B8288Z7Ow534HSZzzb0/hOhSD2Nxno0mEv4Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790430770; c=relaxed/simple;
	bh=N+jJ6HjdLffAq6FRWw7Rd4ZzY69uDTGFBG/3KmszgCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9Xley/5fX1ugyYKvksB92eJo5bdHz/UjGND7uotvzsRvt0pgwiDKhIb7zQJ8JJXMUWOTxaOJO64z1vRYtLXdn//n15ZFqiCOyf3C7XHj3rtrHLhczTDg43+Ltdh6pCoePEt3XTvrJFWYZafJ3oSFHE6vZlZUuZ/K+uCvISnT7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgQKLy/q; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgQKLy/q"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843cedd129so947581f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790430764; x=1791035564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v0ryIiGFR8435PbdXUXtBWjIoyQJMVYqVs/lmMIMrHY=;
        b=JgQKLy/qBUxL3iUA3zMEh+VYoWlFW/ZyV8rYmLRj7v1n6bBhXJL2vkgdHL4/ReFvz1
         PVb86BHE3t8d3Oln2Mpyy9GvyBamDXK5bVjIXscORzO2o8dUC+FB2teooeruGTmm/MDL
         nqU3NEHZ2asz52mt8HS7Ad1KHvWHRAZKGPublkmsdD9C/4ic5xwzDRzl1t4uenQNLDZ7
         gMNAKHZspZGRFz3SuJYQqDYUnQIukjNfTBRzhjvWAvAQWoWTFcnuUKVZTjD6g33o9dWL
         2FH198weSR5DEQGFWDgeK/op1I/4xb7Bj1C057ChKi100EDOqHN8wUbFlVRmBckRx7rH
         gtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790430764; x=1791035564;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v0ryIiGFR8435PbdXUXtBWjIoyQJMVYqVs/lmMIMrHY=;
        b=HkGPvJvKOUHC2lZW/ri+yIid3ADTCnbckVKTpqzSbShOO4u5kjn3uU042VE2fNmAkz
         jK9hPalDUqzFufuXDpzufRZ7S2iuqF5DZtw4R/PZOpJPMKadTFrRwzLze4tx5VktFQiW
         +gORYuOtaIYEFsKb8V8Y8FiCDthEcdZU3jDMV2oGEvtGpNisZJ+od+EYmqZuJjcneWma
         OMaU4NuIa6rkEaEb852+aLo0W49Y8Nh/Ybsw3lte4yFsdIl2/7pPSEvSeK3TW9TBN5r0
         T/L80WOZXWUMPHTjjZqb7fRLXkO5JKhfQGvdWSYvJVfxdW4po14En8XCwdBPq3vUpBzd
         iFkw==
X-Gm-Message-State: AFq9FYJuZu4WHc56XbharzDQKV+3vyZbQl8dAP9n2LTOLxi9ut4peXvT
	uGj6t49dJpLqHZC3jPe/piOQGghp27f1NEM7vrRE0EofK0wGc40lXLZR
X-Gm-Gg: AYBFou3tQh1j9O1M0QlNRU5Sq/cnRWAqQ10m3pfPovL6VGF9zR3TCnA2L/vXhqQkIci
	Vx5xkCf6MGeMmIh6SvS+KBPFtI/4B22Ptz7aooqQmeCmW5yvAFbqJ6Eg9QhAPr8GqkgFYXFBNqe
	iSGO1oGhuClHdq2BG9Xc93UO6apZA3Gp1gkG9x6TdPR1PPKPxl7kGRdcJIQaSNQwku3qakCOuTF
	55X+fn6qokQrPg0Ysq68sbtio2gUBx/mEPhFaKlAT+UKAAcKRs+gDDjeRyv7aN9qZgBHlOmUsdT
	jtctDXCWJ42Yyb+Rq6gsJE7lmw1jXfUb9FTQ53mh6EpSV36cvBbJYwBWygpucJNzBr8FCnehm5l
	NeLKrfZfedcqKqRb2ml+DFKox0zA7sqtYBsZ/4Od/ir5c2gIJq5tbu7Jg3R9eckHhHfSMnlY6HX
	DPoC5EiesEoJkpl1G7nkT6hcOmYNxY/I3wCYNC9V/xzFBz6Dc/VamHxxkWchR3nt3lubavAbNun
	/U=
X-Received: by 2002:a05:6000:26c3:b0:487:1266:628c with SMTP id ffacd0b85a97d-4887166dee2mr16765678f8f.2.1790430763882;
        Sat, 26 Sep 2026 06:52:43 -0700 (PDT)
Received: from kali.local ([2a02:4e0:2d65:12bc:b5f6:27d3:c07b:3db6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a64ef3asm14330623f8f.30.2026.09.26.06.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 06:52:43 -0700 (PDT)
From: =?UTF-8?q?Veysi=20=C3=96zg=C3=BCn?= <veysiiozgun@gmail.com>
To: Hilda Wu <hildawu@realtek.com>
Cc: linux-bluetooth@vger.kernel.org,
	deniz <denizgu@protonmail.ch>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Timlee <timlee@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Max Chou <max.chou@realtek.com>,
	alex_lu@realsil.com.cn,
	zoey_zhou@realsil.com.cn,
	kevinchen@realtek.com,
	Blc Dragon <fenix78563@gmail.com>
Subject: Re: rtl_bt: RTL8852BU rom_version 3 has no matching in rtl8852bu_fw.bin
Date: Sat, 26 Sep 2026 16:52:19 +0300
Message-ID: <20260926135219.13925-1-veysiiozgun@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6027f64b0658478a91f0cadd4a6b051d@realtek.com>
References: <6fA7_pnseglPl3sGOhJ9Blqy9rvnEcG0jTZEaJxRmt7Z9hyouvO-WtWss7N_xgZMoV7kzNlEDt4sBFiCIiyfsfpUUnB-uAtOMwVjVeX-SDg=@protonmail.ch> <6027f64b0658478a91f0cadd4a6b051d@realtek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hilda, all,

Thanks for confirming that eco 4 firmware is planned. I have the same
controller (0bda:b853, rom_version 3) and got it working with the patch
from the Windows driver. Along the way I found something that may matter
for the Linux release: for this ROM revision, the Windows driver sends an
extra vendor command before each patch segment. The current btrtl
download path never sends it.

Hardware / software
-------------------
  Machine   : Lenovo LOQ 15ARP10E (83S0)
  BT        : 0bda:b853, hci_rev 0x000b, lmp_subver 0x8852, rom_version 3
  Wi-Fi     : RTL8852BE (rtw89_8852be), works fine
  Kernel    : 7.1.5 (Kali), BlueZ 5.87
  Windows   : Realtek driver 18.4032.0.3008 (rtkbtfilter.inf),
              patch file rtl8852bd_mp_chip_new.dat

What Windows sends (USBPcap capture of a radio off/on cycle)
------------------------------------------------------------
  HCI_Read_Local_Version
  for each of the 3 segments:
    0xfc62 plen 9: 21 | le32 0x801200cc | le32 <segment addr>  -> status 0
    0xfc20 fragments of 252 bytes, index 1..0x7f then wraps to 1,
      index restarts at 1 for every segment,
      no 0x80 flag at the end of a segment
  then one 0xfc20 with index 0x80 and no data -> status 0

  segment addr    size
  0x8010f720      61552
  0x8010e990        568
  0x801084e0       2900

Afterwards Read_Local_Version returns hci_rev 0x3c91 and lmp_subver 0x950e.

The fragments are byte-identical to the payload of each BTNIC003 entry
(chip_id 0x14, eco 4). In each entry, the two addresses are at +0x3df and
+0x3e7, the payload length is at +0x400, and the payload starts at +0x408.
The first segment has the same layout as the eco 1/2 subsections in
rtl8852bu_fw.bin (code starts with f8630f62 and ends with the 07072db1
trailer).

What does NOT work
------------------
1. Adding the eco 4 payload as an extra RTBTCore subsection and loading it
   through the existing v2 path (without 0xfc62). The controller stops
   responding in the middle of the download ("command 0xfc20 tx timeout",
   "download fw command failed (-110)"). After that, even 0xfc61 times out
   and usbcore keeps resetting the device. Only a full power-off recovers it.

2. Loading the patch from userspace (libusb) with the Windows sequence
   before btusb binds. The patch itself is accepted (lmp_subver becomes
   0x950e), but then btrtl_initialize() finds no ic_info for 0x950e, sets
   drop_fw, sends 0xfc66 and the controller goes back to ROM.

What works
----------
I added a small path to btrtl_setup_rtl8723b() for
8852A-id / hci_rev 0xb / USB / rom_version 3. It uses request_firmware() on
the BTNIC003 file and replays the sequence above. With it, the controller
comes up with its real BD_ADDR, registers with mgmt and scans normally.
This is only a proof of concept and not meant for merging (it parses the
vendor Windows file). I'm happy to share the diff and the pcapng if they
help.

Question
--------
Will the upcoming eco 4 firmware work with the existing RTBTCore download
path, or does this ROM revision also need 0xfc62 (or similar) on the
driver side? Either way, I can test pre-release firmware or driver patches
on this hardware.

Thanks,
Veysi Özgün
