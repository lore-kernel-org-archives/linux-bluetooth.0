Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8DB1DE2D8
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 03:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773891993; cv=pass; b=OxCaO+PJYr+9qvywo0hESAIsveBQKCJeDpBYjjlNT32BYkv4JAj3aUhXrWk0rswcSluQQlbrmTsl6BrkEJXRpMq1WlOFZ34y6wh/DKnvnHHVyABdOKYIYilA6Qn7/AM2SBkWPAFlJWVXpM8VZGbC724bEZUPyOEhdLuRvSD2SQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773891993; c=relaxed/simple;
	bh=8Emb/Kg+pt/RSRzTC+SY84EsEWOHwSAuapsVwfQOLnM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bB5fbOu0TKqfOoerlnH0fE9/+emMDvfAtn8hIP4vGmmS+9Cd7Yv+jKnduSCVWE1v9chZx3YEPSlwJrbglcMiPtn5a65nlf2a/Aw9t8iaZVo8kF5O20/JcF9lKSj6dmutTePfwxHclgi5OLTScBUlI8Zv/VITQPO0zBGFpq2zomg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atzNnOTC; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atzNnOTC"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ad9fabd08so169353d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 20:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773891991; cv=none;
        d=google.com; s=arc-20240605;
        b=gsqrueTeG9ihz/y0vNC4a2Kc4oSCRICtymus+gkHhFQH9ta/gdzxYiHfSD9CjJMzKg
         ACNNwYeq0YJM41ziUu0Wm1pk4UZ4pJe7adjrGwiFLCjYC+PVk87p4PXRYBzgJW1zdRAQ
         0QYm68AccrOA+8b2wNuQg7LQQ41GitLyS2b/VNhA8O1KPMZxs6Knas68tnFjlbOA6dgV
         kEbMBaHI3Q4LrR3s/wzj+rjhzntWwBfj5NJZ2ksTUIuTBlj98CtbB+dAvac2420hGJlU
         oiPAjtSMxzGq9q4m/jAhIq12kaUmy+h5tE0xCjLNK5RfRiIZrTw8RI5lHHKLCwlJCOan
         aJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=uKgAFC1J4GFx4uDPHtRJFpAJmHoySreu6J3whTlcfWw=;
        fh=+7AvWv71ofgQoUyp5cG+RWtiQboLefNwN7zaXrtLsbI=;
        b=bb34S6cShuD5+f0sk1J1M4hCKeWfKw1Ant+28KSKLy+VFdyq1olIH4mxm8DhCbrwvd
         nJb3+iYfQMNSVXeTriVjeu4BxMUnRdtL85//Zfr+4EQmtUTh4O6Nb8Z6YUKt9+5RoFpZ
         iTGYVDRoIThslIosyXwhr6NlIhNawEKext97ZhKycNSk19RdCYuF7kUmU72LZ5AYBru6
         6D05uqwLVzLuojBYxp4Z6g81laGF3uPksZA/ne1EvJTS93HaqZsGymdQ3VHOC+S6DOuG
         iln8lNycS4scPdKn8Ki3T09AM4rGW7vVIaHpyhTGdkl43MvcFpBQq5L2ifiWmDVXgjpv
         +omw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773891991; x=1774496791; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uKgAFC1J4GFx4uDPHtRJFpAJmHoySreu6J3whTlcfWw=;
        b=atzNnOTCyjOMjU2GdIndchbVBvrukEWErzFoKGaXqghyk1Ur0wtCmUQonbpvQjKxTD
         2xpF6pmba6w3Rid4Sg2E4W7RxTQWoVJxL+h3E1gJyFw0OZ0LqrYOAObd1CDIBtbH/sgB
         xQClIyFpLh2YyTBkXfI++6eJrVH+UtkHprHfOiENS2iS/A6MSGg/y5WWgIVlxjHH7NZp
         kNsz7n+rKAwbAdw0ECExeV5vIhrh37LQ/0oDJDZsRuwMkeYFef6mAbVik/r0HT/81+Nf
         EzYUGumth71+U+8ygeGlBA4uX0UY/FlifttxnhHC3MUJiJwAhKIFKhdaaqAFe3VUsMXk
         TnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773891991; x=1774496791;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKgAFC1J4GFx4uDPHtRJFpAJmHoySreu6J3whTlcfWw=;
        b=H7MpgediYcsWsJai1X854u7hB0MUNjE7R0cOEUkNmhl0JnNB8Udet57dzE+vC6K1kL
         6szbMBhEgnUIKkfCFPmXt5I/OJDjtcufYxQZnNSkEca84clkhhMLRZ5LrdwTwWGWfwg6
         6VCZHqmC7Oeoh9im1w2eR48fO08XesFB8SLj5lXtVRsj9xR31Ss1RTgaETlgQwmLYH0w
         DXc9sB/yctxrhHJliLyop5s4LqCUChqBGZcQWLVRA9M6ZhepuiIGVGvawb4BF0Dw3M5t
         czfuBvU2nrjBmljxtg6W1ciGWDeVFp87cHi7dC6rWmJedZK+VpqiBzL1DQOhoUKFWrnt
         LTsw==
