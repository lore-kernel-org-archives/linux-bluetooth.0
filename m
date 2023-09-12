Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503ADCA0EC9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 06:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjILGBE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 02:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjILGBD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 02:01:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6562AC4
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 23:00:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0123AC433C7
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 06:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694498459;
        bh=6eMGVqahH/xbkzJ5mNhsY+PpFybgqRj9dWHlzPO+FK0=;
        h=From:To:Subject:Date:From;
        b=BFiNRImEVFKfkzqb1tVAWeCaTLljf5fZ6TrYH+qvTxKXcILw1cAGvMqpfRaHz21yE
         APosFrkgAedG5H3kbOJsJzv0g7UJYlsdyxZVbsApKm6f5wHd5jAGuLoMkM4jMoVGOI
         cTaPL579Bcg+5Sxnu5Iypzxpk2qY5VOYvFzDCTgw7CgOyDb7W5VxUwmJilndrpM8Hj
         PthmIeCHxieUHmbnHH73Dotcwvg6Ml2c16/5oDp2A9w5LnSMlO9o85rE5ENOYhXo/p
         QlqK956bOYyj+wgaG3TZ//HAwwq4WgexnNsSVo10LZfoaE4YqaKH/dJKOgltnv8AQM
         tQlkKwVOsug7A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D8F51C4332E; Tue, 12 Sep 2023 06:00:58 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217903] New: Bluetooth doesn't work after trigger bluetoothctl
 scan on
Date:   Tue, 12 Sep 2023 06:00:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: kaichuan.hsieh@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-217903-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217903

            Bug ID: 217903
           Summary: Bluetooth doesn't work after trigger bluetoothctl scan
                    on
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: blocking
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: kaichuan.hsieh@canonical.com
        Regression: No

Created attachment 305093
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305093&action=3Dedit
journalctl_-b log

The device doesn't work after trigger bluetoothctl scan on

I bt devices listed for a while, but it didn't update anymore and start
deleting the expired objects.

I first see kernel reports

Sep 12 13:48:21 ubuntu kernel: Bluetooth: hci0: unexpected cc 0x041a length=
: 7
> 1

then...

Sep 12 13:52:21 ubuntu kernel: Bluetooth: hci0: Opcode 0x2042 failed: -110
Sep 12 13:52:21 ubuntu kernel: Bluetooth: hci0: command 0x2042 tx timeout

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
