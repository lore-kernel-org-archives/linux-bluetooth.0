Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C33FC32771
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Aug 2022 20:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351558AbiHSUMr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350111AbiHSUMq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Aug 2022 16:12:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7718C10650C
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 13:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F374616C6
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 20:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6027FC433B5
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 20:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660939964;
        bh=AlUjAsAKUgDgIYzI4SRLvSQ39jYwUvemtAPs/JgDkkw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iNcVHTm4gaws75Q8C5oTkDBlc5m1csYQ+ySccqa3ms8jTnL4Jhg9c4MEyfaQ78vU7
         2qsTqarxZTbq8chV+riGBtiz9jhwh+7KMEsDR4vvM0XehchMFqBZea2D50XI0BV18u
         zfPz9FWAe4itAUx1YuM26SmwC02Cgy3MFFOsCRvioDQcSPoPbOrHN4NZ6/syHS3Ltw
         fgk6X05WQD1zipij21RERwxI93uA3m7GBGX9l91pkHQB7G3CnD+73mLu3CxoHarzpR
         iMwAQFkr29Yo3V3UrRwCC7L4qRWx4z33yKjHWWmwZtaEYbja9C0DgYk98JW0T++V5c
         epaJFJ+z6cVYA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 47459C433E6; Fri, 19 Aug 2022 20:12:44 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216382] [bisected][regression] mediatek bluetooth 13d3:3563
 (mt7921e) doesn't work with audio devices.
Date:   Fri, 19 Aug 2022 20:12:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arek.rusi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216382-62941-4rlANuTv1k@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216382-62941@https.bugzilla.kernel.org/>
References: <bug-216382-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216382

--- Comment #2 from Arek Ru=C5=9Bniak (arek.rusi@gmail.com) ---
Created attachment 301608
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301608&action=3Dedit
btmon -w log # 6.0-rc1

Hi,
this is log for rc1, hope it's not a big problem.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
