Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE66C83F10
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Aug 2023 15:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242522AbjHaPrt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Aug 2023 11:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjHaPrt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Aug 2023 11:47:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D2D1A3
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Aug 2023 08:47:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FCF36187F
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Aug 2023 15:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F4EDC433CA
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Aug 2023 15:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693496865;
        bh=jtbhH953o/wwXEzYmQIbecHCgcZY4ftmiRpQY8UTAdA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lUl0OmXIIqA1mp71egaPWVcXS5JblZ4RPKCaPy4Y5mdAaxWH+0ZpEzVK7gpi19kLt
         TodRGnq3W9E569rBmPPrDqmjReiKPTSSzFrEik2zEE0Lw2YyBtR4KkZPMnW78Jo66d
         wNyoL6XQSMgHZD0oVvJ4AsJg6h81nLzJx8trmL03vuXgRBIwihEQIpBlOrnOIARzNB
         ip0hWiV6gdsC4p3aXhJJkCvQlGhRGiCqpv2J2jjlWAMjnzhV769YY1r33ytvK9ZOFh
         KUcvf3+QPSECL4bMf6IJtQVyvMr0V0m6UkC7yEtc+6W4aWr3BxPVhvc0W34btx4qXD
         dGj97Pi8mTbqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8D87BC4332E; Thu, 31 Aug 2023 15:47:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMTc4MzBdIGFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYQ==?=
Date:   Thu, 31 Aug 2023 15:47:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mricon@kernel.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_group
Message-ID: <bug-217830-62941-hx9Px4NlDd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217830-62941@https.bugzilla.kernel.org/>
References: <bug-217830-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217830

Konstantin Ryabitsev (mricon@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
              Group|                            |Junk

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
