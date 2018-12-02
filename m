Return-Path: <SRS0=kO+n=OL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976ADC04EB8
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Dec 2018 13:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CA020673
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Dec 2018 13:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CA020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbeLBNn3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Dec 2018 08:43:29 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:50854 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbeLBNn3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Dec 2018 08:43:29 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 36D712AAEC
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Dec 2018 13:43:26 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 2B3BB2AB29; Sun,  2 Dec 2018 13:43:26 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 201839] New: Unable to pair with JBL Bar Studio 2.0
Date:   Sun, 02 Dec 2018 13:43:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dap@rock.hu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-201839-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=201839

            Bug ID: 201839
           Summary: Unable to pair with JBL Bar Studio 2.0
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.19.2-200.fc28.x86_64
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: dap@rock.hu
        Regression: No

Created attachment 279787
  --> https://bugzilla.kernel.org/attachment.cgi?id=279787&action=edit
bluetoothd debug output

Hi,

I'm not able to pair with my new JBL Bar Studio 2.0 with Bluez 5.50. I put the
JBL into pairing mode but it always asks for PIN code and four zeros is not
accepted. The error message is:
Failed to pair: org.bluez.Error.AuthenticationFailed

At the same time I can pair Bluez with other devices like my Edimax speakers.
My Android 7.1.2 device able to pair/connect with the JBL without issues and
does not ask for PIN code.

BT dongle:
Bus 003 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle
(HCI mode)

OS:
Fedora 28 (Bluez 5.50) and OpenWrt v18.06.1 (Bluez 5.49)

# bluetoothctl
[bluetooth]# pairable on
Changing pairable on succeeded
[bluetooth]# discoverable on
Changing discoverable on succeeded
[bluetooth]# scan on
Discovery started
[...]
[NEW] Device E8:07:BF:25:F5:02 JBL Bar Studio

[bluetooth]# pair E8:07:BF:25:F5:02
Attempting to pair with E8:07:BF:25:F5:02
[CHG] Device E8:07:BF:25:F5:02 Connected: yes
[agent] Enter PIN code: 0000
Failed to pair: org.bluez.Error.AuthenticationFailed
[CHG] Device E8:07:BF:25:F5:02 Connected: no

-- 
You are receiving this mail because:
You are the assignee for the bug.
