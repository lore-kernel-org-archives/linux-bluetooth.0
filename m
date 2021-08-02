Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD0EC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 14:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA76760F50
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 14:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhHBOd7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 10:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233985AbhHBOd7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 10:33:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BCC0C60F4B
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Aug 2021 14:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627914829;
        bh=yHE0xzTqccsrwQOMJSEsgnV7ZyvtzvXYw44cFrtBsMg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Tz1a8MoGyzCQjlrjOPyQO4lJ1ow01z/KOAJx/VoSrMicX1+RHfmgvQUx4vpWNpBVT
         hDSxHxOvhptCNpheQPkaQTV8s4NMdpSWQeO0N0t68TFe6LDB79ZE4SQgWzj/fxzuVw
         Lp8rTyxUNzGfh4ZEZd7J8pnLcLgr+Vq6ENc2Pk8qrBoQFp0qmRBMDpYveg3Z2uI4wy
         25jOxpLftIhDCb1MvXh4jHUPFnb8TBcoa0s0DYT6jAhJ1/XtpNIhgDOawHaWBzeR+1
         oqeU8urnMRZUKaDADIhNvA1blaKjrqLvqhEVCh+zuuV2VJqtbOqSj78v9x50nApV3+
         7gjK5safkLMxw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213369] Bluetooth Will Not Enable Intel AX200
Date:   Mon, 02 Aug 2021 14:33:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tomek@kolosowscy.pl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-213369-62941-epgFc2oZl5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213369-62941@https.bugzilla.kernel.org/>
References: <bug-213369-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213369

Tomasz Ko=C5=82osowski (tomek@kolosowscy.pl) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tomek@kolosowscy.pl

--- Comment #1 from Tomasz Ko=C5=82osowski (tomek@kolosowscy.pl) ---
I have a very similar issue with Intel AX210 since kernel 5.13, last working
version for me is 5.12.15. In my case downgrading bluez doesn't solve the
issue, only downgrading the kernel helps.

$ systemctl status bluetooth.service=20=20=20=20=20=20
=E2=97=8F bluetooth.service - Bluetooth service
     Loaded: loaded (/usr/lib/systemd/system/bluetooth.service; enabled; ve=
ndor
preset: disabled)
     Active: active (running) since Mon 2021-08-02 16:14:22 CEST; 14min ago
       Docs: man:bluetoothd(8)
   Main PID: 78618 (bluetoothd)
     Status: "Running"
      Tasks: 1 (limit: 76960)
     Memory: 748.0K
        CPU: 11ms
     CGroup: /system.slice/bluetooth.service
             =E2=94=94=E2=94=8078618 /usr/lib/bluetooth/bluetoothd

sie 02 16:14:22 nest systemd[1]: Starting Bluetooth service...
sie 02 16:14:22 nest bluetoothd[78618]: Bluetooth daemon 5.60
sie 02 16:14:22 nest systemd[1]: Started Bluetooth service.
sie 02 16:14:22 nest bluetoothd[78618]: Starting SDP server
sie 02 16:14:22 nest bluetoothd[78618]: Bluetooth management interface 1.20
initialized

Intrestingly, on kernel 5.12 it reports management interface version 1.19

$ rfkill
ID TYPE      DEVICE      SOFT      HARD
 0 wlan      phy0     blocked unblocked
 1 bluetooth hci0   unblocked unblocked

$ bluetoothctl=20=20=20=20
Agent registered
[bluetooth]# show
No default controller available
[bluetooth]#=20

$ btmgmt
[mgmt]# info
Index list with 0 items
[mgmt]# config
Unconfigured index list with 1 item
hci0:   Unconfigured controller
        manufacturer 2
        supported options: public-address=20
        missing options: public-address=20
[mgmt]#

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
