Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Cambrige chip, 2.6.3
From: Marcel Holtmann <marcel@holtmann.org>
To: Petec <petesblackhole@yahoo.co.uk>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <loom.20040311T223500-626@post.gmane.org>
References: <loom.20040311T223500-626@post.gmane.org>
Content-Type: text/plain
Message-Id: <1079087942.738.18.camel@merlin>
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
Date: Fri, 12 Mar 2004 11:39:03 +0100

Hi Pete,

> Im running 2.6.3 on ibm thinkpad x31 with internal bluetooth. All I seem to be
> able to do is use hcitool scan and hcitool inq, all other bluetooth related
> things seem to fail. This problem has followed me from 2.4.2x to this kernel as
> I only upgraded to try to get it working! If anyone could help I would really
> appreciate, ive been working on this (till the wee hours) for some days now. 
> 
> [root@petespad test]# hcitool inq
> Inquiring ...
>         00:0E:07:39:35:62       clock offset: 0x7522    class: 0x520204
> [root@petespad test]#
> 
> For instance, hcitool info {address} fails:-
> 
> [root@petespad test]# hcitool info 00:0E:07:39:35:62
> Requesting information ...
> Can't create connection: Connection timed out
> [root@petespad test]#
> 
> Using hcidump during this operation produces:-
> 
> [root@petespad root]# /usr/sbin/hcidump
> HCIDump - HCI packet analyzer ver 1.7
> device: hci0 snap_len: 1028 filter: 0xffffffff
> #< HCI Command: Create Connection(0x01|0x0005) plen 13
> #> HCI Event: Command Status(0x0f) plen 4
> #> HCI Event: Link Key Request(0x17) plen 6
> #> HCI Event: Connect Complete(0x03) plen 11
> 
> Looks to me like the computer is not responding to a key request from the phone.

looks like you are in security mode 3. Don't enable auth and encrypt in
hcid.conf. Let the mobile phone trigger the security mechanism.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
