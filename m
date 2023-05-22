Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9345C77B75
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 May 2023 11:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjEVLyU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 May 2023 07:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjEVLyS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 May 2023 07:54:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E16A1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 04:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ABA46131C
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 11:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BD8CC433AA
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 11:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684756457;
        bh=ne7fOCFivbi3zaTzChba3l3YNqq5APXmkLjVLqjpZZw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RMIH0dgdfHpdkfEWmIxn4+6rKX+Abf8AFVKuQmKEnvYk1vX7pfo4ZQGUIBITtBsa4
         kYIwysxrr44sgQhsglbfl7C+xaZ0imdeBw3pdpnxKBsz4KdRltIEgACzrlp+4gCFDC
         EtAO1a8arllxsFn2Ujo3PyxXTIZUOrVQ7q6MWddC2ORrMGd6LKIf2YM1UVxKXJXmi0
         RJnr8Qgry8r+xvr+RIXmLSQTdfQJ7REHLa9ONtxWMLP7UoRR4lOEs4y31wxFQtpKvh
         diEBDoOH4wKv/MsMIYaC9KPP/D+WUEHBtlo9Y0awPQj0rj96bR2Zdw/g22Q6RqAUT9
         yyj1WKskcwfag==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E90FEC43143; Mon, 22 May 2023 11:54:16 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204589] Bluetooth touchpad (Apple Magic Trackpad) disconnects
 every few minutes
Date:   Mon, 22 May 2023 11:54:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: scherbakov.al@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204589-62941-JlMuQUfv3T@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204589-62941@https.bugzilla.kernel.org/>
References: <bug-204589-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D204589

--- Comment #13 from scherbakov_al (scherbakov.al@gmail.com) ---
I have the same problem on ubuntu 23.04.
My report: https://pastebin.com/3A9EXusp

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
