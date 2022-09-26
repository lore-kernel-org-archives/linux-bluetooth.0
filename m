Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF7BC07E9D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 17:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiIZRDz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiIZRDG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 13:03:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B24411C1B
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 09:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37E20B80B07
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 16:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB89AC433C1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 16:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664208293;
        bh=GwZmBC7mYWQ+wSJ6HdH7lTZsVWQG5sb+YbTjVPw+AhQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TO1C13S/9xAHG8dldyi05ZCzAy5CDLDlqMjjar7Pjk83uRuxhnqSc4r5D6h2rv+iZ
         mR1rrdLDpHOaBtn2F5hamhfgHt2dZ5Iil81XnxJnzNoqYjO/0AST1uKnjOayws/oTl
         vZfVba7uPEGfLpVJgWBx2sVDy/y5NlWGwos0TDGakfN/NUJc/RXkM+qlgev1n9/sFw
         vACS8yBHJYwdD9p8M3WKklwQUWVhVDB7PIqwq8u7b82tNOMFAuaBWTmQCRpDQXplYk
         xxc4pbDjZ/2K7Q/Ag3S8K0dcNbheosb8OMp0jDIlJzdczozIRm2XxfOI7KPLAmhhXc
         e4XySRT8I2xKA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B7AF7C433E6; Mon, 26 Sep 2022 16:04:53 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216532] openSUSE Tumbleweed, AX210, bluetooth, connection fails
Date:   Mon, 26 Sep 2022 16:04:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: epistemepromeneur@free.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216532-62941-7kiifqSjt1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216532-62941@https.bugzilla.kernel.org/>
References: <bug-216532-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216532

--- Comment #1 from epistemepromeneur@free.fr ---
*** Bug 216533 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
