Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853CECCFA0A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 12:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242995AbjIHMAG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 08:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238565AbjIHMAD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 08:00:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2921BE7
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 05:00:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2DB1C4167D
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 11:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174399;
        bh=iOJD02S/jfAio/q289+xispwxoGxrp1A9ERpYfKaLgI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=A1sM1MBLxqUSB4TDDDjfjZJ64Wbk+7vI8xf9PSaNUukZu7+wB4X1vlDDdNwq+x2Pu
         XV3P14oLpadDncz/4oU2P1+QPKSfdTMGB7DhEWAjR4fQqAKoANdPx2C1atdMWGX2Z5
         MCY46zsFUsdxFlFqC7uZN05s5teWGoZXEr6F+hPmwzQxR9mmiQPLLpuLkypDUcphY7
         JCYidwzggg8xX1SrNn9QB1XDaSjA+jNkaBDcgISVKCB4klBVvyLZRuV0DgM0FsMxWX
         DDxPr8/F3En/+sSmqtFOmahAYM4llMSGG8Dsd250j9US8brLYexa0qW7OVBWBU1iVn
         L4po0kegvZCSg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C40EEC53BCD; Fri,  8 Sep 2023 11:59:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Fri, 08 Sep 2023 11:59:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel@avee.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215167-62941-6kaftRD4zd@https.bugzilla.kernel.org/>
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

Arjan Veenstra (kernel@avee.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kernel@avee.org

--- Comment #54 from Arjan Veenstra (kernel@avee.org) ---
(In reply to matoro from comment #44)
> 6.0.12 is good
> 6.0.15 is bad
> 6.1.1 is bad
>=20
> Hardware:
> 07:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
>       Subsystem: Intel Corporation Wi-Fi 6 AX200NGW

I have the same controller on an Asus B550M-A (Wi-Fi):
09:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)

And I got the same error on kernel 6.5:
[   10.644458] Bluetooth: hci0: command 0xfc05 tx timeout
[   10.644685] Bluetooth: hci0: Reading Intel version command failed (-110)

6.4.14 is good
6.5.0 is bad
6.5.1 is bad

However, I checked back and for me kernel 6.0.14 and 6.0.15 both work, whic=
h=20
made me suspect a firmware difference. So I grabbed to latest version from=
=20
linux-firmware.git and tried again. Now 6.5.1 works again. So it seems the
issue
is specific to certain firmware / kernel combinations.

My previous firmware:
[    8.528961] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
[    8.528974] Bluetooth: hci0: Boot Address: 0x24800
[    8.528976] Bluetooth: hci0: Firmware Version: 126-5.22
...
[   14.992585] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-20-1-3.ddc
[   15.001435] Bluetooth: hci0: Applying Intel DDC parameters completed
[   15.006447] Bluetooth: hci0: Firmware revision 0.3 build 126 week 5 2022

The new firmware:
[    9.707218] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
[    9.707231] Bluetooth: hci0: Boot Address: 0x24800
[    9.707233] Bluetooth: hci0: Firmware Version: 255-255.255
...
[   16.179006] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-20-1-3.ddc
[   16.187931] Bluetooth: hci0: Applying Intel DDC parameters completed
[   16.192850] Bluetooth: hci0: Firmware revision 0.3 build 249 week 27 2023

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
