Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88B8C19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 21:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbiHKVXa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 17:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbiHKVX0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 17:23:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D299C2EA
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 14:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EFF861475
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 21:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F38DDC433D6
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 21:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660253005;
        bh=eCll6JPt472NCPbzGZ0x9iwwBb3ps6e2pBbWdzYlb7w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UWEh53/W+FA/kOE/JNVGprj+wBVAbY+Y/tKlvSIIfT930ff/DrUEDgOUTgsZVRDm5
         9AITY/wRdYRJxgB3gJ2m/HDRmQ9bWE7RFTtohkpNYEzb+gJhjlT22Yub8SYcD8oXLN
         2u6wbh4ZFVIi6fuE2j/dLH83MZGvKKBT0WQXXsiyPlTNFQm3XSEYg2xFJ3g3b7AlEZ
         ljJhoS6XLyIBBPUXlvy3PmSMENqogvA4iLVN674U8FEOqRwc1FRH4jIir0UyuxwKzx
         uJjgbwLPAls5ZFQHHftWJ9pJFRydjTbX2KV7VzX/Yui94V7nWJK35jykL+KgHblkz5
         uMTIO9aTkhx8g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DBF35C433E4; Thu, 11 Aug 2022 21:23:24 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216352] [BISECTED] 250 ms system suspend performance regression
Date:   Thu, 11 Aug 2022 21:23:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216352-62941-CXPQFHia9t@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216352-62941@https.bugzilla.kernel.org/>
References: <bug-216352-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216352

--- Comment #5 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
Created attachment 301553
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301553&action=3Dedit
Bluetooth: hci_sync: Fix suspend performance regression

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