X-Gm-Message-State: AOJu0Yx2T59VCVsvIh24X3cjdyi3rQ3+5gD/I+IfMou0XBVCEgsa4++t
	5fzkjol/5I+pDmNpwEnsp2NFyTm9o29P5e8L8wTH69Lng64WMM/ViRfH68SPZBeWaghzEhMStjO
	58tr+7vNjwpXQ+lDE8GBDAWtTtYBr4oP8NIw5P90=
X-Gm-Gg: ATEYQzytl0LJ+vr+IoyikvckMhvaWUAS+V+evYzOmTMnXO32cz+5/E0ZJ9BpS+6c1L4
	8vbrOor2OxOmdorm9Hl5Mk4c5IIPvA0kQlkY7kKLrbIMW0LtyMh9uSuFnLqFp6RUNfoeVACLmLl
	hqNwOmfGjAomd+qmaLoSfPlCKkD+j+vsnzDDV2cuywAGP9Pl0PIsW12dBWPduYTSXh4cvaaMu5L
	ObFOkCjm5212O6wBFjDI3FYc0nANGNIrbr97kDiXPwMNvrP2Ci34TTJ4M1JONmxDpA+QbvEf6V6
	aMmq8es=
X-Received: by 2002:a05:690c:d89:b0:79a:3a33:948 with SMTP id
 00721157ae682-79a7188dc82mr57176087b3.9.1773891991567; Wed, 18 Mar 2026
 20:46:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anthony jo <anthonyjo671@gmail.com>
Date: Wed, 18 Mar 2026 23:46:20 -0400
X-Gm-Features: AaiRm53Q5oV1OL5BgZUGBIfRCRXZ4GNtj2R0Yz9XrKZy06f_KHl5PndhQwnGE6s
Message-ID: <CADx-YRB9srPzKCP4tn7FD_RWpgiMd_+fgHbLCdkoCjJ7Hcu8CQ@mail.gmail.com>
Subject: BUG] RTL8852CE (IMC Networks 13d3:3612) Bluetooth not detected -
 missing btrtl support
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

I am reporting a Bluetooth issue with the Realtek RTL8852CE chip on Linux.

--- HARDWARE ---
Laptop : ASUS TUF Gaming A18 FA808UH
BT Chip : Realtek RTL8852CE
USB ID : 13d3:3612 (IMC Networks Bluetooth Radio)
Kernel : 6.17.0-1012-oem
Distro : Zorin OS 18 (Ubuntu 24.04 base)

--- PROBLEM ---
The Bluetooth controller is detected and shows UP RUNNING in hciconfig,
but scanning detects no devices at all (BR/EDR and LE).

btrtl does not list rtl8852ce in its supported firmware list:
$ modinfo btrtl | grep firmware
(rtl8852ce_fw.bin and rtl8852ce_config.bin are absent)

No firmware files exist for this chip in linux-firmware:
$ ls /lib/firmware/rtl_bt/ | grep 8852ce
(empty)

btmon confirms the scan starts successfully (SetDiscoveryFilter success,
Discovery started) but receives zero HCI events from any nearby device.

--- RELEVANT LOGS ---
lsusb:
Bus 001 Device 003: ID 13d3:3612 IMC Networks Bluetooth Radio

hciconfig -a:
hci0: Type: Primary Bus: USB
  BD Address: F0:68:E3:6E:36:1F
  HCI Version: 5.3 LMP Version: 5.3
  Manufacturer: Realtek Semiconductor Corporation (93)
  UP RUNNING

dmesg:
Bluetooth: hci0: Failed to read codec capabilities (-22)

--- WHAT IS NEEDED ---
1. Add device ID 13d3:3612 to btusb/btrtl driver
2. Add rtl8852ce_fw.bin and rtl8852ce_config.bin to linux-firmware

Thank you for your help.

Best regards,
Anthony
