Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B59279792
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Sep 2025 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522961; cv=none; b=JRGpuDho3Op79s0Lo9Yq4jY9RiHqieR3fhcGxxDZLjWkiWX0QhVHge8rysE+11IBHH5+GNezyVpBiDCKEUvGyVeAziFRQfPJcoKM07+istL4ZCl0TDMVkKcwfxTHEij9wZOYmWVU/rkZzQie34hKn/2pyktnsvKq5k31M+egxpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522961; c=relaxed/simple;
	bh=GcpNcD4DuQym6drISMjJRJ0mOerd+o/2xcnyVPQa90E=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KqTCv3zj9RHCbidyvGYZJGs7/eoVATVPn5tt/pmRM2egw062IXhPt82m+6UN7EgqGbai85Qiy8Bn3HftwNzPXRqkWpwQqJoXMCR6hzSDKko3FzvkCgcCxCdbOKUu+MZBRFojA4+GO+TgHI9u6vj4qmp9q3EjYHDecte6i4MbbnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYRFSqPQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYRFSqPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6958C4CEEB
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Sep 2025 16:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757522960;
	bh=GcpNcD4DuQym6drISMjJRJ0mOerd+o/2xcnyVPQa90E=;
	h=From:To:Subject:Date:From;
	b=WYRFSqPQl8fgOJ40e45TPhwDV2BFTTt7cOmDXPFK+wYMMCh5ocSCvP4DOnWVEBiAh
	 l3/mB6TiZADpI8rBiG2h4XV+uSvmbXziemLYEyAOiPFDHB18anWvG6tsn0ntPwuj7O
	 UAGNig87kvM27Pa1P0j+2Wb40NxZwxeRP8O5C7TYtcnMCHFDE1UY5QKuNeXfGLMU5+
	 UfNJOhq+68SERs74v6wPgyaykyW2tXDQlwPBiFfdqvTvJuucffdQ/3HBgPUSxWmV/a
	 AJRNJ0joLil4CyQVXbt7nYBQ5WVBy/KKVLIUL1ye1RRwgHE2Dkr8eCJM36vQ2T8sSR
	 sFfkHY+iO+oBg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D95A2C3279F; Wed, 10 Sep 2025 16:49:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220560] New: Bluetooth adapter not found (MediaTek)
Date: Wed, 10 Sep 2025 16:49:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mattias.ohrn@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-220560-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220560

            Bug ID: 220560
           Summary: Bluetooth adapter not found (MediaTek)
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: mattias.ohrn@gmail.com
        Regression: No

Created attachment 308651
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308651&action=3Dedit
dmesg after booting kernel 6.16.5 OpenSuse TW

Bluetooth has stopped working completely for me on OpenSuse Tumbleweed. Whe=
n I
installed TW on my HP ZBook Ultra 14 G1a (AMD Strix Halo) around Aug 10 it
worked as expected. It stopped working at some point but I don't know when
because I wasn't using any BT devices for a couple of weeks, until Sep 8.

I was directed here by distro maintainers after filing a bug there:
https://bugzilla.opensuse.org/show_bug.cgi?id=3D1249369

I initially created this forum thread, which contains some more info:
https://forums.opensuse.org/t/bluetooth-adapter-not-found-used-to-work/1879=
41

I have tried the following kernel versions:
- 6.17-rc5
- 6.16.5
- 6.16.3
- 6.16.1
- 6.15.8 (version when I initially set up the machine)
- 6.12.45

I have also tried kernel-firmware-mediatek 20250804-1.1 in combination with=
 the
6.15.8 kernel (in addition to the 20250903-1.1 version) without seeing any
differences.

Some more info (all from after booting 6.16.5), and I'm also attaching full
dmesg from immediately after boot:

$ bluetoothctl show
No default controller available

$ sudo rfkill list all
0: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no
1: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no

$ sudo hwinfo | grep -E "blue|Blue|BLUE"=20=20=20
  P:
/devices/pci0000:00/0000:00:08.3/0000:c5:00.0/usb3/3-5/3-5:1.0/bluetooth/hc=
i0
  J: +bluetooth:hci0
  U: bluetooth
  E:
DEVPATH=3D/devices/pci0000:00/0000:00:08.3/0000:c5:00.0/usb3/3-5/3-5:1.0/bl=
uetooth/hci0
  E: SUBSYSTEM=3Dbluetooth
  E: SYSTEMD_ALIAS=3D/sys/subsystem/bluetooth/devices/hci0
  E: SYSTEMD_WANTS=3Dbluetooth.target
  E: SYSTEMD_USER_WANTS=3Dbluetooth.target
  P:
