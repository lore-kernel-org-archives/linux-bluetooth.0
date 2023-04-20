Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951CCC77B72
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 09:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDTJ1d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 05:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDTJ1c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 05:27:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD782FC
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 02:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 793CA64683
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 09:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8486C4339E
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 09:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681982849;
        bh=9JhwmpFlzK1T3uEhhhk2QHV9mWrANG89u8WtjETVS9Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NGtMuFYCxYUzyc62fHbSwbTPpsJ2sgZaCpCgzlbPVClZq4Nj3Opo02FbtpBHXbuSb
         Um+aRi6pRIqvoFvHrzBDyd09Zhz1LUiUoRf2k2UZec6HPzHlrZCsIFM/ymlVx+nX/y
         4yyNErz2gBtf1+XK4WTAuLCgNS5qos6M5m26P02ju52JzvBCnyWMn+W0PzZM81IlRS
         w68QtIa27gMY9gUtLSGAptjfatI8sO6d4VFhs4m2dXp57IwbKYOX3BTnLdTQIyb+OQ
         aweWQNlwiCemvR/PWY338t/w79pHVPQp9DGxhOYqVGKziz/kYD42PjwiO938Bn4gmY
         7UizZ7vAoyIhg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C3332C43143; Thu, 20 Apr 2023 09:27:29 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217023] [Intel AX200] hci0: Malformed MSFT vendor event: 0x02
Date:   Thu, 20 Apr 2023 09:27:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: me@iyanmv.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217023-62941-tt6sEGAFhC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217023-62941@https.bugzilla.kernel.org/>
References: <bug-217023-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217023

Iy=C3=A1n (me@iyanmv.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |me@iyanmv.com

--- Comment #4 from Iy=C3=A1n (me@iyanmv.com) ---
Same error message on every boot with Intel Corporation Wi-Fi 6 AX201.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
