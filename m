Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC7AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Nov 2022 02:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiKYCp6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Nov 2022 21:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKYCp4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Nov 2022 21:45:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3A52B1AF
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Nov 2022 18:45:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BC50B82931
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Nov 2022 02:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6535C43153
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Nov 2022 02:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669344353;
        bh=++zC8ozXhUoGv+XD/i54UyeX5ETKeW6E/X0l6No4pwY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=R52vRAoNy2t1N+n5LO7Ppf6Gam59CqRZxuFELiRBaF/UpweflmYfrUpEPncaUbUMT
         T5jn6HTsz4Lir0oUJN3QvHV3OVm2dVdyEAFOajO3WH3bFM/VLO9siEg60gDpq6jIbF
         76MOcxDKssMruugJ0Eb4WRjcJITf36soK1GRtjh5mUg0HUGRcj5Ye3gBf8LkL2DGpT
         DOP9zSHKnyHju1+6d3++uXVIPSykdgNM51nE0+PWoaApxB/ZCIR/doAfM7os4PMeoh
         6Y7VRqJi0axA8j6+zLRrWtKz8SN/eoDEhOB0tGvk2EPc7XA7sj0nShonI2091EpuRc
         KlZAKs1nd3L8A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C9921C433E4; Fri, 25 Nov 2022 02:45:53 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 25 Nov 2022 02:45:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ostroffjh@users.sourceforge.net
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-wwEmxnxTsU@https.bugzilla.kernel.org/>
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

--- Comment #260 from Jack (ostroffjh@users.sourceforge.net) ---
I have been getting that same kernel fault, most commonly without any
unplug/replug, and usually when no BT device (headset) is connected.  I just
posted one of my traces to that bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
