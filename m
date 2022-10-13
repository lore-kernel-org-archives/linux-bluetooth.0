Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1408EC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Oct 2022 15:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJMPmu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJMPm2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Oct 2022 11:42:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C62E137287
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 08:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0644561840
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 15:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68DF9C433C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665675657;
        bh=8ij/h3YjmSp4KNvE8/uJhiat793wg+PNYJL6p/G79Uk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GUvSggYb7OHWwZ1dfozfWZPCdMbDyIcetMGJB9J0hxXM/vwhzSJaL4tLTdPWv7J1o
         iS2XU+ptZQ/A0huXazRSPjPfOs3efDuneHb37Ai9a2vszmdcjWQPKZ0Wc6qdRIDn6n
         qmbvD8HS8jxeSOAtoQVPS2dLI19sQqsKPWGm/MvFjHRrIfiXVq6Y6Mam6BLLqFcrPw
         D69EsTxsthhz4ubKVUgmXeZIIGZhfWvP556xSFwMUen4VPG0pIVpHvU2ARMkv7mBpz
         Z3dgHuYNQWjOlDpwbWn3w2EnU0bQp9e4TWvW4ftiiw0j3xA6f78ex3DcDccSA+NKQX
         NBdB3x61AJvGQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 58735C433E7; Thu, 13 Oct 2022 15:40:57 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216580] Jabra Elite 75t (ear buds):Unable to connect and use
 (`hci0: Opcode 0x 401 failed: -16`)
Date:   Thu, 13 Oct 2022 15:40:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216580-62941-LEm4s5qn0l@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216580-62941@https.bugzilla.kernel.org/>
References: <bug-216580-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216580

--- Comment #2 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Created attachment 302993
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D302993&action=3Dedit
sudo btmon -w /dev/shm/20221013-trace.log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
