Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5622DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jan 2022 22:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380308AbiAXWOZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jan 2022 17:14:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59688 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355239AbiAXV6M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jan 2022 16:58:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65A63B8123D
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 21:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CC38C340E7
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 21:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643061489;
        bh=WVGzOxNyjqcoV8ADh5sGbOQb+FjN2W4GSTXgyd0Iau0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EQx7TyPzMFHs+UF7ivYHsfbHGAsj/ou2I2JuI/JziN/QB1hqDDnVUYvSBRGH7NY8G
         SVuX8hV/anWcPM/m+/+5lNyrffeTtSMur7Cz9gUJK+dm4030E5iLbGXgXBqmOZrf4K
         LOExmNRVeUhfNI8NO8kpT2JyhT9ULQYs8CwPhts01om8VrTWiwdBcIqPAUJBzYzbzo
         rHb2ZJKFXuhPKhTDYGcLAZQYJcZiREZF9Tj2xnyWefSUf5ahFM067i9xhLdQF9lF2u
         1R0aqZ9mym5jSkp7AqOvgWbrsYFI7rujL5i9pAmDEhbxFeGsUYBZW+Ixyt4XFibK8v
         Dz3TT6yG2FHWw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0471ACC13B0; Mon, 24 Jan 2022 21:58:09 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215528] Excessive logging from Intel Bluetooth "Bluetooth:
 hci0: sending frame failed" "hci0: urb 00000000xxxxxxxx submission failed
 (90)"
Date:   Mon, 24 Jan 2022 21:58:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215528-62941-i4HvzyT730@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215528-62941@https.bugzilla.kernel.org/>
References: <bug-215528-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215528

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Would be great if the CC'ed people addressed this bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
