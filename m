Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35AC37711
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Feb 2024 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422976; cv=none; b=psd549ecpU08lhE2jGRJAiwRYfS3TnRfyf1mVkvLnn8Kg5JtRVAskg9cYVetld36YZQJb7uLeiwAK3Se0unxcYkI0SJN+jGJrdO/5Sct3KhVXHnPXYnCArHCTGmp/+tAbYh0GyDhf1IGQn4ywpR9vpJDB8B86VzQYwnOFsj7VkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422976; c=relaxed/simple;
	bh=fPRMEA0/0q5KTJcPlPdITJQFh+srmgz816lGzb97hTg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aaxvJRr0mxkKBW1q8kFWOh6TAAWkJG0jw40bBKDbvyGE3k+RpvnmKDl8x1fJNOqyxL4248Nz17UFEQn+/3WTi1WF5l+DCP+ey+M2W9lQ+UOxMflsNkoO5IPsJ7O+e8vLLTQRboVFa2WWUAu2WjdIht93gzGZiMbgDcPYoWAO/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIc2tIi2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIc2tIi2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BED3C433F1
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Feb 2024 20:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707422976;
	bh=fPRMEA0/0q5KTJcPlPdITJQFh+srmgz816lGzb97hTg=;
	h=From:To:Subject:Date:From;
	b=KIc2tIi2JwI8n6KTWvS39TcLqHtTK+GvgNJHERPzjwHj7uUhSbAZ+qc8VozzJtjhR
	 hVFyqo5akKG7n29cz1xn36R34Fi4n9KBvJSY8SbWXeY9ky6umEyNXwTejGKlKxgqhc
	 SVLa7UWcK//UedMyBOj5sapgUc0uaQUpxJogfbkezfFoNlIyNvS4HATJPgjDPF3qK1
	 gBNR440xowelh4vuVFTiWPrgn+y+Rmj0j5BhIlOQUwEvhVybX+givxlnJqkK47r/Ml
	 Vo0P41eu7Xp0+nr7SIcUddOKumotBqwbEfLz9VZDYUxHmPPDj4ZBUWeqNSfkLsPunh
	 v1YXd8lDvoQpA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 20796C4332E; Thu,  8 Feb 2024 20:09:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218472] New: mt7921e bluetooth not working
Date: Thu, 08 Feb 2024 20:09:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@mail.cam-it.nl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218472-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218472

            Bug ID: 218472
           Summary: mt7921e bluetooth not working
           Product: Drivers
           Version: 2.5
          Hardware: Other
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: bugzilla@mail.cam-it.nl
        Regression: No

kernel:=20
Linux geekom 6.7.4-arch1-1 #1 SMP PREEMPT_DYNAMIC Mon, 05 Feb 2024 22:07:49
+0000 x86_64 GNU/Linux

relevant part of lsusb -vt:

/:  Bus 003.Port 001: Dev 001, Class=3Droot_hub, Driver=3Dxhci_hcd/12p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
    |__ Port 001: Dev 002, If 0, Class=3DHuman Interface Device, Driver=3Du=
sbhid,
1.5M
        ID 046d:c313 Logitech, Inc. Internet 350 Keyboard
    |__ Port 001: Dev 002, If 1, Class=3DHuman Interface Device, Driver=3Du=
sbhid,
1.5M
        ID 046d:c313 Logitech, Inc. Internet 350 Keyboard
    |__ Port 003: Dev 003, If 0, Class=3DHuman Interface Device, Driver=3Du=
sbhid,
12M
        ID 046d:c52b Logitech, Inc. Unifying Receiver
    |__ Port 003: Dev 003, If 1, Class=3DHuman Interface Device, Driver=3Du=
sbhid,
12M
        ID 046d:c52b Logitech, Inc. Unifying Receiver
    |__ Port 003: Dev 003, If 2, Class=3DHuman Interface Device, Driver=3Du=
sbhid,
12M
        ID 046d:c52b Logitech, Inc. Unifying Receiver
    |__ Port 004: Dev 004, If 0, Class=3DHuman Interface Device, Driver=3Du=
sbhid,
1.5M
        ID 0461:4d0f Primax Electronics, Ltd HP Optical Mouse
    |__ Port 007: Dev 005, If 0, Class=3DWireless, Driver=3Dbtusb, 480M
        ID 13d3:3585 IMC Networks=20
    |__ Port 007: Dev 005, If 1, Class=3DWireless, Driver=3Dbtusb, 480M
        ID 13d3:3585 IMC Networks=20
    |__ Port 007: Dev 005, If 2, Class=3DWireless, Driver=3D[none], 480M
        ID 13d3:3585 IMC Networks=20
