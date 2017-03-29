Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 64671] hci0 command 0x1009 tx timeout, bluez can't find adapter
Date: Wed, 29 Mar 2017 22:58:46 +0000
Message-ID: <bug-64671-62941-nTF3OemNBO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-64671-62941@https.bugzilla.kernel.org/>
References: <bug-64671-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=64671

--- Comment #9 from MOHAMMAD RASIM (mohammad.rasim96@gmail.com) ---
(In reply to Maxim Moseychuk from comment #8)
> (In reply to Ongun Kanat from comment #7)
> > I've got same behavior on 4.9.8 kernel on PC with Atheros AR3012 card.
> 
> (In reply to MOHAMMAD RASIM from comment #6)
> > I have the same issue and the same dmesg error.
> > 
> > My adapter is:
> > Broadcom Corporation BCM4313 802.11bgn Wireless Network Adapter [14e4:4727]
> > (rev 01)
> > I had the problem on archlinux but now I'm running linux mint and have the
> > same problem.
> > 
> > Current kernel:
> > Linux mohammad-mint 4.4.0-21-generic #37-Ubuntu SMP Mon Apr 18 18:33:37 UTC
> > 2016 x86_64 x86_64 x86_64 GNU/Linux
> 
> Can someone test my patch? This bug not always reproduce, and i need help
> for test 1-2 week.
> 
> I can send raw patch, branch on github or PKGBUILD for archlinux.

I can test the patch can you send it please?

-- 
You are receiving this mail because:
You are the assignee for the bug.