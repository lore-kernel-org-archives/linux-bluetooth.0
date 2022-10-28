Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77444ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Oct 2022 02:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiJ1C7q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Oct 2022 22:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJ1C7o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Oct 2022 22:59:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E87038A7
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Oct 2022 19:59:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4771162629
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Oct 2022 02:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4C10C43144
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Oct 2022 02:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666925982;
        bh=H8i41vLWBRn9fXlm0qKuVFMsNJO0/ieNTcEToowHCZI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tnRrmJZnfeqe2YAw7UQoUu+heMU9vYttoB/WxAjXVbw6rKhfNtAHPHK9ygDmaC5BJ
         m29VWaeoQppYxa/Zb99ivLq8sALiuV94pS7WAeGvLEpl1BOjJTwsTG0T3w9xwiydR5
         iJvA1cHyUw+Jp+dwZtKB2o5MfQJDoWDQFLMFel/J9YbImMOIJMYYd4bQA3fAJWjEh1
         snAX/X//rDHh5bpN5nHROFETIEn5zgMQ1LntKVUGP/Aw6Jamt5d1G6o+4qL6uHBC3t
         VdJbdiTEQfAZhTXv4bKnzPaqueLvtVxQ0PZcua0PiM8jVAPzrLeIUnLA3QtVJzscKm
         /IvvMv/UDpt+Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 96BC8C433E7; Fri, 28 Oct 2022 02:59:42 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 28 Oct 2022 02:59:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quic_zijuhu@quicinc.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-tPH5Mnb8Zz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #240 from Zijun Hu (quic_zijuhu@quicinc.com) ---
I am sorry, please ignore my last wrong comments.

this issue should be caused by that below commit is not be picked up.

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3Db3cf94c8b6b2f1a2b94825a025db291da2b151fd

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
