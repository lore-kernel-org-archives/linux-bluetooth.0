Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09733358B6
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787253; cv=pass; b=HboCaba12uTInzPF2NhxaJ0LhSPCRGaDiUbplu4WUmo75XOU+r9oLVP49ZfPPQ5CdaSTM78Iw16GtpYgnA2ILs9+JUO+PpoLs6prxUQ/odwetziVSyRX8rM5GOeddPEtQZ/vZZFQCdnC4XBkfgkgHexT9LGlNAuO1BL1lmOJFA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787253; c=relaxed/simple;
	bh=DXhoLK4FnrpRwrC5rKZFMRycOLpu4T82SZ9UEfvnDVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGwr15s3LFf6wChlEIi+4RsK05q5IhZg3kM5aRie47ahOghCZN4HtIx5e1j83GrqJ0Mau09cyDrSqxehVDDOSs7IyGHemTcflsmD4uW5xtO8OdjLdPQ8Trw8j+67VvciI0Cwvc4FGZ9crDNud0VZC8smZPjYRZeDMFmibQaXZtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbkC1vWQ; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbkC1vWQ"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65dead17c24so4826552d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 12:34:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778787251; cv=none;
        d=google.com; s=arc-20240605;
        b=Wqa3017as3/my2SWbQmx/JI8me6YhsEnjDE2pNx1Ic9X2551ysF8KaystEPAKXKxpK
         GGpvcNeBGKqNIXoOgiUtUzeVZ2QnJPrR5bV0LwH2V214H/MFiyyn/wee9KsrIWoUuiHk
         UfGd6fio2xu7kVyNu7H+StdvMZ5tGfmnjZAnaN0a1+h5IaWrJYjdR3C7SxvyHp8aBSrF
         DDN0QDrZ6fypb1lAdWMV0MKQ7MvP28YdcII5BN9cx9KhPDmwxStnNidqEULidGhw8oEh
         tkCOtoOmucIza7bTcR+pJRT4GCcUqftBR/T20oZ7rOH9xUGXUIcrD0BiiQQgFKNI2wo0
         Ph/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=snb71hatP3OMKDy7RvE/JtxydJQab//alQP/9KH0A00=;
        fh=WMdNOFmsSCK/eVw66zXEWowlQF9WO93DwUexvs5MZi0=;
        b=SzN8es8jXf7/htss01C20mW/RBT67kjZ287I+hCPruOSzW+FLI8sDPLQdzfgyYjEA4
         +KvvMN/2QfctfKi8adaYmhuhAityXjOkfMQ0C4GwclSdMFi2IawbSzgS/YFz/pgx8Wdk
         lXGkRI6o3IxMqA1bQokO87KaCeYRmNdMNAj+Zwrus5v56ZLnjr1gXHDpYcRy1+CmNRuS
         yXQXErhbwI8SCau8u/jYkDhWGCd8p1HAPz0nxsuejtC8mHD8DEXL8Wxm88trHY5fs9G6
         ocX2QJrUPVwS0RyB8ar5oVylYiezzxkpa2OB86TziZC0eibnHuD2oyjw22vRzf91F+zg
         qr4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778787251; x=1779392051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snb71hatP3OMKDy7RvE/JtxydJQab//alQP/9KH0A00=;
        b=XbkC1vWQnK2XcShUgDhIJ/x7LeiFKy1BMag3iVrjDsgIU6cw/PBQ0STIrj56P6rJzy
         A0Hrx+2mJCBJ3TmIpM845GCi4HmI2SVSSwdrNORGX7NPROTV5dcTJEi74SPyxdwfz6SG
         g+ZQ8PxiMJickz+k2xjfGE11VShBXP2V1bGcnvDRkAi5TLBsWszbDDfUON/b4KzxfrS8
         7zb+57f/9Mu00kUT4T0I+mGFyhVPmHn4jFICE/yuNDhsn/5KmJcaJgYAhPbiIaPBM0NG
         35ZZA11wKSiMWoOOvqa2/ZmsxDLHjFI1ivMuk5LfiWlPju3OZCgDg/v2QlAS2/Hg6juX
         b0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778787251; x=1779392051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=snb71hatP3OMKDy7RvE/JtxydJQab//alQP/9KH0A00=;
        b=N5X3iYqsrKI6lY5FfgPpJipw+9Gq8CirwZNZswbVeHNygK0JGHlOUrG4TyvSnCvSm6
         aUA5EtqVpxePYxI2pi5Exo18XC+ZrhQLO1jF3II37ILF/VhX9U6tB8dBqBOnFT/1k37V
         5N3N009fsOYOs3IXJeME98D30qHVszAgSgRWRTmvDxxCY612myqLwu+jFvMXt2YyOiZ5
         sBfw1Z9ywUmBgLud6eiAnubkj2Ge4P2k6ToZzaef+jH4uk9AfK7oq7fKi/9sk09H97e/
         mze2g0XKEuPg7n0hkThDBETQ7bPtISrIe80qmOfYSv3WA1AAYyxLdHOR3gxYpj1bXqSk
         uLww==
