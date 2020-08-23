Return-Path: <SRS0=oHmC=CB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACF3C433E1
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Aug 2020 06:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B7422B43
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Aug 2020 06:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgHWG6r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Aug 2020 02:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgHWG6q (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Aug 2020 02:58:46 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 23 Aug 2020 06:58:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mmdesai20@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-iBD1YAZddQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

--- Comment #141 from MMD (mmdesai20@gmail.com) ---
(In reply to MMD from comment #140)
> (In reply to Swyter from comment #137)
> > Hi! There's actually a script that should help with this, at least as
> > reference:
> > https://gist.github.com/nevack/6b36b82d715dc025163d9e9124840a07
> > 
> > It's for newer kernels, though. So while the btusb.c part should more or
> > less apply cleanly (because the existing/original CSR workaround stuff has
> > been there for a while) the ERR_DATA_REPORTING stuff (on hci_core.c) is new
> > and will need to be stripped out when back-porting the patch.
> > 
> > Who knows, maybe it's a good idea to ask someone from Canonical to add it
> to
> > Ubuntu, once it's been more battle-tested. Hopefully (as it officially gets
> > into stable kernels) distros downstream will pick this up, even on super
> old
> > Linux versions.
> > 
> > Hope that helps. :)
> 
> Hi tried this script, but it gives below error
> cp: cannot stat '/usr/lib/modules/5.8.2-050802-generic/build/.config': No
> such file or director
> 
> I checked there is no such directory and file.
> 
> I have Ubuntu 20.04 LTS with Kernel 5.4.0-42-generic. Then updated kernel to
> hoping that 5.8.2-050802-generic hoping by Bluetooth device will work with
> this .(As you mentioned this script is accepted in 5.7 and 5.8 version of
> kernel)
> With new kernel 5.8.2-050802-generic, it detects logitech M337 mouse , but
> not able to configure. Then I tried above script and got error
> cp: cannot stat '/usr/lib/modules/5.8.2-050802-generic/build/.config': No
> such file or director

I tried some command as suggested by you on
https://gist.github.com/nevack/6b36b82d715dc025163d9e9124840a07

Here is the output of its


lsusb -vvd 0a12:0001... gives bcdDevice 25.20

dmesg |grep 'CSR clone detected'
[   75.420911] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds...
[ 4880.814947] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds...
[22664.573526] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds...
[23268.855461] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds...

btmon -w my.log
Bluetooth monitor ver 5.54
= Note: Linux version 5.8.2-050802-generic (x86_64)                            
                                                                               
          0.574027
= Note: Bluetooth subsystem version 2.22                                       
                                                                               
               0.574029
= New Index: 00:1A:7D:DA:71:10 (Primary,USB,hci0)                              
                                                                               
        [hci0] 0.574030
@ MGMT Open: bluetoothd (privileged) version 1.17                              
                                                                               
      {0x0001} 0.574031
@ MGMT Open: btmon (privileged) version 1.17

hcidump -X
HCI sniffer - Bluetooth packet analyzer ver 5.53
device: hci0 snap_len: 1500 filter: 0xffffffffffffffff

-- 
You are receiving this mail because:
You are the assignee for the bug.
