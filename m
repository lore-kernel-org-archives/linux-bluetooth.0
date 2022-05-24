Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F61C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 19:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbiEXT5G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 15:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241244AbiEXT5E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 15:57:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11FD19030
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 12:57:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A10CB81AA1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 19:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36848C34100
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 19:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653422221;
        bh=fJSLwLrFu4YSqqdipDXI9u3Om4rgNNIbg1wIHyXYxhk=;
        h=From:To:Subject:Date:From;
        b=uagtSi6M5infgRYJCKJasFr7RXtANFB7wzkbazV5oGyt0kCx5KbzybPBBvrgtEZwb
         DiYxWJly2sFUTzkW1BV7iVi+hPy6tplMeS2i3RaDcDhiqSxUlH7dWm25f66OJO1Buf
         x78W5ifw000bz1wlviH8xJiO1N3qhwvGbfSTrsZUga3CkMfb2Om9yfpDjPDqTXbGQk
         E/eU9CipbRyHN02x5gO9nFuF8e6D5sFPPuwhW8jqG7h3hsxG+BTZu+C2a0ppCTIBrx
         F+Srn4P+NlN0Yc3q0zOQ+OyjUhcWsyQqZVchHKsNIpfUOIPFr/C8SCWYoEVw0QfXeu
         KahX/ak5Ik7Wg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 05D18C05FD2; Tue, 24 May 2022 19:57:01 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216022] New: JBL Live 660NC
Date:   Tue, 24 May 2022 19:57:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: contact.tarneo@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216022-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216022

            Bug ID: 216022
           Summary: JBL Live 660NC
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.17.9-arch1-1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: contact.tarneo@gmail.com
        Regression: No

A friend of mine tried to use his JBL Live 660NC headset on arch linux, the
sound works great, but he just can't use the microphone (not even selectabl=
e as
an output).=20

Output of lspci and lsusb:
https://pastebin.com/wgzYxGz8

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
