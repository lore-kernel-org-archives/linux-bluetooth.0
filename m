Return-Path: <jerome.debretagne@gmail.com>
Message-ID: <1475533357.2947.3.camel@gmail.com>
Subject: Bluetooth not working anymore due to too agressive PM in hci_bcm ?
 (was: [PATCH v5 5/5] Bluetooth: hci_bcm: Add suspend/resume runtime PM
 functions)
From: =?ISO-8859-1?Q?J=E9r=F4me?= de Bretagne <jerome.debretagne@gmail.com>
To: Frederic Danis <frederic.danis@linux.intel.com>, Marcel Holtmann
	 <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Date: Tue, 04 Oct 2016 00:22:37 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic, Hi Marcel,

I've been trying to figure this out for quite some time: since the Bluetooth
BCM chipset of my ThinkPad 8 tablet was added into Linux kernel 4.6,
Bluetooth has never been working fully as expected.

To describe the issue: Bluetooth devices (keyboard, mouse) would work and
keep connected *only* if a device scan was maintained running in the
background. In my setup, the trick was achieved by having the Gnome
Bluetooth setting page opened. Without this trick, devices would simply stop
responding after a short amount of time; my BT keyboard would also seem
disconnected during the session login (despite btattach being properly
launched in the background) and would resume right away with a device scan.

I don't know if this issue is widespread but I've found references to at
least 2 similar cases at [1] & [2], both for products using hci_bcm. In the
bug descriptions, it was stated that kernel 4.3 was working fine while 4.4
wasn't anymore. And indeed, I was able to reproduce this on my side.

By investigating the various changes introduced in 4.4, I've been able to
pinpoint the commit [3] that introduces the regression on my tablet:
   commit: e88ab30d3669f08e94e66e7f926713be93af97fc
   Bluetooth: hci_bcm: Add suspend/resume runtime PM functions

since building a kernel with its parent commit [4] works perfectly fine: 
   commit: 7649faff1cfe4f76dabf78cd53d659d39f65b3c1
   Bluetooth: Remove useless rx_lock spinlock

The code change adding the runtime PM functions introduces an autosleep
delay but it's unclear from the commit description how the BT chipset is
supposed to get out of sleep afterwards.

For 3 different devices at least (Asus T100 Chi, Asus T100TA and Lenovo
ThinkPad Tablet 8), it seems to lead in practice to a regression since the
BT chipset doesn't wake up anymore on normal operations (moving the mouse,
typing a key on the keyboard, etc) breaking Bluetooth from a user PoV. And
maybe a few more products using hci_bcm are impacted too.   

If you have a patch suggestion for a potential fix, I would be glad to give
it a try in the coming days and confirm if it solves the issue or not. 

If a proper fix is going to need quite more time otherwise, could you
consider reverting this specific commit in the meantime? Thanks.

Regards,

Jérôme


[1] https://bugzilla.kernel.org/show_bug.cgi?id=109321#c3 (Comments 3 & 4)
for Asus T100TA
[2] https://bugzilla.kernel.org/show_bug.cgi?id=114561#c1 for Asus T100 Chi
[3] https://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.gi
t/commit/?id=e88ab30d3669f08e94e66e7f926713be93af97fc
[4] https://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.gi
t/commit/?id=7649faff1cfe4f76dabf78cd53d659d39f65b3c1
