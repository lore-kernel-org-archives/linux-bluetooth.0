Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37611C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Nov 2021 21:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhK2V7x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:59:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46060 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhK2V5x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Nov 2021 16:57:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C35FB80E60
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 21:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F783C53FD0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 21:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638222873;
        bh=W4Fn7b4xaTtQug9Tb706cm8y45wk0nhLTtAWU2+y8oc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lPW4Gc7oUHHLLCmsRzvcRcnenpLafPyoqKboToK+QS42rRKGtk4g60/5pVnmqVAKL
         rJik2/BW8TJ6wSB8afIzGbBQXSyaexdw6KG8yqWPTqvsifmdhSDyclRCsFSYtGuZaj
         L4/WePU9j8q26kPR0l733dSeHVArXU4cCPYw2ZqcejTyfzSpRqQaZG22ccp2YcpYn/
         nQNECo7Js53CR+TtNCBAaE/gbOeqB1JZya/j47YKdPLXeiIT1HXRfFtDelH7O/FGBC
         FSGmd9vHahQ2Zgoe/b4qRwTaYKgVEpnk1mwMo+VyIe8NJVoAEJDEXSS5o8fEZiMrdu
         XZdM2847p28FA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id F27C460F26; Mon, 29 Nov 2021 21:54:32 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Mon, 29 Nov 2021 21:54:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tech@reachthetribes.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215167-62941-3NbdTUrjqf@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

--- Comment #6 from George Olson (tech@reachthetribes.org) ---
Created attachment 299785
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D299785&action=3Dedit
hwinfo on kernel 5.14.14 bluetooth works

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
