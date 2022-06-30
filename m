Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E06AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 14:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiF3Odz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiF3Odj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 10:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872725C9C0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 07:16:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23C5F622EF
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 14:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 870C1C341DA
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 14:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656598600;
        bh=jacRQTSr+03RGYvp6YYw8mpZtOagOo312GaIScX3kn8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HA/S04D7YJro1ToFVLP4kMIQefV74kJ5UEN3iwdwccxOWJvGZ0sUj8c6HluwRtdIg
         HjkPWwse1F3jNdOOaz8DE8WGuzPW83fG/j7PLWDUhIJ+aCLXgMZpaMYVcqr31RCUK/
         XkFrKJyaUYyZUY28lHpEMPuLiVj6ijIoHS6y8z1xzT0VrUPoHk1IkD0Q0DaNO4WwvH
         34wBqDMdUXGfXnptA+XpSQW7SxQXV31SJdzLAMq5I5cUe93nV7BbWAy8jODcBUcKub
         JmfaTUQTKx32S8B2yXGnARsNawn1Vb0mfAh1xEAbdblOJ1r+9MK+XlpWrb6qwyHSpD
         zqUJu/y4qf7/Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 77653CC13AD; Thu, 30 Jun 2022 14:16:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Thu, 30 Jun 2022 14:16:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pieroavola@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-TIe4nQzQmB@https.bugzilla.kernel.org/>
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

--- Comment #39 from Piero Avola (pieroavola@gmail.com) ---
The problem still occurs for me:

$ uname -r
> 5.18.7-arch1-1

$ lsusb | grep -i bluetooth
> Bus 001 Device 002: ID 8087:0029 Intel Corp. AX200 Bluetooth

# dmesg | grep -i bluetooth
> [    6.640015] Bluetooth: hci0: command 0xfc05 tx timeout
> [    6.640018] Bluetooth: hci0: Reading Intel version command failed (-11=
0)

Sometimes reloading btusb via modprobe fixes the issue, on my current boot =
the
two lines from dmesg just repeat.

Bluetooth hasn't worked reliably since 5.14 with this device, it's a huge
inconvenience.

I'm gonna try out the fix posted in the message before. If there's anything=
 I
can do to help, please let me know.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
