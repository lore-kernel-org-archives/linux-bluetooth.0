Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5E0C47082
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 17:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE566135D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 17:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhFHRob (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233094AbhFHRob (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 13:44:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4C66C6135A
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jun 2021 17:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623174158;
        bh=xDxtUkpFqYuu4SqqQmVbFzYapz1lY8+fHkEEM1giqVk=;
        h=From:To:Subject:Date:From;
        b=WE4z+5MP2IoOB7V2LsY0ZiDvs3wJJysKyfxTLEgRiNrtwwhxtxC6oBRZbtffxMpPO
         19T4mdHVPDwh4esCnNBSoROJRNpLayVn8mpOYycCNyRpuPbJbM1rGjkpm0h6U22e33
         +Yi4R4MVbeb0HkXMnkq7cMrU8RA9EHMDMW8diVklxAK2A57hRli0OfD039FH4aeECb
         3MgGAYQb7aXVXxhtUqAOtV/ixFDeseo/Br3WgIB1bNU9W7XtBvt6LR4w0Nank+V10B
         GMe0Nzss2bAUqn1E/ZwGCCVewuN39lp7UMBWpQtYpooqN69dyDrpu5SwSrGOKf9dYE
         6Wabfrdqx0VxQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213369] New: Bluetooth Will Not Enable Intel AX200
Date:   Tue, 08 Jun 2021 17:42:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hankins.bruce@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-213369-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213369

            Bug ID: 213369
           Summary: Bluetooth Will Not Enable Intel AX200
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.11.22-180
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: hankins.bruce@outlook.com
        Regression: No

So a new issue that started recently, I enable my Bluetooth, but when I go =
into
settings it shows it's not enabled and when I click add device from the tra=
y it
says "Your Bluetooth adapter is not pairable". Not sure what's going on. I'=
ve
tried manually installing the driver, but no luck. Running on Solus 4.2 KDE
Plasma DE, stable repos, fully updated. Bluetooth/WiFi adapter is an Intel
AX200. Here is the output of commands I've tried so far. Manually installing
BlueZ 5.55-30 fixes the issue. Have tried installing BlueZ 5.56 with bluez-=
qt
and bluedevil rebuilt against the new BlueZ version and still have the same
issue.


`bruce@s145-15api ~ $ modprobe btusb
bruce@s145-15api ~ $ sudo systemctl enable bluetooth.service
Password:
bruce@s145-15api ~ $ sudo systemctl start bluetooth.service
bruce@s145-15api ~ $ systemctl is-enabled bluetooth
enabled
bruce@s145-15api ~ $ systemctl status bluetooth.service
=E2=97=8F bluetooth.service - Bluetooth service
Loaded: loaded (/usr/lib/systemd/system/bluetooth.service; enabled; vendor
preset: enabled)
Active: active (running) since Sun 2021-06-06 11:18:38 EDT; 6min ago
Docs: man:bluetoothd(8)
Main PID: 698 (bluetoothd)
Status: "Running"
Tasks: 1 (limit: 11730)
Memory: 1.9M
CPU: 30ms
CGroup: /system.slice/bluetooth.service
=E2=94=94=E2=94=80698 /usr/lib64/bluez/bluetooth/bluetoothd

Warning: some journal files were not opened due to insufficient permissions.
bruce@s145-15api ~ $ sudo systemctl status bluetooth.service
=E2=97=8F bluetooth.service - Bluetooth service
Loaded: loaded (/usr/lib/systemd/system/bluetooth.service; enabled; vendor
preset: enabled)
Active: active (running) since Sun 2021-06-06 11:18:38 EDT; 6min ago
Docs: man:bluetoothd(8)
Main PID: 698 (bluetoothd)
Status: "Running"
Tasks: 1 (limit: 11730)
Memory: 1.9M
CPU: 30ms
CGroup: /system.slice/bluetooth.service
=E2=94=94=E2=94=80698 /usr/lib64/bluez/bluetooth/bluetoothd
Jun 06 11:18:38 s145-15api systemd[1]: Starting Bluetooth service...
Jun 06 11:18:38 s145-15api bluetoothd[698]: Bluetooth daemon 5.58
Jun 06 11:18:38 s145-15api systemd[1]: Started Bluetooth service.
Jun 06 11:18:38 s145-15api bluetoothd[698]: Starting SDP server
Jun 06 11:18:38 s145-15api bluetoothd[698]: Bluetooth management interface =
1.19
initialized
Jun 06 11:18:38 s145-15api bluetoothd[698]: Failed to set mode: Blocked thr=
ough
rfkill (0x12)
Jun 06 11:18:46 s145-15api bluetoothd[698]: Endpoint registered: sender=3D:=
1.39
path=3D/MediaEndpoint/A2DPSink/>
Jun 06 11:18:46 s145-15api bluetoothd[698]: Endpoint registered: sender=3D:=
1.39
path=3D/MediaEndpoint/A2DPSourc>
bruce@s145-15api ~ $ rfkill
ID TYPE DEVICE SOFT HARD
0 wlan ideapad_wlan unblocked unblocked
1 bluetooth ideapad_bluetooth unblocked unblocked
2 bluetooth hci0 unblocked unblocked
3 wlan phy0 unblocked unblocked
bruce@s145-15api ~ $ blutoothctl
bash: blutoothctl: command not found
bruce@s145-15api ~ $ bluetoothctl
Agent registered
[bluetooth]# show
Controller A4:B1:C1:36:53:11 (public)
Name: s145-15api
Alias: s145-15api
Class: 0x00000000
Powered: no
Discoverable: no
DiscoverableTimeout: 0x000000b4
Pairable: yes
UUID: Message Notification Se.. (00001133-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control (0000110e-0000-1000-8000-00805f9b34fb)
UUID: OBEX Object Push (00001105-0000-1000-8000-00805f9b34fb)
UUID: Message Access Server (00001132-0000-1000-8000-00805f9b34fb)
UUID: PnP Information (00001200-0000-1000-8000-00805f9b34fb)
UUID: IrMC Sync (00001104-0000-1000-8000-00805f9b34fb)
UUID: Vendor specific (00005005-0000-1000-8000-0002ee000001)
UUID: Headset (00001108-0000-1000-8000-00805f9b34fb)
UUID: Headset AG (00001112-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
UUID: Phonebook Access Server (0000112f-0000-1000-8000-00805f9b34fb)
UUID: Audio Sink (0000110b-0000-1000-8000-00805f9b34fb)
UUID: Device Information (0000180a-0000-1000-8000-00805f9b34fb)
UUID: Generic Access Profile (00001800-0000-1000-8000-00805f9b34fb)
UUID: Audio Source (0000110a-0000-1000-8000-00805f9b34fb)
UUID: OBEX File Transfer (00001106-0000-1000-8000-00805f9b34fb)
Modalias: usb:v1D6Bp0246d053A
Discovering: no
Roles: central
Roles: peripheral
Advertising Features:
ActiveInstances: 0x00 (0)
SupportedInstances: 0x06 (6)
SupportedIncludes: tx-power
SupportedIncludes: appearance
SupportedIncludes: local-name
SupportedSecondaryChannels: 1M
SupportedSecondaryChannels: 2M
SupportedSecondaryChannels: Coded
[bluetooth]# agent KeyboardOnly
Agent is already registered
[bluetooth]# default-agent
Default agent request successful
[bluetooth]# power on
Failed to set power on: org.bluez.Error.Busy
[bluetooth]# scan on
Failed to start discovery: org.bluez.Error.NotReady`

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
