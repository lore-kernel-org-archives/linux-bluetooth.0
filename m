Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A105CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 May 2022 00:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355226AbiE1AP3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 May 2022 20:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239671AbiE1AP1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 May 2022 20:15:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2F112AB38
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 May 2022 17:15:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8F97B82178
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 May 2022 00:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B2C0C3411B
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 May 2022 00:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653696923;
        bh=vK/rQ5/8qXN4OdEc4h/ZXEjlkk6AMlTn/QRF+h7sgxw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JD4GgUEDGc03O9TcokbetYaASY4/PY7Zx+QYcP545KCLXYFT5w6Md7xGVcMvAUmA3
         +az6RFs6uBIl7pArJ6LvqbX1KheeEmVgQUAuBfHBh5dF4OZwhQuPaEszLtrTfuqB+W
         iPg7UhO/MDirDehRWQEy2Mp55cE01IByb8sY8pL0kYMWMBlxJSRuTsYZT9cEm5LlI8
         7tYaS0ov3zqcRwbN8goYdhvoVTboidEgZFYcu6l5HKaNWs8WP/4AqG5pZoGlcHE4Rk
         tp1foRaTyprfzNviGsp+UZL6cCyZ+JDUDME285tMNEy6IMzmygaQ3dKTDhiFiuiia0
         SwVUuta8hbX2g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 57B25C05FF5; Sat, 28 May 2022 00:15:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Sat, 28 May 2022 00:15:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: daniel.wennberg@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215576-62941-q5C5UDQ12w@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215576-62941@https.bugzilla.kernel.org/>
References: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

--- Comment #13 from Daniel Wennberg (daniel.wennberg@gmail.com) ---
The regression tracker expressed a similar sentiment here:
https://patchwork.kernel.org/project/bluetooth/patch/20220401233826.122544-=
1-luiz.dentz@gmail.com/#24810088

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