/:  Bus 004.Port 001: Dev 001, Class=3Droot_hub, Driver=3Dxhci_hcd/4p, 1000=
0M
    ID 1d6b:0003 Linux Foundation 3.0 root hub

dmesg | grep -i bluetooth:
[root@geekom ~]# dmesg | grep -i bluetooth
[    3.541061] Bluetooth: Core ver 2.22
[    3.541584] NET: Registered PF_BLUETOOTH protocol family
[    3.542350] Bluetooth: HCI device and connection manager initialized
[    3.543226] Bluetooth: HCI socket layer initialized
[    3.543725] Bluetooth: L2CAP socket layer initialized
[    3.544517] Bluetooth: SCO socket layer initialized
[    3.907303] Modules linked in: snd_sof_utils snd_soc_hdac_hda
snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi
soundwire_generic_allocation soundwire_bus intel_tcc_cooling(-)
x86_pkg_temp_thermal snd_soc_core intel_powerclamp mt7921e(+) coretemp
snd_compress ac97_bus mt7921_common snd_pcm_dmaengine kvm_intel mt792x_lib
snd_hda_intel mousedev(+) hid_logitech_dj(+) mt76_connac_lib kvm
snd_intel_dspcfg mt76 snd_intel_sdw_acpi i915(+) irqbypass snd_hda_codec bt=
usb
mac80211 btrtl snd_hda_core processor_thermal_device_pci btintel drm_buddy
processor_thermal_device snd_hwdep rapl i2c_algo_bit vfat
processor_thermal_wt_hint btbcm snd_pcm spi_nor processor_thermal_rfim iTCO=
_wdt
fat ttm btmtk libarc4 processor_thermal_rapl intel_pmc_bxt intel_rapl_msr
intel_cstate mei_hdcp intel_rapl_common mei_pxp drm_display_helper ee1004
iTCO_vendor_support bluetooth snd_timer mtd processor_thermal_wt_req cfg802=
11
intel_uncore usbhid ecdh_generic mei_me i2c_i801 cec
processor_thermal_power_floor wmi_bmof snd pcspkr
[    3.908310] Modules linked in: snd_sof_utils snd_soc_hdac_hda
snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi
soundwire_generic_allocation soundwire_bus intel_tcc_cooling(-)
x86_pkg_temp_thermal snd_soc_core intel_powerclamp mt7921e(+) coretemp
snd_compress ac97_bus mt7921_common snd_pcm_dmaengine kvm_intel mt792x_lib
snd_hda_intel mousedev(+) hid_logitech_dj(+) mt76_connac_lib kvm
snd_intel_dspcfg mt76 snd_intel_sdw_acpi i915(+) irqbypass snd_hda_codec bt=
usb
mac80211 btrtl snd_hda_core processor_thermal_device_pci btintel drm_buddy
processor_thermal_device snd_hwdep rapl i2c_algo_bit vfat
processor_thermal_wt_hint btbcm snd_pcm spi_nor processor_thermal_rfim iTCO=
_wdt
fat ttm btmtk libarc4 processor_thermal_rapl intel_pmc_bxt intel_rapl_msr
intel_cstate mei_hdcp intel_rapl_common mei_pxp drm_display_helper ee1004
iTCO_vendor_support bluetooth snd_timer mtd processor_thermal_wt_req cfg802=
11
intel_uncore usbhid ecdh_generic mei_me i2c_i801 cec
processor_thermal_power_floor wmi_bmof snd pcspkr
[    4.024112] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.024119] Bluetooth: BNEP filters: protocol multicast
[    4.024122] Bluetooth: BNEP socket layer initialized
[    5.703433] Bluetooth: hci0: Opcode 0x0c03 failed: -110

something that might be relevant:
[    3.966807] mt7921e 0000:56:00.0: HW/SW Version: 0x8a108a10, Build Time:
20231120183400a
[    3.982396] mt7921e 0000:56:00.0: WM Firmware Version: ____000000, Build
Time: 20231120183441

I'm guessing the 'Opcode 0x0c03 failed' and 'Port 007: Dev 005, If 2,
Class=3DWireless, Driver=3D[none], 480M'   are to blame here?

I've done a lot of searching and troubleshooting, but couldn=C2=B4t find an=
ything
about this particular device ID:  13d3:3585=20=20=20

bluetoothctl  gives me:
[bluetooth]# list
[bluetooth]#=20
any other command will give: "no default controller available".

systemd bluetooth.service is enabled.

Let me know if more info is needed (I don=C2=B4t do this every day),  or if=
 I should
contact a maintainer directly.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
