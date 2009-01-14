Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Jan 2009 19:19:52 -0500 (EST)
From: Jim Faulkner <jfaulkne@ccs.neu.edu>
To: linux-bluetooth@vger.kernel.org
Subject: Sony BD Remote pairing problems with new distributions
Message-ID: <alpine.GSO.2.00.0901131907350.14823@denali.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


My sony BD remote (aka PS3 remote) requires a convoluted process to get it 
working each and every time my computer boots.  A description of the 
process I must use is here:
http://www.mythtv.org/wiki/index.php/Talk:Sony_PS3_BD_Remote

In short, I must hold down shift+enter on the remote to pair the device, 
kill some processes, and start some processes each time the computer 
boots.

This apparently did not used to be necessary with some older 
distributions.  For example, this was not necessary under Ubuntu 8.04, but 
is necessary under Ubuntu 8.10:
http://ubuntuforums.org/archive/index.php/t-874284.html
(page is down as I type so here's the google cache):
http://74.125.47.132/search?q=cache:YuyKFubNWPMJ:ubuntuforums.org/archive/index.php/t-874284.html+bdremoted&hl=en&ct=clnk&cd=8&gl=us&client=firefox-a

I am running 64-bit Gentoo, kernel 2.6.27.10.  I've tried both the 2.25 
userspace and the 4.21 userspace with no luck.

My questions are:  Are you guys aware of this problem?  Is there any known 
fix, besides downgrading to an older distribution?

thanks,
Jim Faulkner

PS please CC me on any replies, I'm not subscribed to this list.
