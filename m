Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: Lalith Chakravarthi <lalithvc@yahoo.com>
Subject: Re: [Bluez-users] Shell script during bluetooth connection
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <20040310124449.40181.qmail@web40704.mail.yahoo.com> <1078923303.2537.33.camel@pegasus>
In-Reply-To: <1078923303.2537.33.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200403150028.18630.pavouk@pavouk.org>
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
Date: Mon, 15 Mar 2004 00:28:18 +0100

Hi,

> I don't use RedHat, but in general there is not a big difference between
> an executable file and an executable shell script. It is important that
> the script is mode 755. However you can also put your script directly
> into /etc/hotplug/net.agent.

I use net.agent from last hotplug tools.

Older net.agent, for example in Mandrake 9.2 doesn't have support for 2.6 
kernel (Action "add", not "register").

Script /etc/hotplug/net.agent is here:
-----------------------------------------------------------------------
#!/bin/bash
#
# Network hotplug policy agent for Linux 2.4 kernels
#
# Kernel NET hotplug params include:
#
#       ACTION=%s [register or unregister]
#       INTERFACE=%s
#
# HISTORY:
#
# 25-Feb-2001   Special case ppp and similar (redhat)
# 23-Jan-2001   Log invocation of "ifup" if debugging
# 04-Jan-2001   Initial version of "new" hotplug agent.
#
# $Id: net.agent,v 1.15 2003/10/07 19:56:24 kroah Exp $
#

cd /etc/hotplug
. hotplug.functions
# DEBUG=yes export DEBUG

if [ "$INTERFACE" = "" ]; then
    mesg Bad NET invocation: \$INTERFACE is not set
    exit 1
fi

case $ACTION in
add|register)
    # Don't do anything if the network is stopped
    if [ ! -f /var/lock/subsys/network ]; then
       exit 0
    fi

    case $INTERFACE in
        # interfaces that are registered after being "up" (?)
        ppp*|ippp*|isdn*|plip*|lo*|irda*|dummy*|ipsec*|tun*|tap*)
            debug_mesg assuming $INTERFACE is already up
            exit 0
            ;;
        # interfaces that are registered then brought up
        *)
            # NOTE:  network configuration relies on administered state,
            # we can't do much here without distro-specific knowledge
            # such as whether/how to invoke DHCP, set up bridging, etc.

            # RedHat and similar
            export IN_HOTPLUG=1
            if [ -x /sbin/ifup ]; then
                debug_mesg invoke ifup $INTERFACE
                exec /sbin/ifup $INTERFACE
            else
                mesg "how do I bring interfaces up on this distro?"
            fi
            ;;
    esac
    mesg $1 $ACTION event not handled
    ;;

*)
    debug_mesg NET $ACTION event not supported
    exit 1 ;;

esac
---------------------------------------------------------------------------------------
When I click "connect" on my Zaurus, my linux desktop automatically configure 
bnep0 interface.
Config file is here: /etc/sysconfig/network-scripts/ifcfg-bnep0
----------------------------------------------------------
DEVICE=bnep0
BOOTPROTO=static
IPADDR=192.168.130.1
NETMASK=255.255.255.0
ONBOOT=no
---------------------------------------------------------

If you want to have debug messages about hotplug, please uncomment this line:
"DEBUG=yes export DEBUG" in file /sbin/hotplug.
You found now debug messages in /var/log/messages.

Best regards,

Pavel Ruzicka



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
