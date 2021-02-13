Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCC4C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Feb 2021 07:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FBCE64E8C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Feb 2021 07:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhBMHFD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Feb 2021 02:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhBMHFD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Feb 2021 02:05:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9FAC364EC1
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Feb 2021 07:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613199862;
        bh=bQmxGMDTsrh/uYr0MkqDJk1RQ2xOdjo7EKW9+xZwg2k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tFZXwVrF+0z136xp/nLfmLE+9n3QAhXTx8WWdN3FLoaYmpVpI4nIUrT9h3OCW6Erj
         O0wiFMv6QtFIFc+q75ygonvyy1x0wbsVwxZNcrU5NEeBbBvXkBnPc/uv06aPNf96ym
         ZTtft7nGZwk4lnAbdYfE5Efiuuqe3PlhZdDVCcmmxah0A3N/fPx8u8c0ASdOtynucJ
         VVWRIGeeZT53ce9vv+CpIDgvYSA9xvLhCu9/70aRroy1sZATVAgv/ZaBLrhQ6ynkt/
         vTZmqk6WyQkU+IcHgsBYxVi/8syBbeNkC0JqtocOz4f9A2eMJup4Z2qB26JclWO1ve
         ca/KZWp9/rIfg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210681] kernel: Bluetooth: hci0: don't support firmware rome
 0x31010000
Date:   Sat, 13 Feb 2021 07:04:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: carnil@debian.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-210681-62941-sciYJQ16sO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210681-62941@https.bugzilla.kernel.org/>
References: <bug-210681-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D210681

--- Comment #30 from Salvatore Bonaccorso (carnil@debian.org) ---
The fix is pending in bluetooth-next three according to
https://lore.kernel.org/linux-bluetooth/CA2C8796-11CA-4E6F-A603-AE764516C85=
0@holtmann.org/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
