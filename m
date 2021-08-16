Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7921AC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 06:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5483461A54
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 06:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbhHPGjk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 02:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230442AbhHPGjf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 02:39:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8F53261A87
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 06:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629095944;
        bh=WBrtuW7WsDNykXeu7kZZhao6sbI/Kcqu8wN7YagZa/o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DWnfbcb12IVueO6d64DI3zmv2pnuYFiqxN7E/GAwGgF0fssmpdxLtOy1QpwvoJZ9p
         DoIaC4e91kUhOeVdkghiOyIYrY2XOjm3w1j4rcEUCPehjrxWO4M0KDaAzNVKmdeHMD
         2aI/usbAdOL+a+XdMyD19ixa6y5vF9ytOq2RZTH9v/O6LsE27CcXPfvPRoQnx+2XNo
         aqPLZacReGCKEk+/tdBBcAonXPVVkxlrAPLA6xYfDGFaY0/JMx/uSjXq+qEq3XWudz
         7NJfB1/upPmvZu0nYmhLWixwalRFDCc9vQco0GMVr+Z4XVUFgAZUCyCA1JN7yq9lv+
         aqE6wb9IMcSzg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 16 Aug 2021 06:39:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jayfu@web.de
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-eEbwJlDpgK@https.bugzilla.kernel.org/>
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

--- Comment #197 from Jay (jayfu@web.de) ---
Here is the output:

< HCI Command: Read Local Version I.. (0x04|0x0001) plen 0  #1 [hci0] 14.11=
4796
> HCI Event: Command Complete (0x0e) plen 12                #2 [hci0] 14.11=
8624
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.0 (0x06) - Revision 12576 (0x3120)
        LMP version: Bluetooth 4.0 (0x06) - Subversion 8891 (0x22bb)
        Manufacturer: Cambridge Silicon Radio (10)

I wonder that it says Bluetooth 4.0, because it was sold as 5.0 and also on=
 the
plug "V5.0" is printed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
