Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFF72931D7
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897438; cv=none; b=UTAKzm7Z04lzZanFrevFa+aMBZByxYO1WnN22noHWyeVs6KsZ8Cs+7pbjPGtuxiWw+36Fcuxo5aI4ItmL/gl7dXn86LFMoLZya28qaV3uAJrSP9onikjD0UffBLUqHEZyd/HeOKuomNANNK4j7+S8VMlyjW5pULJkZ9ub0kBYbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897438; c=relaxed/simple;
	bh=Pc8rDAq1TuSnFLe3FJa/b+Krm6cAjArYeYR4GKMBOZU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tNgv2/OrdPraDhqvyK4sV2sL0yFRFigQtHbjNukDYoVukwDJ2i0eWnu73ZOtfyqL3Q7xNoTAPd6jVrOku/kWAB8nYgG1nE8rcgp9n+3wzA5lToO7pB5KK/czxFZXsgpRuOPA0EFdQEdvExAtFThcsKUa0yGebe8ryxvsG9lSzzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ln4IJRvX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ln4IJRvX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96DF4C19425
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 12:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784897437;
	bh=Pc8rDAq1TuSnFLe3FJa/b+Krm6cAjArYeYR4GKMBOZU=;
	h=From:To:Subject:Date:From;
	b=Ln4IJRvXJuDUkz4gW4+1efxI5gW3gFR665hGg2mrxwyF/LnMtpLcxe2EQjEUWBMEG
	 iB+vmHjlmhcftM/CIBU/z7DyAqi04KL7+EPZuBfY5fEDlNWzq/U/AEFzEZPDIUSkyP
	 k9bJun2cIrdUq89RETaDqG3AsHHSPXdYwVXtFGOjyPBi96JWuv4/WEwTbxCoeJzOv1
	 fVt2OMIKKNTVyd51alBv2abKosJHMi+r9Gwsn4z9NRsVJGd+xsNDQLzGFbwHaaEhIo
	 le2/uctJDMuM93SudnfzEFhm3K/Lm4yeKGHHGeMvsOvelBKMssf+TKQX026MAP/j0r
	 Mt0z2hyPKGdww==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7627EC433E1; Fri, 24 Jul 2026 12:50:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221783] New: Bluetooth: new-device pairing consistently fails
 on Intel AX211 due to ~20s delay between connect and Authentication Requested
 (WiFi/BT coexistence?)
Date: Fri, 24 Jul 2026 12:50:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: galagann@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221783-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D221783

            Bug ID: 221783
           Summary: Bluetooth: new-device pairing consistently fails on
                    Intel AX211 due to ~20s delay between connect and
                    Authentication Requested (WiFi/BT coexistence?)
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: galagann@gmail.com
        Regression: No

Component: Bluetooth
Kernel version: 7.1.4-1-default (openSUSE Tumbleweed, reproduced also on
7.1.3-1-default before a kernel update)
Subsystem: Bluetooth 2.22 / bluetoothd (bluez) 5.82, MGMT ver 1.23

Hardware:
- Samsung Galaxy Book4 Pro
- Bluetooth/WiFi combo controller: Intel Corp. AX211 Bluetooth, USB ID
8087:0033
- Firmware: intel/ibt-0180-0041.sfi, DDC intel/ibt-0180-0041.ddc, Firmware
Version 42-20.25, Firmware timestamp 2025.20 buildtype 1 build 3882, SHA1
0x937bca4a

Summary
-------
Pairing with a NEW Bluetooth device (tested with a Sony SRS-XB2 speaker,
classic BR/EDR, Secure Simple Pairing / Just Works) reliably fails. The dev=
ice
is discovered fine, the ACL connection is established fine, but the host ta=
kes
roughly 20 seconds after connecting before it finally issues HCI Authentica=
tion
Requested. Peripherals with a short pairing-mode window (this speaker inclu=
ded)
time out and tear down the link at almost exactly the moment the host final=
ly
starts authentication, so pairing never completes. Devices that are already
paired reconnect normally and are not affected =E2=80=94 this only breaks t=
he FIRST
pairing of a new device.

The root cause appears to be the host, not the peripheral: two of the routi=
ne
post-connect HCI queries that bluetoothd/kernel perform before authenticati=
on
(Read Remote Supported Features, and especially Read Remote Extended Featur=
es)
take multiple seconds to complete instead of the expected few milliseconds.
This looks consistent with WiFi/Bluetooth coexistence contention on the AX2=
11
combo radio (WiFi was active during all failing attempts).

Confirmed workaround: disabling WiFi entirely before starting the pairing
attempt makes pairing succeed immediately. Re-enabling WiFi afterwards does=
 not
