Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DDEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Mar 2022 09:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiCDJyn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 04:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239313AbiCDJym (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 04:54:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F033B034
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 01:53:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B064B82740
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 09:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52401C340E9
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 09:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646387632;
        bh=3OvGWEvwvIOw+OzibHyC5w2P0NKcO3mJEgfM+IJaZkg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LPan0mv3NZVSWzFKamc4rLObV/ZI3RwAvhUr7K4jsc7LjbTF/f9jrE2t78d8+xqlq
         h6qVvo6rcnFeHBAMFM5AI/d+LF0uJNLzL4Ax/D75F1X3SwsqpWYu4nJ6XH2pJnidPI
         EJenQqfUBt3P0eX3R50M+Ft5W3e6aogyJQ6YRQDYA9FvxygbRKX2dM5f/BtuSQh9lP
         us05dc2gkcJYpGhQ130ZMFbwg9S2s7Alo+Elgh23AQcuGIwDqoRxSsq8kiIRg9NLHC
         p4VSlKnuI0G+v1+AWiXvTfmKNq+mnNN/DhoMAgx8163rTyD+XJt9DFGStr/Mh9oV7/
         A4xyHTCu+Maug==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 428F0C05F98; Fri,  4 Mar 2022 09:53:52 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215659] "Unexpected continuation frame" spam in kernel log
Date:   Fri, 04 Mar 2022 09:53:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: smurf@smurf.noris.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215659-62941-XHNCIyT0aF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215659-62941@https.bugzilla.kernel.org/>
References: <bug-215659-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215659

--- Comment #1 from Matthias Urlichs (smurf@smurf.noris.de) ---
My BT stack appears to works fine otherwise

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
