Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B44C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 May 2022 11:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiE3LMo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 May 2022 07:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiE3LMl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 May 2022 07:12:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1798A79819
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 04:12:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA8EAB80D7A
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 11:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96AF9C341C8
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 11:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653909158;
        bh=NnyETd51DKku2Zkoy1pLM3rygNf9yPcdBqHBwkh49dY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ja/5kwYm53fLVXixHZBdHfGghCMIOPaGR3UTp2QNfmolOhi+K2Vcox1Am4l9eWugn
         3tq6nW7EQ+/24k3kdUfKeZDTn8MTKHyn7E/NQihSOZQL2GPNgRegeqorVVK8oynXQo
         nGhTZlI/hzp7AtrR93bq1px7xwBZ/PEmBT//JRR7MAKbwUc73C7IQXmyuvK9ScJ9Vs
         GSw5G9OfL3bnxJmglwZrUKgsKlJm4Psxyoyf/Odc0B/64xuVl/zGDHavdiKGmtg1ym
         O9NrTPFwYEKbUlx2yXf9kTE5kQv+WO7M5jfnsUoBFPY7Osq22yC2i5PayX3ZBW7N04
         VBpWr9VaN8QjQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 860EDC05FF5; Mon, 30 May 2022 11:12:38 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Mon, 30 May 2022 11:12:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215576-62941-XZOddKW4O2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215576-62941@https.bugzilla.kernel.org/>
References: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

--- Comment #14 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
> Any chance we'll see some backports to get this in people's hands faster?

The maintainers just need to ask the stable to to backport this; note sure,
maybe asking them for this on the mailing list might lead to better results.

But even if they don't do that, there is a good chance that this might be
backported within the next two weeks

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
