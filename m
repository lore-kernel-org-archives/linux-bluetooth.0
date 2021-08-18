Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED10C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 17:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD23A6108D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 17:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhHRRJS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 13:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229883AbhHRRJM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 13:09:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E74BB610CB
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 17:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629306517;
        bh=aQ4us2v8t4NK39OolxwdQp0E9RAybPeZkVwFbBVOAS8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ipBxjpdr/ac7Ttcv+sgsP1M1cwrhPFqYedehCwK1bdTCCAHNgkZr/h0GTtXhYLCbG
         6dY5Ow3tWcBRPh+4nXEgToPdJvoReqBzoW2XLZiUjNXqri5ZD1gdnjs38XJpUprVxL
         gMucowHL33HZqdvXQoTJ4GlSaKxAByT4/V/U9Ea+IryqZXFSy1UTogtV9uqHek54/w
         JtgPMVhY/n8A5oZm+frMnrQAqY9E7KCAn8hX97fWGCMKlkbynhpXEoMKz+zJVN8Nbd
         i+j2BtgHia23GRBi41vdUytAoFUnm7WBGGtx7kBoSYw0Ts2sX9lmp97LBg/ahud+Ue
         xRbBY4A9oH0Kg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213923] Bluetooth: AC9560 doesn't respond any more after
 suspend multiple times
Date:   Wed, 18 Aug 2021 17:08:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: koba.ko@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-213923-62941-YnRGUO3Es8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213923-62941@https.bugzilla.kernel.org/>
References: <bug-213923-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213923

--- Comment #6 from KobaKo (koba.ko@canonical.com) ---
@Chethan,
Im using Ubuntu to reproduce on JSL platform.
the issue could be observed since 5.14rc3 only with AC9560.
With ax210, there's no issue.

The suspend&resume is a normal behavior when you don't use notebook any more
and  suspend notebook for the power saving.
User wouldn't know if bt fw is downloading when user want to suspend the his
notebook.

I just use a scripts to run suspend&resume automatically.
#for i in $(seq 10);do sleep 10;sudo rtcwake -m mem -s 10;done

you also can suspend by pushing suspend button manually.

Could you share what's correct hw_variant of ac9560?
0x11 or 0x13?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
