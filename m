Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880E5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 20:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392239AbiDUULo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392247AbiDUULj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Apr 2022 16:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391C44D9E6
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 13:08:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C746961CC8
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 20:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 326F9C385A5
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 20:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650571728;
        bh=2b8vSGO5Kvy+lK8r+dWPVjxw6L9slxnkGHzypBUQ4dA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IukXkSPdVYTNeT0lZVaUuqU5wu8vdXJPTcos4PrOIZaAeObajspgXGVRH/Azfaw4R
         FFmD1rWVCC2EFi+fKotnZSPC9iHImQLOCgAWtNoHKw3yDmpmRr5g0lcuWWKjSci691
         vAsAoc+QCciTbuS83lSSmkHaPkO0sn3r7sjlLkuO4brER6aH+AYlKq8GfELsZK2f1T
         d3ALVmDBjmLQ0i6uUWlqryoJq/8BVG9zXnlCLKSni5dN5+f3kJsPGeItworV/jnHbS
         e5/kLJw4+hPkSli4iOU4fcQr5+l38/3OE6uwGyEbh27m9YVjR3yo6tr95d0yci8MMo
         gqxc52p2ICykg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1F7F5C05FD2; Thu, 21 Apr 2022 20:08:48 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215872] ath11k: QCA6390 firmware crashes after some time
Date:   Thu, 21 Apr 2022 20:08:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mail@kai-mast.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215872-62941-fgTbcukq6H@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215872-62941@https.bugzilla.kernel.org/>
References: <bug-215872-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215872

--- Comment #3 from Kai Mast (mail@kai-mast.de) ---
Created attachment 300789
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300789&action=3Dedit
lspci -mnn

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
