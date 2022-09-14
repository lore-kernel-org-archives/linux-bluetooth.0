Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA1CECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Sep 2022 13:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiINNMv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Sep 2022 09:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiINNMr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Sep 2022 09:12:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A56F4F650
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 06:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 851EBCE17C2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 13:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4E2DC433C1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 13:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663161156;
        bh=ZWjF9DDydF0AQpMX33He8O8G1nNQAXRjz49paw0amyI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eYYo1B6TycjYSWRYQULGYEVYYW5O3Pc7lP0HXAKzgD6PD/8lvs94Cxp+xC2efqXQx
         UZLi5cis3iPb0qeHU6kFlxu30aGamK8sRd51ZLr4LEgW/siij2pxKTHk1fw65WjtIO
         JBhArYsvyCw9OlqltHpzB2ZXmiY0dSSYFo74ECI4FxRwhXRwb0hZI0sUPEgNIup1Dy
         NRxkyLCiJr5nXUp9YDLKqOP4XSXSp+BFX8Qp1DGt5jPPXXyocUYDb2AcBlXuB7z88F
         mBIAuuWGTPbXOmaJAKjxGzSZctD5e3pIWbvRWHUsyQJ2E+lRW9HNH8QVvWv8UG/ba7
         UOUI8DcJM/JLg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 970D6C433E6; Wed, 14 Sep 2022 13:12:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215197] Memory leaks show up when using Edimax Wi-Fi N150
 Bluetooth/Wireless USB Adapter (RTL8XXXU)
Date:   Wed, 14 Sep 2022 13:12:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: network-wireless
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-215197-62941-54uGcykt0T@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215197-62941@https.bugzilla.kernel.org/>
References: <bug-215197-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215197

Erhard F. (erhard_f@mailbox.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #299825|0                           |1
        is obsolete|                            |

--- Comment #6 from Erhard F. (erhard_f@mailbox.org) ---
Created attachment 301808
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301808&action=3Dedit
kernel .config (6.0-rc4, AMD FX-8370)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
