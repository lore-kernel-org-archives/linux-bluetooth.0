Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Petec <petesblackhole@yahoo.co.uk>
Message-ID: <loom.20040311T223500-626@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Cambrige chip, 2.6.3
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 11 Mar 2004 21:43:42 +0000 (UTC)

Hi,

Im running 2.6.3 on ibm thinkpad x31 with internal bluetooth. All I seem to be
able to do is use hcitool scan and hcitool inq, all other bluetooth related
things seem to fail. This problem has followed me from 2.4.2x to this kernel as
I only upgraded to try to get it working! If anyone could help I would really
appreciate, ive been working on this (till the wee hours) for some days now. 

[root@petespad test]# hcitool inq
Inquiring ...
        00:0E:07:39:35:62       clock offset: 0x7522    class: 0x520204
[root@petespad test]#

For instance, hcitool info {address} fails:-

[root@petespad test]# hcitool info 00:0E:07:39:35:62
Requesting information ...
Can't create connection: Connection timed out
[root@petespad test]#

Using hcidump during this operation produces:-

[root@petespad root]# /usr/sbin/hcidump
HCIDump - HCI packet analyzer ver 1.7
device: hci0 snap_len: 1028 filter: 0xffffffff
#< HCI Command: Create Connection(0x01|0x0005) plen 13
#> HCI Event: Command Status(0x0f) plen 4
#> HCI Event: Link Key Request(0x17) plen 6
#> HCI Event: Connect Complete(0x03) plen 11

Looks to me like the computer is not responding to a key request from the phone.

The pin helper refered to in /etc/bluetooth/hcid.conf is set to a globaly
excutable script to echo a 6 digit pin.

The phone is a t610. 

Using a hot key to disable and re-enable the adapter produces output (at the
bottom - its long) in /var/log/messages. There is mention of being unable to
load hci_usb, but I dont think this is the case as I can modprobe it in and
rmmod it out. Hotplug is producing a lot of this output - whether hotplug makes
any difference I am not sure - I get the same results either way. Ive tried
every possible permutation.

If it dident work at all that would be easier to understand! I just dont get it,
being able to scan the phone but not do any more... any ideas?

Greets, Pete


Mar 11 21:15:00 petespad kernel: usb 4-1: USB disconnect, address 5
Mar 11 21:15:00 petespad hcid[5504]: HCI dev 0 down
Mar 11 21:15:00 petespad default.hotplug[14511]: arguments (bluetooth) env
(OLDPWD=/ PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=unregister PWD=/etc/hotplug
HOME=/ SHLVL=2 DEVICE=hci0 DEBUG=yes _=/bin/env)
Mar 11 21:15:00 petespad default.hotplug[14511]: no runnable
/etc/hotplug/bluetooth.agent is installed
Mar 11 21:15:00 petespad default.hotplug[14521]: arguments (usb) env (OLDPWD=/
DEVPATH=/devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=remove PWD=/etc/hotplug HOME=/ SHLVL=2
DEVICE=/proc/bus/usb/004/005 PRODUCT=1668/441/546 TYPE=224/1/1 DEBUG=yes
SEQNUM=201 _=/bin/env)
Mar 11 21:15:00 petespad default.hotplug[14521]: invoke /etc/hotplug/usb.agent 
)
Mar 11 21:15:00 petespad default.hotplug[14541]: arguments (usb) env (OLDPWD=/
DEVPATH=/devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.1
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=remove PWD=/etc/hotplug HOME=/ SHLVL=2
DEVICE=/proc/bus/usb/004/005 PRODUCT=1668/441/546 TYPE=224/1/1 DEBUG=yes
SEQNUM=202 _=/bin/env)
Mar 11 21:15:00 petespad default.hotplug[14541]: invoke /etc/hotplug/usb.agent 
)
Mar 11 21:15:00 petespad default.hotplug[14557]: arguments (usb) env (OLDPWD=/
DEVPATH=/devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.2
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=remove PWD=/etc/hotplug HOME=/ SHLVL=2
DEVICE=/proc/bus/usb/004/005 PRODUCT=1668/441/546 TYPE=224/1/1 DEBUG=yes
SEQNUM=203 _=/bin/env)
Mar 11 21:15:00 petespad default.hotplug[14557]: invoke /etc/hotplug/usb.agent
()
Mar 11 21:15:00 petespad default.hotplug[14568]: arguments (usb) env (OLDPWD=/
DEVPATH=/devices/pci0000:00/0000:00:1d.2/usb4/4-1
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=remove PWD=/etc/hotplug HOME=/ SHLVL=2
DEBUG=yes SEQNUM=204 _=/bin/env)
Mar 11 21:15:00 petespad default.hotplug[14568]: invoke /etc/hotplug/usb.agent 
)
Mar 11 21:15:00 petespad hcid[5504]: HCI dev 0 unregistered
Mar 11 21:15:01 petespad devlabel: devlabel service started/restarted
Mar 11 21:15:01 petespad devlabel: devlabel service started/restarted
Mar 11 21:15:01 petespad modprobe: FATAL: Module ide_probe_mod not found.
Mar 11 21:15:01 petespad modprobe: FATAL: Module ide_probe not found.
Mar 11 21:15:01 petespad kernel: updfstab: numerical sysctl 1 23 is obsolete.
Mar 11 21:15:01 petespad modprobe: FATAL: Module ide_probe_mod not found.
Mar 11 21:15:01 petespad modprobe: FATAL: Module ide_probe not found.
Mar 11 21:15:01 petespad kernel: updfstab: numerical sysctl 1 23 is obsolete.
Mar 11 21:15:01 petespad devlabel: devlabel service started/restarted
Mar 11 21:15:01 petespad modprobe: FATAL: Module ide_probe_mod not found.
Mar 11 21:15:01 petespad modprobe: FATAL: Module ide_probe not found.
Mar 11 21:15:01 petespad kernel: updfstab: numerical sysctl 1 23 is obsolete.
 
