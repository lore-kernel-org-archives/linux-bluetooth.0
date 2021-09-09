Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC46C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 17:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A6C604D2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 17:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbhIIRIY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Sep 2021 13:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238789AbhIIRIY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Sep 2021 13:08:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5A5236115B
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Sep 2021 17:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631207234;
        bh=gTJgee8Oych6KGBZvB1Htvw7Cxlreg4caaLLxB+PbSs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Nfy4e7nft+UsIldsHdv7JgCtR+gK1S6hnTfWukkaLbxBZRzvxwIxK9vIue0PDLa2S
         l/Q7LtVZEbqmdIwTmBHlYm+W4uQe88FVo1mfJGzf5amA8tTex1QrAQqyq36ka9rEDT
         XFz4x/+iHjYYAC5tugsnPmkNpJOcOzaMOOvgvyIReCFUOnHrOeFGfbXv1doY/6jivd
         o53yGqhHFYHTbfWtdmRjcZHCajE8tJzHzTcmXvdM14XCUpOcQa0jJH/OLOrs4W0ArW
         VxLeTymvOBNk5UJmgiNdqaQSR+6fFD0LOEcXNoP4cik3xWH5sad0kalVE1awGDRlEm
         6wMa8eaq/2mww==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204629] Bluetooth headset auto connected but failed to
 recognize as audio device
Date:   Thu, 09 Sep 2021 17:07:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mirh@protonmail.ch
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-204629-62941-9NN6gssGDA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204629-62941@https.bugzilla.kernel.org/>
References: <bug-204629-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D204629

mirh (mirh@protonmail.ch) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mirh@protonmail.ch

--- Comment #3 from mirh (mirh@protonmail.ch) ---
b0ebdd778b06a71c1cbc2fcf30d7fe5842e749fb I guess?
Is this still a thing?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
