Return-Path: <cyrus@holtmann.org>
Message-ID: <36fee7420808300506t430fa556u8ba8a9e866d44f5e@mail.gmail.com>
Date: Sat, 30 Aug 2008 20:06:40 +0800
From: "Wei Lei" <weilei84@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Using bluez in virtual machine
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1465703260=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1465703260==
Content-Type: multipart/alternative;
	boundary="----=_Part_34095_29832170.1220098000521"

------=_Part_34095_29832170.1220098000521
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

It appears to me that using USB Bluetooth adapters with bluez facilities is
possible in a virtual machine, when the USB port is delegated to the guest
OS. However It did not work when I experiment, the host OS is Windows XP and
guest OS is ubuntu-8.04. I am using VMWare workstation 5. Could someone tell
where the problem is?

I have configured VMWare to use windows USB devices. When a bluetooth
adapter is plugged in, tail -f /var/log/messages shows the usb device is
connected.

$ lsusb shows:
Bus 001 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
Dongle (HCI mode)

But `hcitool dev` shows no device is connected. This is part of the strace
log:

socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 3
brk(0)                                  = 0x8052000
brk(0x8073000)                          = 0x8073000
ioctl(3, 0x800448d2, 0x8052008)         = 0
close(3)                                = 0
exit_group(0)                           = ?
Wei Lei

------=_Part_34095_29832170.1220098000521
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><div>Hi,</div>
<div>&nbsp;</div>
<div>It appears to me that using USB Bluetooth adapters with bluez facilities is possible in a virtual machine, when the&nbsp;USB port is delegated to the guest OS. However It did not work when I experiment,&nbsp;the host OS is Windows XP and guest OS is ubuntu-8.04. I am using VMWare workstation 5. Could someone tell where the problem is?</div>

<div>&nbsp;</div>
<div>I have configured VMWare to use windows USB devices. When a bluetooth adapter is plugged in,&nbsp;tail -f /var/log/messages shows the usb device is connected.&nbsp;</div>
<div>&nbsp;</div>
<div>$&nbsp;lsusb shows:</div>
<div>Bus 001 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)</div>
<div>&nbsp;</div>
<div>But&nbsp;`hcitool dev` shows no device is connected. This is part of the strace log:</div>
<div>&nbsp;</div>
<div>socket(PF_BLUETOOTH, SOCK_RAW, 1)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 3</div>
<div>brk(0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x8052000</div>
<div>brk(0x8073000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x8073000</div>
<div>ioctl(3, 0x800448d2, 0x8052008)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0</div>
<div>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0</div>
<div>exit_group(0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = ?<br></div>
<div>Wei Lei</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div></div>

------=_Part_34095_29832170.1220098000521--


--===============1465703260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1465703260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1465703260==--
