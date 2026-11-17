Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947222;
	b=4HBGLNC/LzOy8xzL/Fd3xBJIUcV2LcWgsRtddGvaPdlxXGYhBbIClfcg4mPXLTvJ/IK/
	 moxA6r+LRaklLCcaNmZOMBjUs4WHyC1yJgDtWPPoYg+sNVXIPGUAz4wU18kRgGTnLAt8J
	 35hST50xYWIndN91y5WLFqmtZVZtvY1aEU/1eliU3gQ3VgtUYpZawdXMVigmGOK/v9JIV
	 x5l6A8uHCs3vs70FjwW9ttjfbrPVd1A//yHSSyiGh7DSkzuPklSzMkq8h82SnezPIZhiI
	 8/q9JRCij0Lyh4LSQaaMjRbP8AIxt0c86e6Yz2kLJGZNY3HyNJ+uVb5b4UDb+gSGfLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NtQRzFm8cV5RodGkfpCY5dyh1Ht76XcmhOuef9Kv3NM=;
	b=3hWJpRjz4W2yZtmOAXOh3TgJSxI71x+oz7zXxqqARxBQElBC4GlgnYm257GChvFMvPFx
	 0E1hs+9W9/9JvyQg8phZOvc1h4C9L/EYQxnMQw2+61OHGPxVjdYt3Bhwx3qa6iEo6lr4l
	 MNQNEnlN1sfYbekwARgA+qKRBD+yQqNIDDrKx7tSgR8rsRVfUpF7dDcKa5n/HZukwVOlH
	 FqqRFK8zMEssVf5ef7quwL0qPo2kBESRo4i5EJEPyqQTg1YEQHe4102l4a5JrXiG8uzlu
	 9zCCJutoF6GoDXup/eR/UCUE+LceGH0wLCDPxA4SlmF/UGXR5hn3u4ZfYE5/xr9qbKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xmousse.com;
	spf=none smtp.mailfrom=xmousse.com;
	dkim=pass header.d=xmousse-com.20260707.gappssmtp.com header.i=@xmousse-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UyByXd7h;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4207F606A32A
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4207F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xmousse.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xmousse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xmousse-com.20260707.gappssmtp.com header.i=@xmousse-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UyByXd7h
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so1015425e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xmousse-com.20260707.gappssmtp.com; s=20260707; t=1794947220; x=1795552020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NtQRzFm8cV5RodGkfpCY5dyh1Ht76XcmhOuef9Kv3NM=;
        b=UyByXd7hxY91bv+iLDzA2vJf9ilC73OmQHq6Bi6EZueN+8cUfFiClzaB2mKX41cX7c
         SSZXHQ+SbO5oRi4oY2j5/ldm0hqy6ZbSoicvyWVXmG/KhMf7D/ZkUOFYvBe9kXwAs7+x
         ZdFjxcS/an6+FwHKsRYrbBrm6YtAxpBYu5tXEinUYQar2FMgmnY3nLEx9S27TTSGZzDC
         5fixvuB54+4cQwhzrFDkq3nrqzgHRJ1U7GfrUiQDGIQe7goN8hN6ccyu9xDeu5Owkf5k
         /X3eK8a7rUwnrKcAKgAX0wl4hi8ukUAU0qC6hC1ntoQ5o0OqS9927kOK4Pw7JhJRO/mG
         01Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794947220; x=1795552020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NtQRzFm8cV5RodGkfpCY5dyh1Ht76XcmhOuef9Kv3NM=;
        b=ND0ddeY5Eu8efNQQC7u18pltBcaAco+GDRpp8XIHisipBGBztQrygD6dW14ca22qWR
         vsxeR9ZbNHH2Nz+PjDJhpNJpI7+Tt5LmKRe4jK7aogWgDEqxanLziEAnNs+2nscJKfrn
         eumKY22UFGNkiz59Aq89DSeKliA+an/fuMfVZhI5upnSarAPGemV5iBbDOuelCLgjkeR
         KTjqlf74Wvz2FFWqvtsImne8gyRF2dVWHK50TSNQmLgAkQhCAli6l91O7LsSpBPtdPZs
         S8jBRZRZRkwjMhlF+uiprQwfaW/pN3ryxmIo7JJNRq8ul+ThWT4BpC4LRtr/GFuyUcA9
         7fIQ==
X-Gm-Message-State: APuU4Z+G+ilQawigh+EZIgr75464du+hEon20O4cE2TzJTUgenHJgucS
	9vfDjsR9DRvP32xUVkcNgiYO2hB0M3/b2fCPaRoq/3SHaLZK1buEToU9HJaA2dww+yLbFGEGcPp
	DQNs5pG8BrlUM
