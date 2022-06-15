Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA4BC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jun 2022 11:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244721AbiFOLSB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jun 2022 07:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244569AbiFOLR7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jun 2022 07:17:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF7730F6F
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 04:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FAD4B81D6D
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 11:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32CE8C341D0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 11:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655291876;
        bh=jcNwK7vm5fkBFHxk2fNnfVAocJKfDOFQDeETQSo6dCE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Hu5X0pjBvFhDxSJfhUDt5zb5gDqtzX3iDkYSL/SMFf5/a/YYt/hOCbmnQIqJVTWnG
         AANUTUCccOrHeFlOMCZBZUwvy1VlWzjO9LSLP2Sr6ASkDH4BhfaMKwfc/4AxFNdNYt
         n5gX/icYac/OaVg8L36CIgziuzvMeG3pVMvw069xCxnBm2mllO1fm0iRlwCH22HwhC
         W8vttQfZuPz7R0bvKRI6IqrMlq5YZuzC+WqBGmnM4MkwHLlhsJfls0baz+ES7l4pBL
         WVhtraZM6lKBAG7jtlUfB3nDOkuZB9/YFQba58DLIbDRkszacPbAFseYsx6GoKoEnw
         m43RzJY93ZsRg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2114FCC13B0; Wed, 15 Jun 2022 11:17:56 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Wed, 15 Jun 2022 11:17:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kvaster@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-EbA60DEyFQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

--- Comment #38 from Viktor Kuzmin (kvaster@gmail.com) ---
Following patch fixes problem for me:

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ea72afb..b94a6da 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -714,7 +714,7 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
                }

                gpiod_set_value_cansleep(reset_gpio, 0);
-               msleep(200);
+               msleep(500);
                gpiod_set_value_cansleep(reset_gpio, 1);

                return;

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
