Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B94A3A4510
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785820; cv=none; b=FXOcQOfutfqhSmPVii/i7bGyn86JDNVK0JyiK76xOewhQDnKsZcU50N8pHkQhPufvjZmrQNUArrWCCWF8dhK24IB3S9zZKi7rBkZKJrAAgVODIev8FnX/+wEqCZFTGQJWWOdsmf6V5HRHPAKg+ZZaqN50JIYnHuOFxYTM9II9Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785820; c=relaxed/simple;
	bh=Vx4rWPnuU0u5X2eY3jWevXtI36eessZ2aI4nsUWHFD8=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=SsLiFe59ZgbcoaR4abrr25KK6L/OO19BNQIR5G+YDhL7gHx19FmAwdDMM1/ISjbO2YxE2oFg4fsF3OuN440DF41GfI9gD1E6gG8PjlCSVDNl+1nG0CYk4nADDQzUPHS6dJTKAZ6b9fyse9/XxcrMgMgfbbUwnReaMWuqPZp04+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffENRkJp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffENRkJp"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so6241868b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778785817; x=1779390617; darn=vger.kernel.org;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wniy8cY+bmHO9mua0km+WDAsIN3WJePXImm39mFdgfU=;
        b=ffENRkJpeKREK5RPy0DjPvK5/PwZO7LJMxsbS2RzmiqEv1XWcD0ICdQn5rH2KT5ywh
         GwEiEjRBuauBh3g3XD4xc3ntKMZa4lN34kCcQoB70OTxkoJC4osM2b7kOUrmj5PfJaSm
         6VYnVXgCm0WOKAuf5M1V7pbYvr7cxW1PbvLN5ElhUUzLWFmtfgEoJBSexuI9t82X+1Mw
         1RurwCiyMwc9h1Z9slAi8DujdVwR6RyBB3yLppVVchD2Fi8ylmeWi2qiYHyHmWNyf+1u
         TXiVnNPly2jpAE2FBbBJQR0lR/ca/oR5jdgyK8tMkqdvzDqO3NHeERz1D6RW6Revxi4R
         8B4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778785817; x=1779390617;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wniy8cY+bmHO9mua0km+WDAsIN3WJePXImm39mFdgfU=;
        b=o9hFP4mU4HkSAyxiUlLszvrxVgV0yb3yXECZWTgmS18e1MZDw1un9smpnJ014yol7D
         YF14Yv4vDgjnvOdNQJoOrdXxxjMzs/FD/+HvfaI60W9NjzF7OAwGrr0tAIJB+k3sX6ng
         6AdNWBIEt+iroQoMPTC4eP7RI/hw5cpArCtHnP2ftqpZgkb7tHZXKjoFq2BRgWJg9Wt4
         iyCPMd/bn1D8U0cZC6RNrZR7Y2uWv2JeXjHKL+8nWk0Fky+0NMbrYv0UwsLrt/uxI8RZ
         70JBtBCvrQarVZrIfxEaWS7g+WxcPOi80FJp0s9sPZmoOB0qXglMXrlIJRuJmilFwbZh
         /dDQ==
X-Gm-Message-State: AOJu0Yx3YYpghEDWL4hNPhvtgKydua/+3OpgIt2itKL2TkGEy+CDSj5Y
	BsInNnfFjW45V9sxbkqTBIZltqg5099ric+S/32/A+YGUIqIgef2heJO6SpkQawL
X-Gm-Gg: Acq92OHUHRfcOJswESzmwM4kedzezXzHL06fV3kSyxb8GUIM5k9HrGUfAHaRkK7SeDa
	iGQB8T9l903komklAnAZh9Hsbwz1lfZY+kWoAs89apIer81W7XVAnXc727yaMWE2mxdP65/yYOL
	BrPTdhUvUJTGMaOQNTgXGoe1Sj8J/zDAHTve8Bzhcv2Atvy2MsYRqB6EwMK6HUZKo6wlnBsI/jr
	Wgm01yBWh0TJYG1AkIiI3yYBX3Mpg9ROc4Duo3n17/NlHbeNKjSGdDk5IhLqlesxd6SzYlbTNS1
	KwN65UrZK+ncxoGm9dO5DysXVeLuBLuilwwD6i1pbRsynyam3Je0+ZxBKVcWlUEWnTJPrzY3FqB
	GecNjibYBoqeHG8WdLUdNAaIhtTLPLWq9N+f80tFCEuVcEljI4o4MZOOpUI6rJGpnDi+/Nl5xIx
	Cm0n94OqFibTEuplvIwaUB77ebCpxY/kcMkLs27J2nV847yuSLpLDBm46YedLDQFSiHdNhm/jRZ
	1nh5MNl1Zrt/BsiMrA7TOd2
X-Received: by 2002:a05:6a00:908a:b0:836:3f6a:3e77 with SMTP id d2e1a72fcca58-83f33c9e1a2mr838957b3a.17.1778785817095;
        Thu, 14 May 2026 12:10:17 -0700 (PDT)
