Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D4BC83F11
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Aug 2023 07:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjH1HSE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Aug 2023 03:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjH1HRg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Aug 2023 03:17:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B48115
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 00:17:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E28F163256
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 07:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55220C433C9
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 07:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693207052;
        bh=QLvmm2IW/gRd6rtNtPoGIvDJrwJ9hUqBG/Z03ShJz4s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hVVX5fyIyeHSL94Ks5wtKqdwnPTAoNvh/Io73TMiXyO2V3tqWe4Vn2pTLEoQqp/zh
         e9W319OS1l2fZHz3MjKNAIm07Vw0/APL0UQ1XHsnpNK1FrG6Ec3oadZAABXLU8+XSi
         fu1RS6+ocmhCmen+CW/ssQ2kic9guVRVtw8Zm9NJKWmsJAlEV+3qroPLyG+6203NQX
         WvK9DEZ86S3tI3bI8Y3YSUSdr8xTQqwYoUhQFoRV2fLEnNo1y4yYtBDYa1jz6Ld16o
         +nzGxf3Sbx0jVhQol94WvbAjLmKEv4RLUSCb5ucFJD+Htvabsf3cg76tpK2vIwHwiP
         5rwhGXXUsQ6fg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 333F6C4332E; Mon, 28 Aug 2023 07:17:32 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217805] Qualcomm NFA725A on T14s AMD Gen3: Bluetooth: hci0:
 Failed to send headers (or body or access otp area)
Date:   Mon, 28 Aug 2023 07:17:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: fanf42@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217805-62941-zwi4agNDtV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217805-62941@https.bugzilla.kernel.org/>
References: <bug-217805-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217805

--- Comment #1 from Fran=C3=A7ois Armand (fanf42@gmail.com) ---
Created attachment 304965
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D304965&action=3Dedit
lsmod

I failed to attach lsmod, so here we go.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