And reloaded...
 
Mar 11 21:15:50 petespad kernel: usb 4-1: new full speed USB device using 
ddress 6
Mar 11 21:15:50 petespad default.hotplug[15939]: arguments (usb) env (OLDPWD=/
DEVPATH=/devices/pci0000:00/0000:00:1d.2/usb4/4-1
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/ SHLVL=2
DEBUG=yes SEQNUM=205 _=/bin/env)
Mar 11 21:15:50 petespad default.hotplug[15939]: invoke /etc/hotplug/usb.agent 
)
Mar 11 21:15:50 petespad default.hotplug[15953]: arguments (usb) env (OLDPWD=/
DEVPATH=/devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/ SHLVL=2
DEVICE=/proc/bus/usb/004/006 PRODUCT=1668/441/546 TYPE=224/1/1 DEBUG=yes
SEQNUM=206 _=/bin/env)
Mar 11 21:15:50 petespad default.hotplug[15953]: invoke /etc/hotplug/usb.agent 
)
Mar 11 21:15:50 petespad default.hotplug[15964]: arguments (bluetooth) env
(OLDPWD=/ PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=register PWD=/etc/hotplug
HOME=/ SHLVL=2 DEVICE=hci0 DEBUG=yes _=/bin/env)
Mar 11 21:15:50 petespad default.hotplug[15964]: no runnable
/etc/hotplug/bluetooth.agent is installed
Mar 11 21:15:50 petespad default.hotplug[15974]: arguments (usb) env (OLDPWD=/
DEVPATH=/devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.1
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/ SHLVL=2
DEVICE=/proc/bus/usb/004/006 PRODUCT=1668/441/546 TYPE=224/1/1 DEBUG=yes
SEQNUM=207 _=/bin/env)
Mar 11 21:15:50 petespad default.hotplug[15974]: invoke /etc/hotplug/usb.agent 
Mar 11 21:15:50 petespad usb.agent[15974]: Setup hci_usb for USB product
1668/441/546
Mar 11 21:15:50 petespad usb.agent[15974]: missing kernel or user mode driver
hci_usb
Mar 11 21:15:50 petespad default.hotplug[16008]: arguments (usb) env (OLDPWD=/
DEVPATH=/devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.2
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/ SHLVL=2
DEVICE=/proc/bus/usb/004/006 PRODUCT=1668/441/546 TYPE=224/1/1 DEBUG=yes
SEQNUM=208 _=/bin/env)
Mar 11 21:15:50 petespad default.hotplug[16008]: invoke /etc/hotplug/usb.agent 
)
Mar 11 21:15:50 petespad usb.agent[16008]: Setup hci_usb for USB product
1668/441/546
Mar 11 21:15:50 petespad usb.agent[15953]: Setup hci_usb for USB product
1668/441/546
Mar 11 21:15:50 petespad hcid[5504]: HCI dev 0 registered
Mar 11 21:15:50 petespad usb.agent[15953]: missing kernel or user mode driver
hci_usb
Mar 11 21:15:50 petespad usb.agent[16008]: missing kernel or user mode driver
hci_usb
Mar 11 21:15:50 petespad hcid[5504]: HCI dev 0 up
Mar 11 21:15:51 petespad devlabel: devlabel service started/restarted
 


Greets, Pete







-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