Received: from ?IPV6:2601:601:c82:db00:547a:9f89:e54e:d64a? ([2601:601:c82:db00:547a:9f89:e54e:d64a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19661261sm4516538b3a.3.2026.05.14.12.10.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 12:10:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------6maeGXD3NjsnXABZVqqhu50K"
Message-ID: <6890c968-f662-40db-a30d-775bc6593494@gmail.com>
Date: Thu, 14 May 2026 12:10:16 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
From: Jacob Mills <jacobmills1997@gmail.com>
Subject: Bluetooth: HCI Create Connection issues default page-scan parameters
 (R2, clock_offset=0) instead of values from inquiry cache, causes Page
 Timeout on BR/EDR audio device

This is a multi-part message in MIME format.
--------------6maeGXD3NjsnXABZVqqhu50K
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Filing this for a 100%-reproducible BR/EDR pairing failure on a recent 
Fedora kernel against a 2015-era audio speaker, with btmon evidence 
pointing at the kernel's HCI Create Connection path ignoring 
inquiry-cache page parameters. The same physical hardware pairs the same 
speaker successfully on Windows.


SUMMARY
-------

When pairing a BR/EDR-only audio device that advertises Page Scan 
Repetition Mode R1 with a non-zero clock offset, the kernel issues HCI 
Create Connection with default values (R2, clock_offset=0). The page 
never reaches the remote device and Connect Complete returns with status 
Page Timeout (0x04) after the default 5.12s page timeout. Pairing fails 
every time. The inquiry that immediately preceded the pair attempt was 
observed by the kernel (HCI Event #3 below) and contained the correct 
page parameters, so the data was available to the host stack -- it just 
was not used in the subsequent Create Connection.


AFFECTED SYSTEM
---------------

Distribution     Fedora 44
Kernel           7.0.6-200.fc44.x86_64
linux-firmware   20260410-1.fc44
BlueZ            5.86-4.fc44 (bluetoothd and bluetoothctl)
Controller       MediaTek MT7922 (BlueZ manufacturer id 0x001d / 29)
                  USB ID 0489:e10d (Foxconn / Hon Hai), bcdDevice 0.01
                  Combo card (BT + Wi-Fi on shared antennas; Wi-Fi was
                  on 5 GHz at time of failure; also reproduces with
                  Wi-Fi disabled)
Controller MAC   D8:B3:2F:44:DC:DE
Remote device    Edifier Luna Eclipse HD (e25HD) powered speaker
                  (BR/EDR-only, A2DP Sink + AVRCP, manuf-id "Fihonest")
Remote MAC       40:EF:4C:E0:B6:7B

Three kernels are installed locally; a regression test on
6.19.10-300.fc44 has not yet been run. Happy to do that and follow up.


REPRODUCIBILITY
---------------

100% reproducible on this kernel/firmware/hardware combination across:

   * bluetooth.service restart
   * modprobe -r btusb && modprobe btusb (full firmware reload, confirmed
     by matching "usbcore: deregistering/registered new interface driver
     btusb" pair in dmesg)
   * bluetoothctl power off/on (HCI Reset)
   * USB autosuspend disabled
     (echo on > /sys/bus/usb/devices/1-6/power/control)
   * Wi-Fi radio disabled (rules out MT7922 BT/WiFi antenna coex)
   * Fresh 60-second speaker power cycle
   * Fresh bond state on the laptop (no on-disk bond record)

The Linux side discovers the speaker reliably via `scan bredr` at strong 
signal (-55 to -58 dBm). Only the page-following-pair fails.


REPRODUCER
----------

In a single bluetoothctl session, with the speaker freshly power-cycled 
and in BT input mode (solid blue LED), no other host bonded to the speaker:

     [bluetoothctl]# scan bredr
     ... [NEW] Device 40:EF:4C:E0:B6:7B EDIFIER Luna Eclipse HD
     ... [CHG] Device 40:EF:4C:E0:B6:7B RSSI: 0xffffffc8 (-56)
     [bluetoothctl]# scan off
     [bluetoothctl]# pair 40:EF:4C:E0:B6:7B
     Attempting to pair with 40:EF:4C:E0:B6:7B
     Failed to pair: org.bluez.Error.ConnectionAttemptFailed

The same outcome occurs with `connect` (post-bond) -- both surface as 
the same HCI Page Timeout underneath.


THE BUG, FROM BTMON
-------------------

The relevant excerpt (full snoop file attached):

   > HCI Event: Extended Inquiry Result (0x2f) plen 255  #3   35.314602
           Num responses: 1
           Address: 40:EF:4C:E0:B6:7B
           Page scan repetition mode: R1 (0x01)   <-- speaker advertises R1
           Class: 0x240428 (Audio/Video, HiFi Audio Device)
           Clock offset: 0x3f03                   <-- non-zero, valid
           RSSI: -58 dBm (0xc6)
           Name (complete): EDIFIER Luna Eclipse HD
           Service UUIDs: A2DP Sink/Source, AVRCP Target/Controller

   [ ~12s of `scan off`, MGMT Add Device, MGMT Pair Device ]

   < HCI Command: Create Connection (0x01|0x0005) plen 13  #11  47.576809
           Address: 40:EF:4C:E0:B6:7B
           Packet type: 0xcc18
           Page scan repetition mode: R2 (0x02)   <-- kernel uses R2,
                                                      ignoring cache R1
           Page scan mode: Mandatory (0x00)
           Clock offset: 0x0000                   <-- kernel uses 0,
                                                      ignoring cache 0x3f03
           Role switch: Allow peripheral (0x01)

   > HCI Event: Command Status (0x0f) plen 4 #12  47.577608
           Create Connection (0x01|0x0005) ncmd 1
           Status: Success (0x00)

   > HCI Event: Connect Complete (0x03) plen 11  #13  52.698868
           Status: Page Timeout (0x04)
           Address: 40:EF:4C:E0:B6:7B
           Link type: ACL (0x01)
                                                  <-- 5.122s after
                                                      Create Connection
                                                  <-- = default Page Timeout
                                                      (0x2000 slots)

The kernel issued Create Connection 12 seconds after it observed the EIR 
for this address. The inquiry cache entry should still have been valid 
(default eviction is 60s). Either the cache is not being read on this 
code path, the inquiry result is not populating the cache, or the cached 
PageScanRepetitionMode / clock_offset fields are not being plumbed into 
hci_acl_create_connection() (or equivalent).

For a device using R1 (1.28s page-scan-window cycle) the host-side hint 
should reflect that so the controller can size its page train timing
appropriately; pairing with default R2 + null clock offset against an R1 
device with a non-zero clock offset means the page train is misaligned 
and the page misses entirely within the 5.12s window. On Windows, with 
the same physical controller, pairing succeeds -- so Windows clearly 
does plumb the inquiry-result page parameters into its page command.


SURFACE-LEVEL ERRORS THIS PRODUCES
----------------------------------

Depending on call site, BlueZ-userspace remaps the underlying HCI Page
Timeout (status 0x04) to different D-Bus errors, which can mislead
triage:

   bluetoothctl pair       -> org.bluez.Error.ConnectionAttemptFailed
   bluetoothctl connect    -> org.bluez.Error.Failed
                               br-connection-page-timeout
   bluetoothd (audio path) -> avdtp_connect_cb() connect to
                               40:EF:4C:E0:B6:7B: Host is down (112)

All three are the same HCI Page Timeout under the hood.


WHAT WAS RULED OUT
------------------

   Speaker hardware           OK -- pairs with other devices, pairs on
                                   Windows on the same physical host
   MT7922 controller hardware OK -- works on Windows; BR/EDR scan finds
                                   the speaker at -55 to -58 dBm
   Stale kernel / firmware    No -- both current (linux-firmware
                                   20260410, kernel 7.0.6)
   Bond conflict / stale key  No -- empty /var/lib/bluetooth/.../<dev>
   Other host hogging link    No -- confirmed no other paired/connected
                                   device
   USB autosuspend on btusb   No -- power/control: on,
                                   runtime_status: active
   Wi-Fi/BT antenna coex      No -- fails identically with `nmcli radio
                                   wifi off`
   Stale BlueZ device cache   No -- persists after `bluetoothctl remove`,
                                   fresh discovery, full daemon restart
   Stale kernel HCI state     No -- persists after modprobe -r/+ btusb
   Discovery transport (LE)   Not it -- explicitly using `scan bredr`,
                                   speaker appears reliably


RELATED CONTROLLER QUIRK IN DMESG (probably unrelated)
------------------------------------------------------

   Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is 
advertised, but not supported.

This is a known MT7922 firmware quirk for ESCO setup and would not 
affect BR/EDR ACL paging. Listing only in case it is relevant.


ATTACHMENTS
-----------

   bt.snoop -- full btmon capture covering the failing pair attempt
               (sudo btmon -w /tmp/bt.snoop, captured during
               `bluetoothctl scan bredr ; pair 40:EF:4C:E0:B6:7B`).


OPEN QUESTION FOR MAINTAINERS
-----------------------------

Is hci_create_connection() (or whichever code path the kernel's 
mgmt_pair_device ends up calling) expected to look up the inquiry cache 
for the target BD_ADDR and pull PageScanRepetitionMode / clock_offset 
from there? Or is the userspace MGMT Pair Device (0x0019) opcode 
expected to carry these parameters?

If the latter, this could equally be a BlueZ userspace bug not 
forwarding inquiry data into the mgmt call. The trace above shows the 
inquiry data reaching the kernel; whether it survives into the 
create-connection path is the open question.

Have a great day,
Jacob Mills

--------------6maeGXD3NjsnXABZVqqhu50K
Content-Type: application/octet-stream; name="bt.snoop"
Content-Disposition: attachment; filename="bt.snoop"
Content-Transfer-Encoding: base64

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

--------------6maeGXD3NjsnXABZVqqhu50K--
