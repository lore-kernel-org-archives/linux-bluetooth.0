Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2742FC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 15:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E4060F6F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 15:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242882AbhHZPXc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Aug 2021 11:23:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232271AbhHZPXb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Aug 2021 11:23:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B781C60F6F
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Aug 2021 15:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629991362;
        bh=jCMhW7Q/pqOUWcaQ+sqIe1Ef2VDXlNJBhyPdFJBhkfw=;
        h=From:To:Subject:Date:From;
        b=sbF+Ff4fuzdcDNvMxPyzR71LlIVdg7b1j8imz2vpJhU1sKLxExmbrnpGC0uB6zQCd
         htGU1Rbg6aCkUpoFY1uvgoHwFKiyQqQgt30nPcFd3MqHD6xNqfV+Jn1jQfNzKg/SRO
         aB//p3oqI/bxCa5YQ8jC0/MPA7PAi9+fPR8Kq1tJgjyyD3ncrWAoyfVoILJ/CMRqyh
         dsRo0EXjjCrWlEfT3q42TvFycaHDAcbQmycax7+dvd+GwJzbdWLjLW33EfOBYrxgxR
         vmG+NPyDdPXTh7kkoNm4qD9I9zddwJsu6lBeHlcDuQp6eQu1SuNI2Hb0f2VDdZ1z3S
         fH/UeAYfQ4fsw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214187] New: Intel 7260 Chip Failures
Date:   Thu, 26 Aug 2021 15:22:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: igorm@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-214187-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214187

            Bug ID: 214187
           Summary: Intel 7260 Chip Failures
           Product: Drivers
           Version: 2.5
    Kernel Version: Linux 5.13.12-193.current x86_64
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: igorm@posteo.net
        Regression: No

Created attachment 298489
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D298489&action=3Dedit
Intel 7260 chip often fails

Hi,

At times, as I try to connect a Bluetooth device, the process fails and
Bluetooth functionality temporarily disappears from the system. It comes ba=
ck
after a reboot. I can see no consistency in these failures. Sometimes they =
just
happen, sometimes they don't.

These commands also bring Bluetooth functionality back. However, failures m=
ay
happen again.

```
sudo systemctl enable bluetooth
sudo systemctl start Bluetooth
```

Another Bluetooth-related problem is the system may stall during a reboot. =
This
happens rarely and the following message is displayed after a long pause:

[See the attached image.]

I am not entirely sure but the Bluetooth card is most likely: Intel AC 8260
IEEE 802.11ac Bluetooth 4.2 - Wi-Fi/Bluetooth Combo Adapter

It has been like this for the last several months. Earlier I had other simi=
lar
Bluetooth problems on and off. I keep my system updated. Right now I am usi=
ng:

* Solus OS 4.3 Fortitude
* Budgie DE 10.5.3-238 based on GNOME 40.3.0

Relevant terminal output:

```
user@pc ~ $ lspci | egrep -i --color 'network|ethernet'
[...]
01:00.0 Network controller: Intel Corporation Wireless 7260 (rev 6b)
user@pc ~ $=20
```

```
user@pc ~ $ dmesg | grep -i blue
[   19.751133] Bluetooth: Core ver 2.22
[   19.751153] Bluetooth: HCI device and connection manager initialized
[   19.751164] Bluetooth: HCI socket layer initialized
[   19.751166] Bluetooth: L2CAP socket layer initialized
[   19.751169] Bluetooth: SCO socket layer initialized
[   20.068652] Bluetooth: hci0: read Intel version: 370710018002030d57
[   20.068657] Bluetooth: hci0: Intel device is already patched. patch num:=
 57
[   20.084589] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   20.084595] Bluetooth: BNEP socket layer initialized
[   35.947535] Bluetooth: RFCOMM TTY layer initialized
[   35.947545] Bluetooth: RFCOMM socket layer initialized
[   35.947552] Bluetooth: RFCOMM ver 1.11
[16800.174315] bluetoothd[785]: segfault at 70 ip 000000000041ce1f sp
00007ffe30709d30 error 4 in bluetoothd[40b000+ae000]
user@pc ~ $
```

Could this be fixed?

Thanks.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
