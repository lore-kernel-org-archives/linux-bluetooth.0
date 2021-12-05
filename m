Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FA1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Dec 2021 07:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhLEHJD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Dec 2021 02:09:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56100 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhLEHJD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Dec 2021 02:09:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CA3D60F2D
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Dec 2021 07:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E6DAC341C8
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Dec 2021 07:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638687935;
        bh=n1TYJNSMzzLHhDtH/uXqJbi8i2XtmhQIchVqUluCTHc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mAt8Eegp03NhWo3VzhkBNuA9WhsHmLw0Sw4Ji24jWHHytwvj7/EonbkHZyLJti0bO
         QgvLyfALUThsjlrdnuLT+PFbkFEf7vDP/8Iz38UPWOffxED/II1ZFtYJIQnJDZcgBb
         QzlE4gy9PSTsb1wXGpHKb/WtCjRzkSD5ibwRYt9R2i8oOK5mt0dTpM+FwIYOE+XPLZ
         Z/NVYkbNC/oKGH7ow6ehlWDLBmi358n2k1TYtNUjlRCN1yhgPpm5wF74HawePqHBzf
         kHI8xoDPDq3u4Q1PkNbWC3yDkxENjcyvxfFSItrtvkuD5q7A7NGt058FSrhcpOjwZr
         ED+g0SrZpPwmg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 7A5BD611C1; Sun,  5 Dec 2021 07:05:35 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Sun, 05 Dec 2021 07:05:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nozzy123nozzy@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215167-62941-XBh6sjlOas@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

Takahide Nojima (nozzy123nozzy@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |nozzy123nozzy@gmail.com

--- Comment #12 from Takahide Nojima (nozzy123nozzy@gmail.com) ---
 For reference purposes only, I will report here about the experience of=20
similar problem with my laptop. My laptop  also has the intel AX201 and=20
the dimidecode command shows  as below,=20
---------------here------------
Handle 0x0011, DMI type 1, 27 bytes
System Information
        Manufacturer: HP
        Product Name: HP EliteBook 830 G7 Notebook PC
        Version:=20=20
        Serial Number: XXXXXX
        UUID: xxx-xxx-xxx-xxx
        Wake-up Type: Power Switch
        SKU Number: 20L69PA#ABJ
        Family: 103C_5336AN HP EliteBook
---------------here-----------

 I checked some kernel versions whether AX201 Bluetooth works or not.

As a result, my situation was a little different,
  1. The AX201 works fine in Linux-5.14.16,Linux-5.15.5,Linux-5.16-rc2=20
=E3=80=80=E3=80=80=E3=80=80and Linux-5.16-rc3.
  2. It doesn't work in Linux-5.15.3 and Linux-5.16-rc1.

 The Debian bug tracker reported a similar problem,
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1000403.
According to it, a  commit between 5.15.3 and 5.15.4 can improve=20
this problem.

=E3=80=80I'm not sure, but I guess the intel AX201 hardware has some versio=
ns,=20
and it causes whether the 5.15.5 and 5.16-rc3 works or not, for example.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
