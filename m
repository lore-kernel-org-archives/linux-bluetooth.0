Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B21AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 14:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347622AbiC3O7X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 10:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347602AbiC3O7W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 10:59:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AA41015
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 07:57:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CDF061616
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 14:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF061C340EC
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 14:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648652255;
        bh=CUGrjI4VgbTzQ4EJHOdUvFfr1ge+d3+fMUIIKT8ZQj8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Wl82lvZ2p2XuDBS2VRwRj2uUFxtdIIIWm4cPDFj0kKsm23xePlL2bYZin5aetSP0E
         G/1QyDaFF4xvs+WUoiH1OPQxCvqsScVei1qbp0EECGrNLaSworVWwmUhfABS6cZIqW
         y+72p2lPno2JvvnvjamzXqxW1ZPScSKs0343nq3ypnAsq4WI11S3nmrs1dm5p7X1b9
         F3MmvnpLYZ2UzYjs8O6a4aUBiFyQlyzq3iQg3sGwgtCtQ/diKW/LjskUN4RM2vZq2E
         82Lr2VB3chxKuhtmZ2Nza5TVr49Il9z7md9m9Qhdj/SXDX48W5d3/Ltxr5MSG+g6ME
         4ROMTbWk+mnBw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C9801C05FCE; Wed, 30 Mar 2022 14:57:35 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Wed, 30 Mar 2022 14:57:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pverda@ziggo.nl
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-jOH3FSkvQI@https.bugzilla.kernel.org/>
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

--- Comment #228 from pverda@ziggo.nl ---
Apparently there are quite some dongles that choke on suspending. These don=
gles
really need the module option enable_autosuspend=3D0 and will not work with=
out
it. Unfortunately the Barrot quirck in btusb_setup_csr prevents this to
function properly. To avoid this I propose the following modification in the
module btusb.c

In function btusb_setup_csr changing this:
<code>
                pm_runtime_allow(&data->udev->dev);

                ret =3D pm_runtime_suspend(&data->udev->dev);
                if (ret >=3D 0)
                        msleep(200);
                else
                        bt_dev_err(hdev, "CSR: Failed to suspend the device=
 for
our Barrot 8041a02 receive-issue workaround");

                pm_runtime_forbid(&data->udev->dev);

                device_set_wakeup_capable(&data->udev->dev, false);

                /* Re-enable autosuspend if this was requested */
                if (enable_autosuspend)
                        usb_enable_autosuspend(data->udev);
</code>
into this:
<code>
                if (enable_autosuspend) {
                        pm_runtime_allow(&data->udev->dev);

                        ret =3D pm_runtime_suspend(&data->udev->dev);
                        if (ret >=3D 0)
                                msleep(200);
                        else
                                bt_dev_err(hdev, "CSR: Failed to suspend the
device for our Barrot 8041a02 receive-issue workaround");

                        pm_runtime_forbid(&data->udev->dev);

                        device_set_wakeup_capable(&data->udev->dev, false);

                        /* Re-enable autosuspend if this was requested */
                        usb_enable_autosuspend(data->udev);
                }
</code>
If the module options are absent, as it is supposed to be for plug and play,
there is no difference. The default of enable_autosuspend =3D true. The
modification of the function also honors the true meaning of
enable_autosuspend. That is stop suspending if made 0.
I have tested the above modification in my system: Fedora 35 with kernel
5.16.17-200 and it works. My dongle is one that needs kernel options
enable_autosuspend=3D0 and reset=3D1.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
