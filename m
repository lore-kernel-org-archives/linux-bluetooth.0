Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1C5C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Dec 2022 10:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiLSKzY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Dec 2022 05:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiLSKzR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Dec 2022 05:55:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3862EEE06
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 02:55:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3F8EB80D6E
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 10:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F312C433F0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 10:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671447313;
        bh=NdE8b5f7uPOy46kmG1SThlhclGUJHZfzUxWen8LV/XE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uvq1vFz0UTMpV9xRLxKqx8erNJDLhcDeh87wUpgnAE+3FmH6c9XjSxLOzctmhQP45
         YSYVm7444iTF/ZF5hgbtQb8iVUEp9V1U5ph8KakQDrhO9Y69EPQfJs9WeXEUFHX679
         DaaTiWAZTWGZNMd0FbRFv+eBJ3UtGy9h6pA1dqTfYawHP9Ev8CwgYHTRxskn1XraoW
         xtI42KORyOcBuAV2icco0ndZ4JaZC7SfpNfpdETPIA6KufcMgfAeflUf6kymHXsRo5
         9BRFlrJvhgQREQmO3vcJzhLuRVcZ0pedFQHlOMHlnO3AGTtr6U/wRlD2D0+WK7lPU1
         1+C0oN0SRVL/Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6B5CEC43141; Mon, 19 Dec 2022 10:55:13 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216817] btusb device with ID 0489:e0d0 no longer working after
 v6.0
Date:   Mon, 19 Dec 2022 10:55:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quantumphazor@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216817-62941-LybIjk1Xgd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216817-62941@https.bugzilla.kernel.org/>
References: <bug-216817-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216817

--- Comment #3 from Andrew M (quantumphazor@gmail.com) ---
Unfortunately it sill fails with 6.1 from Arch testing and a latest git pull
(6.1.r13139.gf9ff5644bcc0) which both include that change.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