X-Gm-Message-State: AOJu0YzK1LjlZNEhlNVrLfCXrsLuknF3u2EN/o9It/TBNnqethEp634E
	QsDy/3y9IT6F6UjLU+AglDWxs2OsqmrOTSg9BLm7BhbuhyKAC2CA6ZylVk9MrnUZl0yhB+JNwEf
	0d6vfuU2ikWfFACQUk6zkhmvbXJkYM5k=
X-Gm-Gg: Acq92OFS/3eldTtWNNmdCDi2IJUpRA+Cucu9sR+HV4MAOqR8mABKtzjiX2wV9O62qno
	STMaclqepuibO5qeBzMQ2FLxRl1SXJ9wr0fesbOQfnyjcHC1CMmDiGV8wGMJIlSdxyiPM0C+Yd3
	kXlF1VeslE95xlk2tuWVCmWciLmTE2vN2VSTXnx2Tfp6vvNLCzuvPEq3qwzAKnG2N1VdeYAE4hM
	4IdXru5qxN80S3bInJVYFB1GgL2fpYUMosDCsX8/VgBNWfwBUg0vxFyGbcUWtXfD5MtZ0QsGrAt
	WsZHxPlFHPANOK6d/WNnNPSqqz5wp/ER/ySULJ2goGwmoQ3KSowiofxzQUkM7QkHjqtCp96jVOI
	QHOlm
X-Received: by 2002:a05:690e:14c4:b0:64e:f106:60ea with SMTP id
 956f58d0204a3-65e22807f82mr678737d50.44.1778787250592; Thu, 14 May 2026
 12:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6890c968-f662-40db-a30d-775bc6593494@gmail.com>
In-Reply-To: <6890c968-f662-40db-a30d-775bc6593494@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 May 2026 15:33:59 -0400
X-Gm-Features: AVHnY4JAaX45zj8keeX8WShlhZSXD7mLSYqwAqZI-5MpNjlIdEsepkRUKPazf7c
Message-ID: <CABBYNZ+0513Z7YZ9aVU_ebv5V981HmFobiv-Us1HV11EvAzXdQ@mail.gmail.com>
Subject: Re: Bluetooth: HCI Create Connection issues default page-scan
 parameters (R2, clock_offset=0) instead of values from inquiry cache, causes
 Page Timeout on BR/EDR audio device
To: Jacob Mills <jacobmills1997@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jacob,

