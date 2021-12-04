Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CE4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Dec 2021 00:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383787AbhLDAi5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 19:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354475AbhLDAin (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 19:38:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DEEC0611F7
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Dec 2021 16:35:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8E1462D62
        for <linux-bluetooth@vger.kernel.org>; Sat,  4 Dec 2021 00:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2077AC341C6
        for <linux-bluetooth@vger.kernel.org>; Sat,  4 Dec 2021 00:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638578118;
        bh=x7Wap73oXhbEqiQNs21XrniLELYrsxE8o+USyt9/xGA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IgTGEgdTofevjLMx+3RnVBO/1GTduVEEn1OSpd0km2IRVaIjVAdVPHZNv0rILaHI1
         IuV6i6xAqteX4Wnb963ItPcZXhxjpUPcDINCP0HQ2JjIBvEluUzo//Pf5+MQMyCJyQ
         zFEjhbfpo2beu0ts8G5Qq4E2xSDe7CPHJQCNiosrNbkc8C99Po9ELtkV9Ndpj6raU0
         tRSuKwTH7B7xPGqLjr/HMGqQXCy2b61OCOWTfZ+JkxB2/DwY4YwGI7l/vDsRdb4u8o
         Uj2uNyX/SWTIKKbvHtSTg21wyjriitIgk/rW5hbAXgsuruw3XrEOd8zmT079QXXjHZ
         jJdRz7k7ypxBg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 08DD160EE6; Sat,  4 Dec 2021 00:35:18 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203753] Bluetooth: hci0: advertising data len corrected
Date:   Sat, 04 Dec 2021 00:35:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pablo.bianchi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203753-62941-cKDeNozk26@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203753-62941@https.bugzilla.kernel.org/>
References: <bug-203753-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D203753

Pablo AB (pablo.bianchi@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pablo.bianchi@gmail.com

--- Comment #10 from Pablo AB (pablo.bianchi@gmail.com) ---
Ubuntu 20.04.3 LTS, kernel 5.4.0-91-generic, bluez 5.53-0ubuntu3.4

It happens to me *only* with Sony WH-1000XM4 (LE_WH-1000XM4). Tested with
journalctl -xef -p warning on one terminal and bt-device -l on other. All t=
he
other BT devices doesn't produce this.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
