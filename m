Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13E7C77B7F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 May 2023 12:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjECMan (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 May 2023 08:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjECMam (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 May 2023 08:30:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AAF10E5
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 May 2023 05:30:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 864F6623D9
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 May 2023 12:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD071C433D2
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 May 2023 12:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683117040;
        bh=/wlhHNPjHMfLSiA7rG81FcsARi/1SnreY7Jqjhdd4iU=;
        h=From:To:Subject:Date:From;
        b=Sg8m3eiwfYKI1RcVQnmcRq9AevNEPykxZ6V0bbFgy0SbIcsX9S1As0WD4Dye5+UAn
         pp4IWb4mAekAm3/FFOh6JpoXR9H25RfxoxoFKwCXDv86yyFcUQ5c8OmHqqCIzaQhgi
         ardp2Ll+cbZ5Fq5NItzBj54JF9zlaGqVZYaYrhAroqtz33ipF+PcXE1k1zmww9jeap
         WAEmiG5HtTBwW+PkXPypVCW4dFXApAqNbHre8IPH5dzyhd/gIpruJo1LU2KCQ9vMJg
         wyN7htVzcHSibQ+vF6HjOvKu/leFjwv9qE9av93XQX6ZSaADJ7/EzggidPYNDVTbhc
         oQDdApkwv9UUQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CB98FC43143; Wed,  3 May 2023 12:30:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217396] New: Transferring of VCF file fails
Date:   Wed, 03 May 2023 12:30:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-217396-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217396

            Bug ID: 217396
           Summary: Transferring of VCF file fails
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: pmenzel+bugzilla.kernel.org@molgen.mpg.de
        Regression: No

Created attachment 304207
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D304207&action=3Dedit
Output of `sudo btmon`

Laptop: Intel Broadwell Dell Latitude E7250 with Debian sid/unstable and Li=
nux
6.1.25
Smartphone: Samsung Galaxy S10(?) with Android

Sending a contact file (suffix .vcf) from the Samsung to the laptop with GN=
OME,
GNOME shows a notification about the transfer, but after accepting it, the
transfer is shown as failed.

Please find the output of `sudo btmon` attached. I removed the file content
part to not share any private information.

Transferring the file from the Samsung phone to a Nokia N9 worked.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
