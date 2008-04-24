Return-Path: <cyrus@holtmann.org>
From: "Phil Endecott" <spam_from_bluez_users@chezphil.org>
To: <bluez-users@lists.sourceforge.net>
Date: Thu, 24 Apr 2008 16:32:00 +0100
Message-ID: <1209051120274@dmwebmail.dmwebmail.chezphil.org>
In-Reply-To: <5eee8c670804231250s471d74aei656686225a35e5f0@mail.gmail.com>
References: <5eee8c670804231250s471d74aei656686225a35e5f0@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Apple wireless keyboard
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Odysseus Flappington wrote:
> I was also getting "UP RUNNING PSCAN ISCAN", unlike the initial bug-reporter
> but the 'hciconfig hci0 reset' command on reboot fixed the problem with my
> Apple keyboard. Have you actually tried it?

Yes, see below.  On more investigation it's less like the bug that you 
linked to than I initially suggested; it's time-consuming to work out 
exactly what makes it fail since some long timeouts seem to be 
involved.  Today I booted the PC and switched on the keyboard and it 
all worked for a few hours; I was then out for most of the afternoon 
and this is what happened:

Apr 24 13:29:42 egypt hcid[2850]: link_key_request 
(sba=00:11:67:00:00:00, dba=00:1E:52:F9:60:2C)
Apr 24 13:29:43 egypt hidd[2859]: New HID device 00:1E:52:F9:60:2C 
(Apple Inc. Keyboard)
Apr 24 13:29:43 egypt kernel: input: Apple Inc. Keyboard as /class/input/input8
Apr 24 13:46:48 egypt -- MARK --
Apr 24 13:59:54 egypt hcid[2850]: link_key_request 
(sba=00:11:67:00:00:00, dba=00:1E:52:F9:60:2C)
Apr 24 13:59:54 egypt hidd[2859]: New HID device 00:1E:52:F9:60:2C 
(Apple Inc. Keyboard)
Apr 24 13:59:54 egypt kernel: input: Apple Inc. Keyboard as /class/input/input9
Apr 24 14:30:06 egypt hcid[2850]: link_key_request 
(sba=00:11:67:00:00:00, dba=00:1E:52:F9:60:2C)
Apr 24 14:30:07 egypt hidd[2859]: New HID device 00:1E:52:F9:60:2C 
(Apple Inc. Keyboard)
Apr 24 14:30:07 egypt kernel: input: Apple Inc. Keyboard as /class/input/input10
Apr 24 14:46:48 egypt -- MARK --
Apr 24 15:00:19 egypt hcid[2850]: link_key_request 
(sba=00:11:67:00:00:00, dba=00:1E:52:F9:60:2C)
Apr 24 15:00:19 egypt hidd[2859]: New HID device 00:1E:52:F9:60:2C 
(Apple Inc. Keyboard)
Apr 24 15:00:19 egypt kernel: input: Apple Inc. Keyboard as /class/input/input11
Apr 24 15:17:01 egypt /USR/SBIN/CRON[17207]: (root) CMD (   run-parts 
--report /etc/cron.hourly)
Apr 24 15:30:32 egypt hcid[2850]: link_key_request 
(sba=00:11:67:00:00:00, dba=00:1E:52:F9:60:2C)
Apr 24 15:30:32 egypt hidd[2859]: New HID device 00:1E:52:F9:60:2C 
(Apple Inc. Keyboard)
Apr 24 15:30:32 egypt kernel: input: Apple Inc. Keyboard as /class/input/input12
Apr 24 15:46:48 egypt -- MARK --
Apr 24 16:00:32 egypt kernel: hci_acl_tx_to: hci0 ACL tx timeout
Apr 24 16:00:32 egypt kernel: hci_acl_tx_to: hci0 killing stalled ACL 
connection 2C:60:F9:52:1E:00
Apr 24 16:00:32 egypt kernel: hci_acl_tx_to: hci0 ACL tx timeout
Apr 24 16:00:32 egypt kernel: hci_acl_tx_to: hci0 killing stalled ACL 
connection 2C:60:F9:52:1E:00

So it looks like there is some sort of keep-alive that re-connects it 
every 30 mins (curiously almost exactly on the half-hours), until at 
16:00 it failed with those timeout messages.  It's now 16:21 and the 
keyboard isn't working (though it is still on).  If I power-cycle it, 
it tries to reconnect (flashing LED) but I see nothing in the syslog.  
If I then hciconfig hci0 reset I get this:

Apr 24 16:23:37 egypt hcid[2850]: HCI dev 0 down
Apr 24 16:23:37 egypt hcid[2850]: Stopping security manager 0
Apr 24 16:23:37 egypt hcid[2850]: Device hci0 has been disabled
Apr 24 16:23:37 egypt kernel: uhci_hcd 0000:00:10.2: release dev 2 
ep83-ISO, period 1, phase 0, 22 us
Apr 24 16:23:37 egypt kernel: uhci_hcd 0000:00:10.2: release dev 2 
ep81-INT, period 1, phase 0, 23 us
Apr 24 16:23:37 egypt kernel: uhci_hcd 0000:00:10.2: reserve dev 2 
ep81-INT, period 1, phase 0, 23 us
Apr 24 16:23:37 egypt kernel: uhci_hcd 0000:00:10.2: reserve dev 2 
ep83-ISO, period 1, phase 0, 22 us
Apr 24 16:23:47 egypt kernel: uhci_hcd 0000:00:10.2: release dev 2 
ep83-ISO, period 1, phase 0, 22 us
Apr 24 16:23:47 egypt kernel: uhci_hcd 0000:00:10.2: release dev 2 
ep81-INT, period 1, phase 0, 23 us

and the keyboard still doesn't work.  If I replug the USB dongle, it 
all starts working again.

So I think this is a lower-level problem with this USB dongle.  I 
noticed that there was a quirks entry in the kernel - HCI_RESET - for a 
device with a similar but not identical USB id (1131:1001 rather than 
1131:1004).  Maybe this is related.

Anyway, I have ordered a different dongle that might have the CSR chip 
with the HID proxy mode.  With luck that will make it all much simpler.

Regards,  Phil




-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
