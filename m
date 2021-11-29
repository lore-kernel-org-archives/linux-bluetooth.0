Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6DEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Nov 2021 21:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhK2V7a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:59:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45774 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhK2V5a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Nov 2021 16:57:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E8D3B8163A
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 21:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2577C53FD1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 21:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638222849;
        bh=zko6gZ3XjNlarHnSThn5ATAI37RsL5WKmH2M7IyfKOg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ezr5cArLbtl7KgwqxCjP4A3NXlNQrtLGzLZLogoOGC/FzNnxwIi0jYbpUIDooi76w
         X/VUEk2rmH8jPTTBpEmc5CdVbz8dyjCP9wVahBWz/EcwNk69V7vxhSfzO2+lKEslS+
         IxS6BhAjTEUulJHXRPXYbANPHcN5mm/ssLfMGsRpAtIw1fRNN75u4K5w4VenoD9MLM
         +qFLl3nH7sp9ARzQseDHSDTh/GV2l0fx915FA/ASTuG8BIAE3fTMNqeO8sN5sheppW
         QXIPvrDR7raMud7pc5jLrz6Y8t53r7AgW7lyg1vGwDvOn+jCpkl0PX1mn6djmpcpxK
         YUvmXSIiUJOcg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id C830760F26; Mon, 29 Nov 2021 21:54:09 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Mon, 29 Nov 2021 21:54:09 +0000
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
Message-ID: <bug-215167-62941-wvJgbTsVpU@https.bugzilla.kernel.org/>
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

--- Comment #5 from George Olson (tech@reachthetribes.org) ---
Created attachment 299783
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D299783&action=3Dedit
dmesg on kernel 5.15.3 bluetooth fails

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
