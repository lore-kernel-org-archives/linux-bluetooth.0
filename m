Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCF6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Nov 2021 18:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349752AbhK2SMz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Nov 2021 13:12:55 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43734 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245084AbhK2SKu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Nov 2021 13:10:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 974D0CE13AB
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 18:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9CF6C53FAD
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 18:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638209249;
        bh=R77FXYYkynNb5EKyAYLiuojtoay0OOlB7jMxzy9W8Tk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fL3BoIy2JOn4HcPsL/Hf2wp2PWGxIuH6pDpjjzddW5S0zsijPYRIc+3MW3WLKVGr4
         E1dr76htgZOMnx6SbjmcAdYg6KI/+J+GTbIki89xrQJwT8bdHZfGoKgmef6ZCyn5SU
         LImmqAXkTytymxefS342yKhllGjI2WYiGt3EPoEHJOnRmW6t7s1QGl6M3W5a5ph4FB
         UABrI7KtLpxZ7QoCZ6/Y/nNiD0Xq1lxYWfJVMLbCaE6vFEDWXb9Uh1OhZN6dLMAPHg
         Q5NHoCvSwMvv0Nsya+8Nr49r8MOICvulh/TukCYnOfwQgqSEUqgZrux1YFzmNRBMvh
         C7puZaZ5F5gJA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 996CB60E91; Mon, 29 Nov 2021 18:07:29 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Mon, 29 Nov 2021 18:07:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: harmie@opensuse.fi
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215167-62941-76fswzHBWb@https.bugzilla.kernel.org/>
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

--- Comment #1 from Harri Miettinen (harmie@opensuse.fi) ---
Created attachment 299771
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D299771&action=3Dedit
dmesg with 5.15.5 kernel

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
