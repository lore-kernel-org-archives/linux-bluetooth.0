Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155BCC07E9D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 17:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiIZRDx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiIZRDF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 13:03:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B51DF75
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 09:04:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5391260F4A
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 16:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B683DC433D6
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 16:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664208293;
        bh=GYkmSdObSZM4Q/txOUVnt6CobHiXZWH64Pq3EYFYRhY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CU8vFQW9YuAYyg9+Ma8Ncst5OnDhKT8FPLhXVaZIOiAvgK1qMdLrKbwfO1IHks9lo
         SRIFH+3MdltscEIR+PbjQ2QHYAp4sXIYCbePAAye0oCVQrN1sqSpMlPP2zaCuf0WWn
         mkhaS3rQmqpnCDulDYn7ihjCK13EIoE8ehdyQe2/9jrO1aTr6RxBBENwlHAeWFXzBC
         APB2GxkaXmFVpXJyC7K+2iYL/efSpHvN003JcZTAfECfQPpAGNJlvFM4YakTFe0n8k
         yWJ1R8r/biAvSUpTaBks4Hnx7JFU9MSZxB+WpZBKhMWZravUIdy+gpUEz6mFCf2Uf8
         S+oS/cpyerNrQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9EC3DC433E4; Mon, 26 Sep 2022 16:04:53 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216533] openSUSE Tumbleweed, AX210, bluetooth, connection fails
Date:   Mon, 26 Sep 2022 16:04:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: epistemepromeneur@free.fr
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216533-62941-kXbcqp6uvG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216533-62941@https.bugzilla.kernel.org/>
References: <bug-216533-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216533

epistemepromeneur@free.fr changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #1 from epistemepromeneur@free.fr ---


*** This bug has been marked as a duplicate of bug 216532 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
