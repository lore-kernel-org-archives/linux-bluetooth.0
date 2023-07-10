Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EF8EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 12:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGJMJK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 08:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGJMJJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 08:09:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A87F4
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 05:09:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8146C60F6E
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 12:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3659C433C8
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 12:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688990947;
        bh=qyWlhrpHw+33+HntmHY8YBbnsUHQKcUL12ZBci6+UL4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=L3aM7zImgEAgwq0HYjC5imUfPQ17zMvmRWdseX9dl5QsFYIWfzfYaobiQdDbfZK8i
         YGT+iYB5UtUteQ6FETTYshkIZaQnLJU0caxhvI9oLoEd5DuG37YGzRWFFQLhiJFH1s
         p4KoGXUc2lyM0WFShMDQ1A3MF5kv7bf7kI+AcfeXQfa/vgKNcJONOe2qUyGKvoYRA1
         s3RLMxsPaLFrwlvl2O1CXVs6tbXssSr+SqoDMxW3tkVqoDZz/yhxXkqo+ezLn0WF9V
         qWCAkUV35vEHAzaflr3kSNh1BD5b+Mo3s+v7oXIA8kOcoHWaz5W5nyGGeeZOc+16el
         g/2/2vSUYAiog==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D0381C4332E; Mon, 10 Jul 2023 12:09:07 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Mon, 10 Jul 2023 12:09:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: johnbholland@icloud.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217651-62941-gmvJX50x0R@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217651-62941@https.bugzilla.kernel.org/>
References: <bug-217651-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217651

--- Comment #4 from johnbholland@icloud.com ---
Created attachment 304585
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D304585&action=3Dedit
dmesg from arch kernel 6.3.9

this is the latest 6.3.9 kernel in the arch archive, and bluetooth works wi=
th
it

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
