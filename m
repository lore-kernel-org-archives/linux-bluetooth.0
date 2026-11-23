Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407394;
	b=p7GhqAvZV6HuSmW0d7fFbcH3UxlseTi+sUNifOFRjytH5mvh87TrfivQSqQb4QtOJZhH
	 CfGztYvI4d7eerQ0J3miaCK/8Qb/us2Yq/OJCv7SdxdkrvboUtjQogwwpvy+m+lt5nPRH
	 sj9MIlRFK/YKOl0AQYh083eVATd0d5BH+JLrZCfaq2JqgjHrujeYgTIGBL16I1tNkZZUz
	 Vh8WIvb37MVvmyaHhBoj4d/Zm4VEegRyKj7bg2DaRUGVb5PbTiHfi0/CcGYIrweHHQ8BR
	 AoJ7uQIa/IZHj46kllNczN1mcgmSK/nzsaHolODLh87t8Wx3oF1o5w6UfdfHHlZT3sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xUOzVmPuOl5WJPlmPl96MJBG9c88Zjc9Dae8IkCbzcY=;
	b=e4nQE7OtTmyJ6dVU/9aYSVaiNlzJkK0ovKRMjPJS+dL3Dnh2cHSrgpiPSDGmBKyh2mo+
	 SyjtNvlNjgeG5xE1g6iRLnEKAQ0IQSh4EhjikSYHTAH8LZFHphGYnNQU5mzmJfW8saAoe
	 cBf9FRy2R8BodTI3ngqF5OXQSV/0ExBu3HQ+SoBYGywjCTrlx+rApQn5sw3WYhicY4W/1
	 n4liRoXM95zmwsQRnyJtPKuVRsD32Ag2juLS/botgT/mfEiqhhCC3DO2pywtD6MA4Vg+i
	 L55rGr9q4IZnt7YxoyAr229QKykQz6U3ik6RUy64mnmGxxzw1Bu3anumcFdUDdHKB4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="w5i/K2is";
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F4C606A31E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 04:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5F4C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5i/K2is
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2f0481b35c9so14634105ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 20:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795407393; x=1796012193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xUOzVmPuOl5WJPlmPl96MJBG9c88Zjc9Dae8IkCbzcY=;
        b=w5i/K2isBF2q5C+Y+SCaqiCEttJF5o9ySI5dTiLmPq41qXvTFZlO36ghF86eARCFBt
         9KjdARZUN51Ev25VT9YpudWfi9dj6u8QIPG1mRzQeel/fuCGuV8pmdTrF7gJbrj1p9Yv
         CLmGAH//qrapVcwox0dUBpECIilQt0tesx8UeMwP+4AxYE5SQhg546ZHXUiBp1Wcyfi+
         VaSBsCSR6ou8GUeBtYI+WI9TQn7Fyn7qX4s/YJqVwVDclvKpqF8xa3cF+1354OJ6WQWe
         JpTJ2Ebe4CzxH/WeGB0LsMp39+x8xfmpHn1yylhhAkvopBWlsBkZV5xMMz2IP4jKcuvO
         JbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795407393; x=1796012193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xUOzVmPuOl5WJPlmPl96MJBG9c88Zjc9Dae8IkCbzcY=;
        b=qRv55fgVyhX4lvdynMeGOCG7rlPlLBh19uKFCzhsZNbYzidh+5A/laxy1nvYznxxp+
         P+CO7sQx8BHAvsCM5njc9+/UCEhMVpwdz92CGN/DlsPBaj4b9r1LdOqzZJ8dNIRw1mwk
         tyQTc8vCzMt4Em3YHNzpCTfAwyW0PlwN4lXUEf0Hfl+jHyBeCEB5oywj2C2aEJIFwNC5
         DqyileX3rGAZsKdEdwuLYgRk9PKC5sLLRYEF2S08zGrB+/TMcy+CPugAbY9PXdU8niGq
         dyKYfXyyILVzDgE6/j+Owc9Vh3NwVYrMsoQyyJ4exznsf/ZpKZNupWE28BpkSfEkrkYO
         Adtg==
X-Gm-Message-State: APuU4Z9JoXTsjqtHKNQaeWSulxfgM/IeekI00SQ1PJ0ITgXZoO0josAA
	mWydcG3t+m8Rk2Ls51TppFEkWz+9MKBNRTpneYzddpU01Yzdy82ARFkW+m4HfQ==
X-Gm-Gg: AZFdTZdEqZPsAU+/7ywSmLQ491siN/wmRpk1yvfjv9+iB1wRdAA+upxp7KYy4l1oNR6
	URnfU8VxB6KNhwbjvpJqzpMZK6uXt4icInCILqV2Rpw5ZQ4Myy6wBPP9PKR29xk1CXwpnQZKt2u
	Fnu32bcpL1RRyKThhwzp0g2qIDJys+USdGBsV2f0U/AkeNuNs7P6Rm3jdqrF+AFsqC20/pI4Jgv
	4lBXmjnh2LaJzol09pwrkG5T0cRek2od24fG3YNWCwyXKjtWvVnVE8w+Vx7jqy2jTJMqdJo1WUB
	fyfX7rsWZcQPwmsEfSq6YQbfyhk0xvany5ON+MA9uZXYIPrCmRwtTCBvGmrzhu8gOK90E6PivZf
	TKmTjILg4JW6i0VpA3uY0diaXz7DyxyF6VGpOBOjqSP0jJJlpdyV4Xlnw/l7ARJIYL3PhT2GETY
	xNBzEhWWKYWAY4pgHtBpEYI26VRk6Gg0P1PMdf+1rTUbRZLUQfFa5EGrWHzbeyWkasW+QWO19vO
	872knSydErSbEv57yYT0v6gXDAMJ2pcpkq4govQ65lTHHC2abw1H2xEYG7JrxRNtXzJUDU01RRP
	LK1BnwsN8modY9cFN4eiVAWe6bjh7Xr/pFFyNfDi8o5fsFNskYo=
