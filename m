Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Nov 2008 08:52:33 -0600
From: Robert Moskowitz <rgm@htt-consult.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <4926CB31.2060104@htt-consult.com>
In-Reply-To: <491B543E.1000304@htt-consult.com>
References: <491B543E.1000304@htt-consult.com>
MIME-Version: 1.0
Subject: [Bluez-users] Can't start pand -- is the problem in
	/etc/rc.d/init.d/pand?
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
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is on Centos (RHEL 5, FC6ish):

I have been stepping into pand. There is nothing I can find on this list 
about getting pand working. There are some instructions on 
wifi.bluez.org that seem to be redhatish, but....

I have edited /etc/sysconfig/pand:

PANDARGS='--listen --role GN --master'


I have created a /etc/sysconfig/network-scripts/ifcfg-bnep0:

DEVICE=bnep0
BOOTPROTO=none
ONBOOT=no
IPADDR=192.168.201.101
NETMASK=255.255.255.0


I run: service pand start

nothing happens.

I look at: /etc/rc.d/init.d/pand and see:

[ -x /etc/bluetooth/pan/system-up ] && /etc/bluetooth/pan/system-up

huh? My system does not have an /etc/bluetooth/pan directory. there is a

/etc/sysconfig/network-scripts/ifup-bnep

So I decided to create an /etc/bluetooth/pan/dev-up file as I found at: 
http://ph.ubuntuforums.com/showthread.php?t=598890

#!/bin/bash
ifup bnep0

Still nothing. pand is not starting and there are no messages in 
/var/log/messages



what am I missing here?




-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
