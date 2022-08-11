Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E50C25B0C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 03:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiHKD7q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 23:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiHKD7e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 23:59:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06B989901
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 20:59:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 961E861362
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 03:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2B37C433B5
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 03:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660190373;
        bh=TEanWyqEo16IC2FLSdWORNeaGjM37AeBBj3q6L/ac0M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TmRRJDsnFxlgn0MHXBY/TWUx74PDVYUPvvmIelcj8TKyalwNWQA+L51urNDugaGdK
         zbRoaVFwUAaM8LSW772mMK1tZWIMilJ7sqJ2QQ99pfUq8gYCLMEDH5oPHndTby5Cbq
         kI3Ae1VLaq1mCJ3ib+3UqG7pd2mAPbMTPc5LnDJ9gKW6UYzP47EuPE00ohWEfmgwoO
         IWoxLkeuJ7y07LRrYbSncUrA5Od2kGoeJk+XPOLm2IbIkTa1Z2vlIPyBPxxNfFkvyP
         FDw/QTxAGcGTo1ehjAkPU2Xr9jcwlvL7W8BfffdLqQZuUYFQsfUON5KE6JZ8z8LiFo
         Bjstdhezt6z1Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DCE5FC433E6; Thu, 11 Aug 2022 03:59:32 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216352] [BISECTED] 250 ms system suspend performance regression
Date:   Thu, 11 Aug 2022 03:59:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lenb@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216352-62941-uMljs9hahr@https.bugzilla.kernel.org/>
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

--- Comment #1 from Len Brown (lenb@kernel.org) ---
Created attachment 301548
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301548&action=3Dedit
sleepgraph 5.19-rc8: 411ms suspend

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