On Thu, May 14, 2026 at 3:10=E2=80=AFPM Jacob Mills <jacobmills1997@gmail.c=
om> wrote:
>
> Hi,
>
> Filing this for a 100%-reproducible BR/EDR pairing failure on a recent
> Fedora kernel against a 2015-era audio speaker, with btmon evidence
> pointing at the kernel's HCI Create Connection path ignoring
> inquiry-cache page parameters. The same physical hardware pairs the same
> speaker successfully on Windows.
>
>
> SUMMARY
> -------
>
> When pairing a BR/EDR-only audio device that advertises Page Scan
> Repetition Mode R1 with a non-zero clock offset, the kernel issues HCI
> Create Connection with default values (R2, clock_offset=3D0). The page
> never reaches the remote device and Connect Complete returns with status
> Page Timeout (0x04) after the default 5.12s page timeout. Pairing fails
> every time. The inquiry that immediately preceded the pair attempt was
> observed by the kernel (HCI Event #3 below) and contained the correct
> page parameters, so the data was available to the host stack -- it just
> was not used in the subsequent Create Connection.
>
>
> AFFECTED SYSTEM
> ---------------
>
> Distribution     Fedora 44
> Kernel           7.0.6-200.fc44.x86_64
> linux-firmware   20260410-1.fc44
> BlueZ            5.86-4.fc44 (bluetoothd and bluetoothctl)
> Controller       MediaTek MT7922 (BlueZ manufacturer id 0x001d / 29)
>                   USB ID 0489:e10d (Foxconn / Hon Hai), bcdDevice 0.01
>                   Combo card (BT + Wi-Fi on shared antennas; Wi-Fi was
>                   on 5 GHz at time of failure; also reproduces with
>                   Wi-Fi disabled)
> Controller MAC   D8:B3:2F:44:DC:DE
> Remote device    Edifier Luna Eclipse HD (e25HD) powered speaker
>                   (BR/EDR-only, A2DP Sink + AVRCP, manuf-id "Fihonest")
> Remote MAC       40:EF:4C:E0:B6:7B
>
> Three kernels are installed locally; a regression test on
> 6.19.10-300.fc44 has not yet been run. Happy to do that and follow up.
>
>
> REPRODUCIBILITY
> ---------------
>
> 100% reproducible on this kernel/firmware/hardware combination across:
>
>    * bluetooth.service restart
>    * modprobe -r btusb && modprobe btusb (full firmware reload, confirmed
>      by matching "usbcore: deregistering/registered new interface driver
>      btusb" pair in dmesg)
>    * bluetoothctl power off/on (HCI Reset)
>    * USB autosuspend disabled
>      (echo on > /sys/bus/usb/devices/1-6/power/control)
>    * Wi-Fi radio disabled (rules out MT7922 BT/WiFi antenna coex)
>    * Fresh 60-second speaker power cycle
>    * Fresh bond state on the laptop (no on-disk bond record)
>
> The Linux side discovers the speaker reliably via `scan bredr` at strong
> signal (-55 to -58 dBm). Only the page-following-pair fails.
>
>
> REPRODUCER
> ----------
>
> In a single bluetoothctl session, with the speaker freshly power-cycled
> and in BT input mode (solid blue LED), no other host bonded to the speake=
r:
>
>      [bluetoothctl]# scan bredr
>      ... [NEW] Device 40:EF:4C:E0:B6:7B EDIFIER Luna Eclipse HD
>      ... [CHG] Device 40:EF:4C:E0:B6:7B RSSI: 0xffffffc8 (-56)
>      [bluetoothctl]# scan off
>      [bluetoothctl]# pair 40:EF:4C:E0:B6:7B
>      Attempting to pair with 40:EF:4C:E0:B6:7B
>      Failed to pair: org.bluez.Error.ConnectionAttemptFailed
>
> The same outcome occurs with `connect` (post-bond) -- both surface as
> the same HCI Page Timeout underneath.
>
>
> THE BUG, FROM BTMON
> -------------------
>
> The relevant excerpt (full snoop file attached):
>
>    > HCI Event: Extended Inquiry Result (0x2f) plen 255  #3   35.314602
>            Num responses: 1
>            Address: 40:EF:4C:E0:B6:7B
>            Page scan repetition mode: R1 (0x01)   <-- speaker advertises =
R1
>            Class: 0x240428 (Audio/Video, HiFi Audio Device)
>            Clock offset: 0x3f03                   <-- non-zero, valid
>            RSSI: -58 dBm (0xc6)
>            Name (complete): EDIFIER Luna Eclipse HD
>            Service UUIDs: A2DP Sink/Source, AVRCP Target/Controller
>
>    [ ~12s of `scan off`, MGMT Add Device, MGMT Pair Device ]
>
>    < HCI Command: Create Connection (0x01|0x0005) plen 13  #11  47.576809
>            Address: 40:EF:4C:E0:B6:7B
>            Packet type: 0xcc18
>            Page scan repetition mode: R2 (0x02)   <-- kernel uses R2,
>                                                       ignoring cache R1
>            Page scan mode: Mandatory (0x00)
>            Clock offset: 0x0000                   <-- kernel uses 0,
>                                                       ignoring cache 0x3f=
03
>            Role switch: Allow peripheral (0x01)
>
>    > HCI Event: Command Status (0x0f) plen 4 #12  47.577608
>            Create Connection (0x01|0x0005) ncmd 1
>            Status: Success (0x00)
>
>    > HCI Event: Connect Complete (0x03) plen 11  #13  52.698868
>            Status: Page Timeout (0x04)
>            Address: 40:EF:4C:E0:B6:7B
>            Link type: ACL (0x01)
>                                                   <-- 5.122s after
>                                                       Create Connection
>                                                   <-- =3D default Page Ti=
meout
>                                                       (0x2000 slots)
>
> The kernel issued Create Connection 12 seconds after it observed the EIR
> for this address. The inquiry cache entry should still have been valid
> (default eviction is 60s). Either the cache is not being read on this
> code path, the inquiry result is not populating the cache, or the cached
> PageScanRepetitionMode / clock_offset fields are not being plumbed into
> hci_acl_create_connection() (or equivalent).
>
> For a device using R1 (1.28s page-scan-window cycle) the host-side hint
> should reflect that so the controller can size its page train timing
> appropriately; pairing with default R2 + null clock offset against an R1
> device with a non-zero clock offset means the page train is misaligned
> and the page misses entirely within the 5.12s window. On Windows, with
> the same physical controller, pairing succeeds -- so Windows clearly
> does plumb the inquiry-result page parameters into its page command.
>
>
> SURFACE-LEVEL ERRORS THIS PRODUCES
> ----------------------------------
>
> Depending on call site, BlueZ-userspace remaps the underlying HCI Page
> Timeout (status 0x04) to different D-Bus errors, which can mislead
> triage:
>
>    bluetoothctl pair       -> org.bluez.Error.ConnectionAttemptFailed
>    bluetoothctl connect    -> org.bluez.Error.Failed
>                                br-connection-page-timeout
>    bluetoothd (audio path) -> avdtp_connect_cb() connect to
>                                40:EF:4C:E0:B6:7B: Host is down (112)
>
> All three are the same HCI Page Timeout under the hood.
>
>
> WHAT WAS RULED OUT
> ------------------
>
>    Speaker hardware           OK -- pairs with other devices, pairs on
>                                    Windows on the same physical host
>    MT7922 controller hardware OK -- works on Windows; BR/EDR scan finds
>                                    the speaker at -55 to -58 dBm
>    Stale kernel / firmware    No -- both current (linux-firmware
>                                    20260410, kernel 7.0.6)
>    Bond conflict / stale key  No -- empty /var/lib/bluetooth/.../<dev>
>    Other host hogging link    No -- confirmed no other paired/connected
>                                    device
>    USB autosuspend on btusb   No -- power/control: on,
>                                    runtime_status: active
>    Wi-Fi/BT antenna coex      No -- fails identically with `nmcli radio
>                                    wifi off`
>    Stale BlueZ device cache   No -- persists after `bluetoothctl remove`,
>                                    fresh discovery, full daemon restart
>    Stale kernel HCI state     No -- persists after modprobe -r/+ btusb
>    Discovery transport (LE)   Not it -- explicitly using `scan bredr`,
>                                    speaker appears reliably
>
>
> RELATED CONTROLLER QUIRK IN DMESG (probably unrelated)
> ------------------------------------------------------
>
>    Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is
> advertised, but not supported.
>
> This is a known MT7922 firmware quirk for ESCO setup and would not
> affect BR/EDR ACL paging. Listing only in case it is relevant.
>
>
> ATTACHMENTS
> -----------
>
>    bt.snoop -- full btmon capture covering the failing pair attempt
>                (sudo btmon -w /tmp/bt.snoop, captured during
>                `bluetoothctl scan bredr ; pair 40:EF:4C:E0:B6:7B`).
>
>
> OPEN QUESTION FOR MAINTAINERS
> -----------------------------
>
> Is hci_create_connection() (or whichever code path the kernel's
> mgmt_pair_device ends up calling) expected to look up the inquiry cache
> for the target BD_ADDR and pull PageScanRepetitionMode / clock_offset
> from there? Or is the userspace MGMT Pair Device (0x0019) opcode
> expected to carry these parameters?
>
> If the latter, this could equally be a BlueZ userspace bug not
> forwarding inquiry data into the mgmt call. The trace above shows the
> inquiry data reaching the kernel; whether it survives into the
> create-connection path is the open question.
>
> Have a great day,
> Jacob Mills

It took longer to read all this than to just check if we perform
inquiry caching:

https://github.com/bluez/bluetooth-next/blob/workflow/net/bluetooth/hci_syn=
c.c#L6945
https://github.com/bluez/bluetooth-next/blob/workflow/include/net/bluetooth=
/hci_core.h#L905

This is old code that hasn't been touched for ages, before MGMT
interface was introduced, so I have no idea how it wouldn't use the
cached values, except perhaps if there is a reset that flushes the
cache or something similar.

--=20
Luiz Augusto von Dentz
