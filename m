Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE97BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Feb 2022 06:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiBLG4K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Feb 2022 01:56:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiBLG4J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Feb 2022 01:56:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A1627173
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 22:56:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 321DDB816F9
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 06:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D27EEC340F0
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 06:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644648961;
        bh=owz3uw7iSFmmdaoyCbi4bI3RZIB//3VjxDc3NFkWh1k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kFVcq4jx5LnMw7uUATW93oCG3uaeJC6mnZ1+Ub9yNSsFproAODfBksd5OQummCE6J
         e9bJiLEi+LyBhZqiBnkkipJHza+HA5HdmtDvqSzEq33V/SQnB7wS3bfwMtRoDhSJnD
         08kRtsBO8FbV+Z40z83qJgewkaUIKY0MqIhLLTYTu7VJCrDZCBX/Vi9MEDHUuhnN7+
         wJAKNdmEIuJYYaNCVSCtHDqv4z0T/hhMT8W0k2w9ZPTqZJJoiyOFfyWYpOtV0xI5Nz
         LOpv/jaZSlN2mMLcnAXLPt0I/lLPhYTU+X8nB5QHFJcz9Wi6K6BZqWfEdyeo7x0bZw
         rLqyEk/JXo6XA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B8F9EC05FD2; Sat, 12 Feb 2022 06:56:01 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215594] Unable to transfer big files to Nokia N9 and Jolla
 phone
Date:   Sat, 12 Feb 2022 06:56:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215594-62941-58xP7W4wj9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215594-62941@https.bugzilla.kernel.org/>
References: <bug-215594-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215594

--- Comment #3 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Just to also document it here, commit 81be03e026dc (Bluetooth: RFCOMM: Repl=
ace
use of memcpy_from_msg with bt_skb_sendmmsg) introduced that regression, and
reverting this fixes the issue.

[1]:
https://lore.kernel.org/linux-bluetooth/def03073-3fab-3b34-6ffc-702bb1b3758=
f@leemhuis.info/T/#m04445e920610d42a9510d0f6d97afa5376e4a3ca
[2]:
https://lore.kernel.org/linux-bluetooth/20220208221911.57058-1-pmenzel@molg=
en.mpg.de/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