X-Received: by 2002:a17:90b:5350:b0:3a4:b0a1:c7ed with SMTP id 98e67ed59e1d1-3b41c98bcf9mr8244970a91.13.1795407393054;
        Sun, 22 Nov 2026 20:16:33 -0800 (PST)
Received: from localhost (122-212-58-66.gci.net. [66.58.212.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40a878d50sm17961709a91.11.2026.11.22.20.16.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:16:32 -0800 (PST)
From: Warren Nicolet <warrennicolet@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BUG] Bluetooth: MT7921 (0e8d:0608): no LE advertising reports during active discovery on 7.3.4, regression from 7.2.11
Date: Sun, 22 Nov 2026 19:16:31 -0900
Message-ID: <20261123041631.15263-1-warrennicolet@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On a MediaTek MT7921 combo card, LE active discovery returns no
advertising reports at all on kernel 7.3.4. The same machine, with the
same controller firmware, finds LE devices on 7.2.11. A passive scan
through a BlueZ Advertisement Monitor on 7.3.4 does see the devices,
so the controller still receives advertisements.

Hardware / software
-------------------
  Controller:  MediaTek MT7921 (WiFi mt7921e, ASIC revision 79610010)
               BT on USB 0e8d:0608, driver btusb + btmtk
               HCI version 11, manufacturer 70 (MediaTek)
  Firmware:    "HW/SW Version: 0x008a008a, Build Time: 20260224111243"
               (identical on both kernels)
  linux-firmware: 20261019-1.fc45
  BlueZ:       5.88
  Distro:      Fedora 45
  Good:        7.2.11-300.fc45.x86_64
  Bad:         7.3.4-300.fc45.x86_64

Reproduce
---------
  # btmgmt find -l

7.2.11: LE devices are reported, e.g.

  hci0 dev_found: XX:XX:XX:XX:XX:XX type LE Random rssi -60 flags 0x0004
  AD flags 0x00
  eir_len 96

7.3.4: discovery starts and stops cleanly but nothing is found:

  hci0 type 6 discovering on
  Discovery started
  hci0 type 6 discovering off

The same happens with "bluetoothctl scan on" / "scan le": BR/EDR
inquiry results arrive normally, LE results never do. An Xbox Wireless
Controller in pairing mode (LE only) next to the machine is never
discovered.

btmon on 7.3.4
--------------
The kernel sets up an extended active scan on 1M + Coded and every
command succeeds:

  < HCI Command: LE Set Random Address (0x08|0x0005) plen 6
          Address: XX:XX:XX:XX:XX:XX (Non-Resolvable)
  > HCI Event: Command Complete (0x0e) plen 4
        LE Set Random Address (0x08|0x0005) ncmd 1
          Status: Success (0x00)
  < HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13
          Own address type: Random (0x01)
          Filter policy: Accept all advertisement (0x00)
          PHYs: 0x05
          Entry 0: LE 1M
            Type: Active (0x01)
            Interval: 11.250 msec (0x0012)
            Window: 11.250 msec (0x0012)
          Entry 1: LE Coded
            Type: Active (0x01)
            Interval: 33.750 msec (0x0036)
            Window: 33.750 msec (0x0036)
  > HCI Event: Command Complete (0x0e) plen 4
          Status: Success (0x00)
  < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6
          Extended scan: Enabled (0x01)
          Filter duplicates: Enabled (0x01)
          Duration: 0 msec (0x0000)
          Period: 0.00 sec (0x0000)
  > HCI Event: Command Complete (0x0e) plen 4
          Status: Success (0x00)

Across three interleaved discovery cycles (~5 s of LE scanning each)
there is not a single LE Extended Advertising Report event in the
trace. The BR/EDR inquiry phase of the same cycles returns Extended
Inquiry Result events as expected.

Passive scan works on 7.3.4
---------------------------
With "Experimental = true" in /etc/bluetooth/main.conf, the adapter
exposes AdvertisementMonitorManager1 with SupportedMonitorTypes
["or_patterns"] and SupportedFeatures ["controller-patterns"].
Registering an or_patterns monitor for Microsoft manufacturer data:

  [bluetoothctl]> menu monitor
  [bluetoothctl]> add-or-pattern 0 255 0600
  Advertisement Monitor 0 added
  Advertisement monitor 0 activated
  Advertisement monitor 0 found device /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX

The controller was found within ~3 s. Pairing, bonding and connecting
it over LE afterwards worked, and reconnects of the bonded device work
too. So the radio and LE connections are fine; only active discovery
returns nothing.

Notes
-----
- mgmt "current settings" on 7.3.4 include ll-privacy. I have not
  checked whether that differs on 7.2.11.
- This looks similar to a recent report on the sister chip MT7922,
  where active LE scanning misses advertisements that a passive
  Advertisement Monitor scan receives:
  "[BUG] Bluetooth: MT7922 active LE scan misses ADV_SCAN_IND seen
  during passive scan" (linux-bluetooth, 2026-08-14). In my case
  active discovery returns nothing at all, and 7.2.11 works.

I can provide full btmon traces, a btmon capture of the same
discovery on 7.2.11, and test patches or bisect between 7.2 and 7.3
if that helps.

Thanks,
Warren Nicolet
