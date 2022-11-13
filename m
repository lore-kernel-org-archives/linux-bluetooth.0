Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E68C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Nov 2022 07:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiKMHbv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Nov 2022 02:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMHbu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Nov 2022 02:31:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEB010559
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Nov 2022 23:31:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4F5DB80B24
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 07:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D299C433C1
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 07:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668324707;
        bh=ekuNKpUAD+gqbiHddEZ3ta9sLLZE0UTBEsqMft0ExVk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=n9+o0H6X1mSffYOI3MhXIuSZXHmrETkUXBPm8ZPzGlhMWlOGldSc4Tkwu+5oyjuY6
         o7ny/P7rkI9YRFO6AhV6r0yBYcMhReq4eij1tO+HM7dsaHrWz1Hq8OqRyYDrZddZxK
         ARNKDqBvHFCpPn5eRmelj53HVKq7wRk8UXGOYbLEgyYxyrSLHlwInpIZ0P4EaCZzxl
         w/rt/OQs4OI2hcSMz2FbkQxQd60EOq7TO9IiUDzRdAJfCaOoUmaq06IaAOLxNCa0e7
         SE/o2nvwjxavokHJdQJTaNEh43LYxwbWiaORBIQCDKzlTn+EbkJZ9pngTI+wlCltwl
         oC1YUryN4QPdw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 7E5D8C433E4; Sun, 13 Nov 2022 07:31:47 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216686] BUG: kernel NULL pointer dereference, address:
 0000000000000680
Date:   Sun, 13 Nov 2022 07:31:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: frc.gabriel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216686-62941-IIPMUBZzp9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216686-62941@https.bugzilla.kernel.org/>
References: <bug-216686-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216686

--- Comment #3 from frc.gabriel@gmail.com ---
Created attachment 303164
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303164&action=3Dedit
opcode failed

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
