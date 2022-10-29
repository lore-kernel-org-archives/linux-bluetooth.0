Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E84C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Oct 2022 14:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJ2OnM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Oct 2022 10:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2OnL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Oct 2022 10:43:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD872AC45
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 07:43:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 004E9B80D28
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 14:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE506C4FEE4
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 14:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667054586;
        bh=bkEsW+7CWX4ObRDqvJS926ZQeEYmC16jSghn2YAURSY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=je/RlCtTi7VUEPrxYmfF0eIyxB5i8aam0iMPz+CMcCh4KwGlZEeqihmzvDoCMNh0p
         dLV7BriqyX0pS9/XDQnNxV/viMNaHRIIzm81fmU8A/B1ZPuzQLGFAWj7NsE3AQKnLh
         Rrt/iLC9EhkKJn9RYgLFI+CMFb1j2wNorddw9kttgEPsF4qK2ckg59uV/C3xR50kjA
         aEcAJ7zDaKoCx2fN7uVZOwqReuwujok1tlbNYsO6OhI8/Tnuo9K26h70gaOu4SAVMM
         pgb5FXbUDtplwBtqECyLSxEfPso+qLEVmu1U+g7RvKS7t31bOP18oGBEqBUG4Okyzy
         EVu6pqU4PAAuA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9F5D3C433E7; Sat, 29 Oct 2022 14:43:06 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 29 Oct 2022 14:43:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: swyterzone@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-be4ZPlD6XL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #242 from Swyter (swyterzone@gmail.com) ---
I think this patch series by a Qualcomm engineer essentially removed my
quirk/workaround because, uh, they thought it was unnecessary:

https://patchwork.kernel.org/project/netdevbpf/list/?series=3D661703&archiv=
e=3Dboth&state=3D*

He argues that the quirk is not necessary because the code should check if =
the
dongle says if it's supported or not.
The problem is that for these Chinese CSR clones they say that it would wor=
k,
but it's a lie. Take a look:

=3D New Index: 00:00:00:00:00:00 (Primary,USB,hci0)=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
[hci0] 11.272194
=3D Open Index: 00:00:00:00:00:00=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
[hci0] 11.272384
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0         =
 #1
[hci0] 11.272400
> HCI Event: Command Complete (0x0e) plen 12                               =
 #2
> [hci0] 11.276039
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 5.0 (0x09) - Revision 2064 (0x0810)
        LMP version: Bluetooth 5.0 (0x09) - Subversion 8978 (0x2312)
        Manufacturer: Cambridge Silicon Radio (10)
...
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0          =
 #5
[hci0] 11.648370
> HCI Event: Command Complete (0x0e) plen 68                               =
#12
> [hci0] 11.668030
      Read Local Supported Commands (0x04|0x0002) ncmd 1
        Status: Success (0x00)
        Commands: 163 entries
          ...
          Read Default Erroneous Data Reporting (Octet 18 - Bit 2)
          Write Default Erroneous Data Reporting (Octet 18 - Bit 3)
          ...
...
< HCI Command: Read Default Erroneous Data Reporting (0x03|0x005a) plen 0  =
#47
[hci0] 11.748352
=3D Close Index: 00:1A:7D:DA:71:XX=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
[hci0] 13.776824


As you can see in the `btmon` dump our dongle stops responding, it dies aft=
er
we ask that. So thanks for deleting my fix, absolutely surreal.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
