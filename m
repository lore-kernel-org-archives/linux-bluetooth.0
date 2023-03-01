Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097C6C7EE2F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 15:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCAPyH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Mar 2023 10:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCAPyE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Mar 2023 10:54:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E2C12869
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Mar 2023 07:53:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B04AB80EF8
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Mar 2023 15:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5088C4339E
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Mar 2023 15:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677686029;
        bh=5gS0ZK78rqcuBYAlkIDpqitvfFcAD1PIC/Jai/ZnTOE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Vk6v8HBl+ctqJQYzx+jFu5+5NrntasR2nTDHYGvF+7O033oK0tBzTiNXQWN0Fgahc
         Z33w1oExFcfsDsuPgMWMJPcpisMqgf3M8oK3XP/2JOR1QYMjW8ZbyN/p2mhnRtZ0Cv
         IENxZ7pSZXrXlfhiefyECZKGil2gfI7WIIYPVqqmeU2CnS5awiRhxAiIEv1Btej8EB
         vRx1vYHmprTsBgyfT5rMSVXxvrzt9kBOwVakBqD/0Jd8jw2b0/2JHLq4Uz0Ion/dE3
         Cuakj0nsWr5yzfjkgimUvRxIRUlTqrlG3ftPacv6SMkc0cZne57WWUI73erk85NAXD
         FcDLlfeSnyEZQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C9E55C43143; Wed,  1 Mar 2023 15:53:49 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217023] [Intel AX200] hci0: Malformed MSFT vendor event: 0x02
Date:   Wed, 01 Mar 2023 15:53:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: thebagarius@duck.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217023-62941-8bnortQFbN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217023-62941@https.bugzilla.kernel.org/>
References: <bug-217023-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217023

Tanuj Bagaria (thebagarius@duck.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |thebagarius@duck.com

--- Comment #1 from Tanuj Bagaria (thebagarius@duck.com) ---
Same error, older hardware. see details below.

```
$ sudo dmesg
[   29.392310] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
```

```
$ uname -a
Linux jungle 6.1.14-hardened1-1-hardened #1 SMP PREEMPT_DYNAMIC Sat, 25 Feb
2023 13:15:09 +0000 x86_64 GNU/Linux
```

```
$ lspci
3c:00.0 Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)
```

```
$ lscpu
Intel(R) Core(TM) i5-7Y54 CPU @ 1.20GHz
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
