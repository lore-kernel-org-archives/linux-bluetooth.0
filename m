Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7334DC64ED6
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Feb 2023 23:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBZX7e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Feb 2023 18:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBZX7d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Feb 2023 18:59:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13710CDD5
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Feb 2023 15:59:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD4A1B80CA7
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Feb 2023 23:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FB48C433A0
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Feb 2023 23:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677455969;
        bh=1CYGKrNvubo2OA2w9sZFKRVbg93fMLXwwP9eoXuT1gA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Fp5Lajc6Qglc1PCZvWXGmEPkFsnQfMq/wTVgHcvvjmcnFs2t2O84V6oL5+nAxf5Cv
         aT1aF5dF8NDbRv/rNFNo4k80p28BbGsUkuouWCkvd9l9S9a7mWIbhClss0CsT/+v6T
         P7q3WuC6gTWHcXRQ4wsZCDIDrHjiZU3Qt2mxS7ChxmjFpHR9Oe9j/MY30KetV7uWje
         TcwHpOX8SaTsapPncgbjREpbbSuk3jY2jVu7155++1Y6yjSi9MBhvtIAwy5OfTYFZF
         WDCz/sb6RPyIkdIswTlCPr4bu+g7B0bxfkFta6+g3qDRLoJnH0PU5Of73n7kkQh0MQ
         rFaNF4eCRFbGw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 62FAEC43145; Sun, 26 Feb 2023 23:59:29 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Sun, 26 Feb 2023 23:59:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: oleksandr@natalenko.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-74zOg38pG8@https.bugzilla.kernel.org/>
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

--- Comment #48 from Oleksandr Natalenko (oleksandr@natalenko.name) ---
(In reply to Chaim Eliyah from comment #46)
> | Reloading `btusb` module several times makes it working.
>=20
> Any specific steps for this? I have not been able to get it to work. Issue
> persists despite reboots incl. hard power off/on. This happened suddenly.

No specific steps, just `modprobe -r btusb && modprobe btusb`.

I'm not facing the issue regularly, for me it happened only once recently a=
fter
I powered off the system completely for a couple of days. The issue does not
occur across reboots or suspends/resumes. It also doesn't occur after each
power off (at least, so far).

I've adopted the patch from c#38 like below just to be on the safe side:

```
commit 2875e3ab82d1777a06a356167c52a745827b2ad1
Author: Oleksandr Natalenko <oleksandr@natalenko.name>
Date:   Sun Feb 26 00:17:09 2023 +0100

    Bluetooth: btusb: work around command 0xfc05 tx timeout

    Instead of realoding `btusb` module to tackle this:

    ```
    Bluetooth: hci0: command 0xfc05 tx timeout
    Bluetooth: hci0: Reading Intel version command failed (-110)
    ```

    increase `btusb_qca_cmd_timeout()` sleep duration while hoping
    for the best.

    This looks like an ugly hack.

    Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215167
    Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2ad4efdd9e40..7aff6c468c0d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -901,7 +901,7 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
                }

                gpiod_set_value_cansleep(reset_gpio, 0);
-               msleep(200);
+               usleep_range(USEC_PER_SEC / 2, USEC_PER_SEC);
                gpiod_set_value_cansleep(reset_gpio, 1);

                return;
```

Let me know if you are able to test it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
