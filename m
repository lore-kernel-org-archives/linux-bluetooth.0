Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24D5C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Dec 2022 01:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLIBRU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Dec 2022 20:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLIBRT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Dec 2022 20:17:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71482D2C0
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 17:17:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23E59B826CD
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Dec 2022 01:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB430C433F2
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Dec 2022 01:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670548635;
        bh=UksyXS24c+49X7N1Wg4QA+YRD8dJDcjDlTQy42FipMA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iBGrBudKqtUW/521tXs+ezhKfjP4ctkmU3miJNUd83m9JJ40WzkEpAIeVPlFfqBab
         cWWPjEoYnbg6wAlKqG5Ms0ULVNrTADhKrb5h4gP1OIsOxr9iEmBEvUyj9tXCkOXuBc
         ClKRBS3i2Z3SFW2U6Hw1pxnyr7Ta3+FIL58/7c4H861nE/54sPQUODtULj2M8j57vJ
         VlJTVclLvpC9/hJrqD86VwiXt8txJ4ZUNh5mY0/uKcmyKMoYnZboa+JiVYaSWZ0T5f
         hvaZb04v56/PAEZnUyEl3IQrDOtjIYSB5Vw8Tc56kU2ZAY+UQZb7P/Yw1cBkFicvNm
         nXnJeisRegcHA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BD646C43141; Fri,  9 Dec 2022 01:17:15 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215197] Memory leaks show up when using Edimax Wi-Fi N150
 Bluetooth/Wireless USB Adapter (RTL8XXXU)
Date:   Fri, 09 Dec 2022 01:17:15 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215197-62941-wz6BjzH90B@https.bugzilla.kernel.org/>
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

--- Comment #10 from Erhard F. (erhard_f@mailbox.org) ---
(In reply to rtl8821cerfe2 from comment #8)
> Hi!
>=20
> Can you check if this 100% untested patch fixes the leak?
Checked it out today. Seems you nailed it with your 100% untested patch! :)

I needed to take a small modification however or else I get a
"drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5609:1: error: expec=
ted
statement" at building.

The ';' before the function end needs to stay as 'out:' expects a statement
next. Sure ugly as hell but so is the accompanying goto a few lines above.


--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c     2022-12-09
01:51:56.213989176 +0100
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.cn    2022-12-09
01:56:35.543654839 +0100
@@ -5601,10 +5601,12 @@
                default:
                        break;
                }
+
+               dev_kfree_skb(skb);
        }

 out:
-       dev_kfree_skb(skb);
+       ;
 }

 static void rtl8723bu_handle_c2h(struct rtl8xxxu_priv *priv,


Patch applies on v6.1-rc8 and with this small modification building succeed=
s.
With the patch applied I have not seen the memleak since, even when taking
actions provoking it faster (e.g. unplugging and re-plugging the USB adapter
while playing sound). Without the patch v6.1-rc8 still shows the leak.

And so far I have not noticed any side effects of the patch in kernel dmesg.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
