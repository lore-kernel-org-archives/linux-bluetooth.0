Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FEBC25B06
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Aug 2022 20:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiHNUww (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Aug 2022 16:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNUwv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Aug 2022 16:52:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F261A18385
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Aug 2022 13:52:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8CAEB80B52
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Aug 2022 20:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E902C43152
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Aug 2022 20:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660510366;
        bh=vNqGquQNRUxvmjPTWOIDEpstmOUkwELTXg3oO6/XCfU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qdPABwFv94Pok6aF96SE3Z79wXlZVJ58v+RtrwxZ19Pt/CRmUR2fsBdkMX7NdgB/n
         nBjdFhG+7/augEuqBqyNY6UunEVAgZMo2rWXDxfb8pqsALkjfpSwCSwv2q3+73A4le
         7gL17VjzuvQgR8jpUKWNoMovCUHPaqf7CygLwOUAwX6aOaBCPbXj3zJg9vr7Taey5d
         ElZMIQVnbvtUOoElKyj01fZZYcagkF2y5aO53xCI9TltwZnSBYGERAuKMVcXsfJ72f
         Qnbm73IGmtE7OuXj2uePufexwtcCj27pCtnebVLTAdfhq5ued98Et2uyyjH/mhSk8T
         eFxmKnqw29/Iw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4112BC433E9; Sun, 14 Aug 2022 20:52:46 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215768] Kernel 5.17 can't suspend while bluetooth is enabled.
Date:   Sun, 14 Aug 2022 20:52:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Krzysztof.Krason@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215768-62941-tmrzWr0io2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215768-62941@https.bugzilla.kernel.org/>
References: <bug-215768-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215768

--- Comment #37 from Krzysztof.Krason@gmail.com ---
In my case it also doesn't reconnect to BT devices, I need to manually conn=
ect
to them after resume (5.18.12 - the fix for resume worked for me since 5.18=
.5,
but with the reconnection issue)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
