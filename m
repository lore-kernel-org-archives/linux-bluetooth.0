Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8561AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Nov 2022 07:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiKMHbU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Nov 2022 02:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMHbU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Nov 2022 02:31:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A6510559
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Nov 2022 23:31:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 125A560B02
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 07:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70573C433C1
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 07:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668324678;
        bh=MLjfzwnCVZNqz0Gexs3QDjRsVWD5Fp3XSnHI2yRJ/AY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vGdwXrTrhKC2S/3Uqxw6eFAA5cppIyTRN6TCT9qtxrXnKkkZtpE/nWU80TOewILaw
         gAOTvwHS5hzY7jMgwzv1HhO//WaGUqzkWjgxdEkPKMabYdyrktOOEC6Y+XvXDinBrW
         qGhU8T9wYb548a8r2L8sP+3J+/1p+RX0rqRYzspV4ojeDqhrCDNJ/I7GkRgIZQba7+
         Bs89oJ4RhHzIjFyJQZIA8QhG4GCJpzWwbLBPUMkaHCgktw89mzH5grvcxdBDgKUGx2
         UUPA0muz5le3RAq1RogsR1A6BZ00vYqZnQQEYxyGDO1KGg4/AvZspmZubhaNAZ0s5n
         YNv2SxDmtX56g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5F026C433E4; Sun, 13 Nov 2022 07:31:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216686] BUG: kernel NULL pointer dereference, address:
 0000000000000680
Date:   Sun, 13 Nov 2022 07:31:18 +0000
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
Message-ID: <bug-216686-62941-McUlW6xELZ@https.bugzilla.kernel.org/>
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

--- Comment #2 from frc.gabriel@gmail.com ---
Created attachment 303163
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303163&action=3Dedit
6.0.8 oops

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
