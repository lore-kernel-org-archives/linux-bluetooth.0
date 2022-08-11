Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6153C19F2D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 03:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiHKDvU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 23:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiHKDvT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 23:51:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E7883BCC
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 20:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C03B9CE1F75
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 03:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 140F3C433B5
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 03:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660189875;
        bh=Va66gDI0wRYDibUxWjlk89D03akcqJxem9Hw56cBLGA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=m+LqiX4kE1f6r1ndGJtmqrst3+qsT2QUFW1C4VCo4TXKMw3o947J5P4Okg+0GaZPM
         UIZR6L9RjI83VO7RfwM+TTcwXmPX3HlcP9vAxeoSkgDaDuMNNx129ilibdCu3QAFOc
         v5/B75xmhfhaje3NiLSfxXYVbrV6TXZaGniwVaYCIZGRh8jpiYFM9TwB6nPC9RDWuT
         q9VU0PKC49O3DNZ4sX1YbTmDZW5Lv+U0JTUF62jsxlQzN797Qgeobc//xXWRbWFDx7
         oWDSihyi5sV04saCuC+h1oBdJBlowY4h7mIF7cWCe8p+Yw+P1BH6rwqRxywzzwJeoH
         9hN/IFysDLIVA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id EAE67C433E9; Thu, 11 Aug 2022 03:51:14 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216352] [BISECTED] 250 ms system suspend performance regression
Date:   Thu, 11 Aug 2022 03:51:14 +0000
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
X-Bugzilla-Changed-Fields: cf_regression
Message-ID: <bug-216352-62941-jLSdWnXmtV@https.bugzilla.kernel.org/>
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

Len Brown (lenb@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
