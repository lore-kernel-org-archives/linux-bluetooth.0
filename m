Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E16C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Oct 2021 04:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C83E60E08
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Oct 2021 04:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhJXEmn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Oct 2021 00:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhJXEmn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Oct 2021 00:42:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 08C6B60F9C
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Oct 2021 04:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635050423;
        bh=EZ/0zG1ZYGMVQyPKRyOxGzIUW83UliJqWDT5hCAnQsQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OLmijsCtqLlmntf7b/p6Bmr5x1u3R5fxsAq4xIJ/cc81jsTnT4x7xPnLh1lbK6Qa+
         E+PeOWN8Umvsr3HGvy1T+9kLM/CxenTNwpiwZfwSbbbkckeGaf0N08BUVMVO5ZCj9T
         gHzzZXttX7p1u2MtfKb+rMKysicHX+V4x+KyOWHcn82QQcyqY5VMgZYmp4i+CAdchp
         ElSFmq9sJW5pvAUKFfavgsYXTiX7P6rSIo67DABtvJz7/PWY5Z19+NRk6KdIt0wSx8
         fRT2Bh2rnGkgH9woxkWHFZRS2KvN6t9rVmzH13AyXnZQXL+XasJs+En4OsrtXxAqnt
         stzuoHRniDxPA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204629] Bluetooth headset auto connected but failed to
 recognize as audio device
Date:   Sun, 24 Oct 2021 04:40:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: codyrude@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204629-62941-wwwOF7JruL@https.bugzilla.kernel.org/>
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

--- Comment #5 from Cody Rude (codyrude@gmail.com) ---
I've discovered that setting the headphones as trusted fixes the issue and =
it
auto-connects properly

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
