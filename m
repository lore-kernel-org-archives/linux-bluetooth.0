Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hotplug USB dongle problem
From: Stephen Crane <steve.crane@rococosoft.com>
To: Pavel Ruzicka <pavouk@pavouk.org>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <200402281424.55149.pavouk@pavouk.org>
References: <200402281424.55149.pavouk@pavouk.org>
Content-Type: text/plain
Message-Id: <1078232432.4557.21.camel@baroque.rococosoft.com>
Mime-Version: 1.0
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
Date: Tue, 02 Mar 2004 13:00:33 +0000

Hi Pavel,
Did you update hotplug? The invocation syntax changed with kernel 2.6.

Cheers,
Steve

On Sat, 2004-02-28 at 13:24, Pavel Ruzicka wrote:
> Hello,
> 
> I have configured Mandrake9.2 desktop with USB dongle.
> I have kernel 2.6.2
> When system is started, script /etc/rc.d/init.d/bluetooth
> is executed and runs "hcid" and "sdpd". It's probably OK
> 
> When I plug in USB dongle, I want to run "pand --listen --role NAP".
> I made /etc/hotplug/bluetooth.agent script, which is executed by hotplug 
> mechanism after inserting bluetooth dongle.
> bluetooth.agent:
> ------------------------------------------------------------------
> #!/bin/bash
> cd /etc/hotplug
> . hotplug.functions
> 
> case $ACTION in
>         add|register)
>                 pand --listen --role NAP
>         ;;
>         unregister)
>                 pand -K
>         ;;
>         *)
>         debug_mesg Bluetooth \$ACTION event not supported
> exit 1 ;;
> esac
> ------------------------------------------------------------------
> 
> When I made connection from other side now, that connection is NOT 
> established, and I found in log this message:
> -----------------------
> Feb 28 13:53:25 home pand[4470]: Connection failed. Inappropriate ioctl for 
> device(25)
> -----------------------
> 
> But, when I remove bluetooth.agent and run "pand --listen --role NAP" manually 
> from shell, everything works fine.
> I have /etc/sysconfig/network-scripts/ifcfg-bnep0:
> ----------------------------------
> DEVICE=bnep0
> BOOTPROTO=static
> IPADDR=192.168.130.1
> NETMASK=255.255.255.0
> ONBOOT=no
> ----------------------------------
> In this situation, when I click "Connect" on my Zaurus, that on my Mandrake 
> desktop Interface bnep0 goes up due to hotplug.
> Kernel runs /sbin/hotplug.
> This script runs /etc/hotplug/net.agent, which makes "ifup bnep0".
> I replaced this script with new from last hotplug package, because in Mandrake 
> is old script without 2.6 kernel support ("add" on place "register").
> 
> When somebody experiments with hotplug, it's very useful uncomment this line 
> in /sbin/hotplug:
> -----------------------------------
> DEBUG=yes export DEBUG
> -----------------------------------
> 
> This is log from /var/log/messages, when I insert USB dongle and I have 
> /etc/hotplug/bluetooth.agent on place:
> -------------------------------------------------------------------------------------
> Feb 28 14:15:21 home kernel: usb 2-1: new full speed USB device using address 
> 14
> Feb 28 14:15:21 home /sbin/hotplug: arguments (usb) env (OLDPWD=/ 
> DEVPATH=/devices/pci0000:00/0000:00:07.3/usb2/2-1 
> PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug SHLVL=1 HOME=/ 
> DEBUG=yes SEQNUM=254 _=/bin/env)
> Feb 28 14:15:21 home /sbin/hotplug: invoke /etc/hotplug/usb.agent ()
> Feb 28 14:15:21 home /sbin/hotplug: arguments (usb) env (OLDPWD=/ 
> DEVPATH=/devices/pci0000:00/0000:00:07.3/usb2/2-1/2-1:1.0 
> PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug SHLVL=1 HOME=/ 
> DEVICE=/proc/bus/usb/002/014 PRODUCT=db0/6970/525 TYPE=224/1/1 DEBUG=yes 
> SEQNUM=255 _=/bin/env)
> Feb 28 14:15:21 home /sbin/hotplug: invoke /etc/hotplug/usb.agent ()
> Feb 28 14:15:21 home /sbin/hotplug: arguments (bluetooth) env (OLDPWD=/ 
> PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=register PWD=/etc/hotplug SHLVL=1 
> HOME=/ DEVICE=hci0 DEBUG=yes _=/bin/env)
> Feb 28 14:15:21 home /sbin/hotplug: invoke /etc/hotplug/bluetooth.agent ()
> Feb 28 14:15:21 home pand[4814]: PAN daemon ver 1.1
> Feb 28 14:15:21 home /sbin/hotplug: arguments (usb) env (OLDPWD=/ 
> DEVPATH=/devices/pci0000:00/0000:00:07.3/usb2/2-1/2-1:1.1 
> PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug SHLVL=1 HOME=/ 
> DEVICE=/proc/bus/usb/002/014 PRODUCT=db0/6970/525 TYPE=224/1/1 DEBUG=yes 
> SEQNUM=256 _=/bin/env)
> Feb 28 14:15:21 home /sbin/hotplug: invoke /etc/hotplug/usb.agent ()
> Feb 28 14:15:21 home /etc/hotplug/usb.agent: Setup hci_usb for USB product 
> db0/6970/525
> Feb 28 14:15:21 home /sbin/hotplug: arguments (usb) env (OLDPWD=/ 
> DEVPATH=/devices/pci0000:00/0000:00:07.3/usb2/2-1/2-1:1.2 
> PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug SHLVL=1 HOME=/ 
> DEVICE=/proc/bus/usb/002/014 PRODUCT=db0/6970/525 TYPE=224/1/1 DEBUG=yes 
> SEQNUM=257 _=/bin/env)
> Feb 28 14:15:21 home /sbin/hotplug: invoke /etc/hotplug/usb.agent ()
> Feb 28 14:15:21 home hcid[2190]: HCI dev 0 registered
> Feb 28 14:15:21 home /etc/hotplug/usb.agent: Setup hci_usb for USB product 
> db0/6970/525
> Feb 28 14:15:21 home hcid[2190]: HCI dev 0 up
> Feb 28 14:15:21 home hcid[2190]: Starting security manager 0
> Feb 28 14:15:22 home /etc/hotplug/usb.agent: Setup hci_usb for USB product 
> db0/6970/525
> ------------------------------------------------------------------------------------------------
> 
> Can somebody help me, what can be wrong?
> What is right place for starting "pand"?
> 
> Thanks,
> 
> Pavel Ruzicka
> 
> 
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