X-Gm-Gg: AYBFou3Te2YrCZfwvNHnLN3MdpfSe0klPxsIxfsTf99GnWDrV1Dpod/eA9/tSTuHI1t
	lGsfBiBBLx4tZfr1sNb3t8g3UhrDUNdY+ABcj1ws9fr0tdJuOC7ofu97ctESCOrTgUefeHzmbdp
	+SGxakjaiKAcM/Gpw/kA5pLlnb7KiyVk3NiQxlHpWggyAlAI+v0J+6aKr1wLYgBOOl2jDXIzM6b
	oEU+4cwdGmeB2+dNT6sCtMLGfUUGFrMscjNfeXGQXZ0kfxuMWcIKRQuU0pNblmtIBlbI99ppHfz
	wkMCj6Oeb9AQjSMRH3CJzQLSkbTjEIZwzJLurIjce1jD3Xhw/rQbkNhRjgbaPxDMvPrfGe9kPSX
	Yzor+wtttT0scsD8zSBgyvaMjKuS47bRRV3CyZpzcEEBf390hW9OONfawk4n4/gIR0fcu+96J/m
	I+htJitXFQbvzLP1coo7tt3FWR0AIbQwtMIa/Rts9Jx+rhFrD3r0YZebQdJFB4soQfrt3xzHLY6
	BVqb2UJxNQEyjoDY/G2qRypvgQ7JI+a7DpCAOWnyaGZ27lFXH86y09ahQkYlD4o2sCmK5JtFL8Q
	rp8f5yyAfAHOti/CjmlR2w==
X-Received: by 2002:a05:600c:8717:b0:4bb:5e8c:13bc with SMTP id 5b1f17b1804b1-4bb7da17f77mr6092795e9.7.1794947220106;
        Tue, 17 Nov 2026 12:27:00 -0800 (PST)
Received: from peacock.. ([187.15.172.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7ad9430asm70271675e9.15.2026.11.17.12.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:26:59 -0800 (PST)
From: Ofir Mano <ofir@xmousse.com>
To: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org
Subject: [PATCH 0/1] Bluetooth: add passive-discovery quirk for Intel 9460/9560
Date: Tue, 17 Nov 2026 20:22:37 +0000
Message-ID: <20261117202632.49924-1-ofir@xmousse.com>
X-Mailer: git-send-email 2.43.0
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

Hi all,

Intel 9460/9560 (8087:0aaa) controllers stop reporting connectable BLE
advertisements after the first active-scan SCAN_REQ/SCAN_RSP exchange.  The
controller stays silent until it is reset, even though the host scan is
configured correctly.

This breaks WebAuthn hybrid (caBLE) passkeys: the phone advertises a
connectable ADV_IND carrying the FIDO service data, the first operation
succeeds, and every later operation times out until a reboot or a
driver/controller reset.  btmon on a failing attempt shows no advertising
report at all, with `Filter duplicates: Disabled` and the same scan
parameters as the successful attempt, so the loss is below the kernel.

Same machine, same controller, same firmware build: Windows receives the
caBLE advertisement reliably.  A USB HCI capture shows Windows scans
passively (PASSIVE, PUBLIC own address, 1M only, ~10-15% duty and an Intel
0xFC1E vendor command before each scan), while Linux scans actively.

We tested the fix space as module variants in the real flow:
  - stock (active, random address, deferred delivery): 1st works, 2nd fails
  - active with delivery deferral removed: fails
  - active with PUBLIC own address: fails (both attempts)
  - passive: ~1 failure in 18 consecutive operations
So neither the kernel report path nor the scanner's own address is the
cause; the latch is tied to the active-scan exchange itself.

The smallest working fix is therefore to scan passively for this
controller, and to deliver passive reports during discovery.  The latter is
needed because the existing passive filter drops reports that do not have a
pending report action or an advertisement monitor.

The patch adds HCI_QUIRK_PASSIVE_DISCOVERY and sets it for 8087:0aaa only.
**Other controllers keep active scanning**.  The trade-off on the affected
parts is that scan-response-only data (for example device names carried
only in SCAN_RSP) is not available during discovery; that matches how the
vendor stack drives the same hardware.

Testing: Pop!_OS, kernel 7.2.15, Intel 9460/9560 (8087:0aaa), firmware 169
(2024-08-13).  With the quirk, discovery runs PASSIVE with a random address
(verified in btmon) and 18 consecutive hybrid operations produced one
unexplained failure.  The patch applies to a clean tree and builds
bluetooth.ko and btusb.ko.

!!! No regression testing was performed on other controllers; 
the quirk is keyed to this USB ID, so all other devices keep active scanning.

Public reports with the same signature:
  https://bbs.archlinux.org/viewtopic.php?id=298396
    (exact 8087:0aaa; scanning works briefly after rmmod/modprobe btusb,
    then stops again - i.e. a reset clears the latch)
  https://discussion.fedoraproject.org/t/intel-bluetooth-wont-scan-ble-device-works-on-windows-blank-scan-on-linux/196326
    (Intel, kernel 7.1.3; btmon shows the extended scan but the controller
    returns no advertising reports; Windows works on the same laptop)
  https://issues.chromium.org/issues/41485480
    (caBLE passkey never completes; worked on 6.3, failed on >= 6.4 with an
    AX210; closed as "Not a Chrome issue")

Note on scope: ArchWiki reports that passive scanning is broken on Intel
AX200, so I deliberately did not widen the quirk beyond the tested USB ID.


