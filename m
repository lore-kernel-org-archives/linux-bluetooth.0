Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1297AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Sep 2021 07:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6AB3610C8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Sep 2021 07:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhIJHi3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Sep 2021 03:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbhIJHi3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Sep 2021 03:38:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7016A61221
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Sep 2021 07:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631259438;
        bh=d8JvH2ZnHSTHpRwTSnD0IAWwbmnlu9LWGyyu8z5ET24=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sFViFBeHpWO99HUN8SK1cGZXurkHlwEK4nOLigIVgWOW+qfEQR6ka8yn3LNSOu3Jo
         9xDfICdEwVkd+xYnQIlCpH4uccYYg6bTAhFbdT+9Uh0UyknxfISH5ds5M5bOPvfPn3
         Nt/5Y0c27ymBXd6Ch3AosD37WNeD9pWjFe7jJKNwMlmB2fHX7iR/2Q1VJlGVEpFZTK
         xFC4eYJB+b946T9dpayQeqbMcbSdfKT82XzXBgDi1/qP9XELCqXliygmKR9aO/VACr
         fFZ7sRiUo9drqDKXngT8RJpXwIahQg3WsOullcadJtoa1NZ+Ds8VxGFHojTiZ43Wry
         r5SClbXnoCq6w==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 10 Sep 2021 07:37:14 +0000
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
Message-ID: <bug-60824-62941-TnujWDvzXu@https.bugzilla.kernel.org/>
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

--- Comment #201 from Swyter (swyterzone@gmail.com) ---
Quick update: I have received two e-mails from gregkh saying that he has ad=
ded
my "Bluetooth: btusb: Make the CSR clone chip force-suspend workaround more
generic" patch to the 5.14-stable and 5.13-stable trees. So, hopefully, if =
I'm
not wrong, this means that it will get a lot more use and feedback in the
following months. Neat. =C2=AF\_(=E3=83=84)_/=C2=AF

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