/devices/pci0000:00/0000:00:08.3/0000:c5:00.0/usb3/3-5/3-5:1.0/bluetooth/hc=
i0/rfkill0
  E:
DEVPATH=3D/devices/pci0000:00/0000:00:08.3/0000:c5:00.0/usb3/3-5/3-5:1.0/bl=
uetooth/hci0/rfkill0
  E: RFKILL_TYPE=3Dbluetooth
/devices/pci0000:00/0000:00:08.3/0000:c5:00.0/usb3/3-5/3-5:1.0/bluetooth/hc=
i0
/devices/pci0000:00/0000:00:08.3/0000:c5:00.0/usb3/3-5/3-5:1.0/bluetooth/hc=
i0/rfkill0
  bluetooth 1056768 15 bnep,btusb,btrtl,btintel,btbcm,btmtk, Live
0xffffffffc0ca1000
  rfkill 45056 10 mt7925e,hp_wmi,cfg80211,bluetooth, Live 0xffffffffc0c9e000
  crc16 12288 2 bluetooth,amdgpu, Live 0xffffffffc0c9c000
103: USB 00.2: 11500 Bluetooth Device
  Hardware Class: bluetooth
107: USB 00.0: 11500 Bluetooth Device
  Hardware Class: bluetooth
114: USB 00.1: 11500 Bluetooth Device
  Hardware Class: bluetooth

$ usb-devices | awk 'BEGIN{RS=3D""; FS=3D"\n"} /8c38/'=20=20=20=20=20
T:  Bus=3D03 Lev=3D01 Prnt=3D02 Port=3D04 Cnt=3D01 Dev#=3D  3 Spd=3D480  Mx=
Ch=3D 0
D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0e8d ProdID=3D8c38 Rev=3D01.00
S:  Manufacturer=3DMediaTek Inc.
S:  Product=3DWireless_Device
S:  SerialNumber=3D000000000
C:  #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D125us
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us

$ lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 002: ID 06cb:0106 Synaptics, Inc.=20
Bus 003 Device 003: ID 0e8d:8c38 MediaTek Inc. Wireless_Device
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 007 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 008 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub

$ ~ sudo journalctl -b -p 0..3
Sep 08 13:19:12 localhost kernel: platform AMDI0201:00: AMD-Vi: [Firmware B=
ug]:
No ACPI device matched UID, but 1 device matched HID.
Sep 08 13:19:25 localhost kernel: Bluetooth: hci0: Execution of wmt command
timed out
Sep 08 13:19:25 localhost kernel: Bluetooth: hci0: Failed to send wmt patch
dwnld (-110)
Sep 08 13:19:25 localhost kernel: Bluetooth: hci0: Failed to set up firmware
(-110)
Sep 08 13:19:33 localhost.localdomain firewalld[1902]: ERROR: NAME_CONFLICT:
new_policy_object(): 'docker-forwarding'
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987]
Error(s) opening ddc devices
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987] Er=
ror
EACCES(-13): Permission denied opening /dev/i2c-4
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987] Er=
ror
EACCES(-13): Permission denied opening /dev/i2c-5
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987] Er=
ror
EACCES(-13): Permission denied opening /dev/i2c-6
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987] Er=
ror
EACCES(-13): Permission denied opening /dev/i2c-7
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987] Er=
ror
EACCES(-13): Permission denied opening /dev/i2c-8
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987] Er=
ror
EACCES(-13): Permission denied opening /dev/i2c-9
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987] Er=
ror
EACCES(-13): Permission denied opening /dev/i2c-10
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987] Er=
ror
EACCES(-13): Permission denied opening /dev/i2c-11
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987] Er=
ror
EACCES(-13): Permission denied opening /dev/i2c-12
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987] Er=
ror
EACCES(-13): Permission denied opening /dev/i2c-13
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987] Er=
ror
EACCES(-13): Permission denied opening /dev/i2c-14
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987] Er=
ror
EACCES(-13): Permission denied opening /dev/i2c-15
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987] Er=
ror
EACCES(-13): Permission denied opening /dev/i2c-16
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987] Er=
ror
EACCES(-13): Permission denied opening /dev/i2c-17
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987] Er=
ror
EACCES(-13): Permission denied opening /dev/i2c-18
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987] Er=
ror
EACCES(-13): Permission denied opening /dev/i2c-19
Sep 08 13:19:35 localhost.localdomain org_kde_powerdevil[2987]: [  2987] Er=
ror
EACCES(-13): Permission denied opening /dev/i2c-20

I believe the first log line is related to the webcam support not yet being=
 in
the mainline kernel so I think that can be ignored here (I have seen that
message since day one).

Please let me know if I can provide more information.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
