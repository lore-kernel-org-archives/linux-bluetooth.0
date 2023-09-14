Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769CAEE0213
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Sep 2023 02:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjINCJe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Sep 2023 22:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbjINCJO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Sep 2023 22:09:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6F62693
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Sep 2023 19:08:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C4F6C433CA
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 02:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694657281;
        bh=CrAyhsfb740bXEcOKrGADuXRIqA9YJU5hl3rGlHM2LY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=f42/RXX+50DkU7nEPtjCdJmkopoBu5I4/5wGiFDZkz3b1Mv/9vKj6XMpPu14KjsjW
         EboCdK6kGRMj8XRsPgJ6ZdoZTm5UJLtiGBnihZESXYAexX8xsGF0CxgmxwGNr2Oqrf
         JgYYZc4V8g7NOBesJSp17Y2zF4uZVFNCRsFYm6aUWKMNeMRdxLx23uZ5ltDfebPmZC
         tVoWJc+Q9TzvsUeyuxtwhSn0g7XjtZUbdpH05IDZEJl229WeJF+5JzcT1ZWs5sGMgP
         sHkLzNZ9hmGRCg+YUAxMk1E90hdr1vkq2yfpzLBoKSVQXlGYHE1DJX6zUQdMpPIPjj
         XQYJramURqZRA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5F393C53BC6; Thu, 14 Sep 2023 02:08:01 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217903] Bluetooth doesn't work after trigger bluetoothctl scan
 on
Date:   Thu, 14 Sep 2023 02:08:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: kaichuan.hsieh@canonical.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-217903-62941-Zm8q2NTgNj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217903-62941@https.bugzilla.kernel.org/>
References: <bug-217903-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217903

KaiChuan-Hsieh (kaichuan.hsieh@canonical.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #2 from KaiChuan-Hsieh (kaichuan.hsieh@canonical.com) ---
The issue won't happen with QS BE200 module.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