affect the already-paired device.

Steps to reproduce
------------------
1. Have WiFi connected/active on a machine with an Intel AX211 (or likely a=
ny
AX210/AX211/similar combo card).
2. Put a classic BR/EDR Bluetooth speaker with Secure Simple Pairing (Just
Works, no MITM) into pairing mode.
3. `bluetoothctl scan on`, wait for the device to appear, then `bluetoothctl
pair <MAC>`.
4. Observe: connection succeeds, but pairing fails a few seconds/tens of
seconds later.
5. Repeat with WiFi fully disabled: pairing succeeds.

Ruled out during diagnosis (i.e. NOT the cause here)
-----------------------------------------------------
- rfkill soft/hard block: adapter was never blocked.
- Stale driver state after suspend/resume: reproduced identically on a
completely fresh boot.
- Stale firmware/module state: `modprobe -r btusb && modprobe btusb` did not
change the behavior.
- Kernel/bluez version: reproduced on both kernel 7.1.3-1-default and
7.1.4-1-default (same bluez 5.82).
- Stale pairing cache: `bluetoothctl remove <MAC>` before each attempt did =
not
change the behavior.

Captured HCI trace (btmon) =E2=80=94 representative failing attempt (WiFi o=
n)
-----------------------------------------------------------------------
Timestamps are relative seconds within the btmon capture.

  < HCI Command: Create Connection (0x01|0x0005)                    #41=20
[t=3D11.656]
        Address: FC:A8:9A:20:16:33 (speaker)
        Clock offset: 0x0000            <-- note: inquiry had reported Clock
offset 0x5734 for
                                             this address a few seconds
earlier, but 0x0000 (unknown)
                                             was used for the actual Create
Connection. Possibly
                                             relevant to the slow
paging/negotiation below.
  > HCI Event: Command Status: Success                              #42=20
[t=3D11.658]

  > HCI Event: Connect Complete: Status Success, Handle 256          #44=20
[t=3D17.589]
        (~5.9s to connect: normal page/connection time)

  < HCI Command: Read Remote Supported Features                     #45=20
[t=3D17.589]
  > HCI Event: Command Status: Success                               #46=20
[t=3D17.590]
  > HCI Event: Read Remote Supported Features Complete: Success      #48=20
[t=3D21.444]
        (~3.9s for a command that normally completes in well under 100ms)

  < HCI Command: Read Remote Extended Features (page 1)              #49=20
[t=3D21.444]
  > HCI Event: Command Status: Success                                #50=20
[t=3D21.445]
  > HCI Event: Read Remote Extended Features Complete: Success        #51=20
[t=3D31.676]
        (~10.2s for a single extended-features page read =E2=80=94 this is =
the biggest
anomaly)

  < HCI Command: Remote Name Request                                 #52=20
[t=3D31.676]
  > HCI Event: Command Status: Success                                #53=20
[t=3D31.677]
  > HCI Event: Remote Name Req Complete:
        Status: Remote User Terminated Connection (0x13)              #54=20
[t=3D32.313]
        (name request never completes: the peripheral already disconnected =
by
this point)

  @ MGMT Event: Device Connected (Locally Initiated)=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20
[t=3D32.313]
  < HCI Command: Authentication Requested                            #55=20
[t=3D32.313]
  > HCI Event: Disconnect Complete:
        Reason: Remote User Terminated Connection (0x13), Handle 256  #56=20
[t=3D32.314]
        (peripheral disconnects in the same instant Authentication Requeste=
d is
finally sent)

  @ MGMT Event: Pair Device Command Complete: Status Disconnected (0x0e)

Total elapsed time from Create Connection to Authentication Requested: ~20.7
seconds.
Total elapsed time from ACL Connect Complete to Authentication Requested: ~=
14.7
seconds.
For comparison, on a healthy BR/EDR pairing this whole sequence normally
completes in well under a second.

With WiFi fully disabled, the same sequence (same speaker, same laptop)
completes normally and pairing succeeds on the first attempt, immediately a=
fter
Connect Complete.

Expected behavior
-----------------
Read Remote Supported/Extended Features and Remote Name Request should comp=
lete
within tens/low hundreds of milliseconds after a successful ACL connection,=
 as
they do with WiFi disabled, regardless of WiFi activity on the combo radio.

Additional info available on request
-------------------------------------
- Full btmon captures (several full attempts, before/after kernel update,
before/after WiFi disabled).
- lsusb / lsmod / dmesg excerpts for the AX211 firmware load sequence (clea=
n,
no errors, firmware loads and DDC parameters apply successfully every time).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
