Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Aben Siatris <aben@webcom.sk>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] No more bluez.o in 2.6?
References: <20040407172325.GC9593@magma.epfl.ch> <200404101743.00181.aben@webcom.sk> <20040410160451.GB26618@magma.epfl.ch>
In-Reply-To: <20040410160451.GB26618@magma.epfl.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200404101845.15176.aben@webcom.sk>
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
Date: Sat, 10 Apr 2004 18:45:15 +0200

D=C5=88a Saturday 10 April 2004 18:04 ste nap=C3=ADsali:
> On Sat, Apr 10, 2004 at 05:43:00PM +0200, Aben Siatris wrote:
>=20
> Hello Aben :-)
>=20
> > ad first, you must make connection.
> > tip - add ifconfig and iptables to hotplug and
> > to /etc/init.d/net.bnep0.
> >=20
> > tail from /var/messages
> >=20
> > Apr 10 17:23:04 gentoo_aben pand[15975]: New connection from 08:00:28:8=
4:C2:E4 bnep0
> > Apr 10 17:23:04 gentoo_aben default.hotplug[15977]: arguments (net) env=
 (OLDPWD=3D/ DEVPATH=3D/class/net/bnep0 PATH=3D/bin:/sbin:/usr/sbin:/usr/bi=
n ACTION=3Dadd PWD=3D/etc/hotplug HOME=3D/ SHLVL=3D2 INTERFACE=3Dbnep0 DEBU=
G=3Dyes SEQNUM=3D647 _=3D/bin/env)
> > Apr 10 17:23:04 gentoo_aben default.hotplug[15977]: invoke /etc/hotplug=
/net.agent ()
> > Apr 10 17:23:04 gentoo_aben net.agent[15977]: script=3D/etc/init.d/net.=
bnep0 in action add
> > Apr 10 17:23:04 gentoo_aben net.agent[15977]: adding bnep0
> >=20
> > and now i am in lan and internet with mi ipaq
> >=20
> > (sorry for my english :)
>=20
> If your prefer French or German (only language I know).
>=20
> Would it be possible to have a complete example (I mean just the script
> you use)?

yes, no problem :)

bash-2.05b# more /etc/init.d/bluetooth
#!/sbin/runscript
# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/net-wireless/bluez-utils/files/bluetoot=
h.rc,v 1.3 2004/03/06 03:52:52 vapie
r Exp $

UART_CONF=3D"/etc/bluetooth/uart"

depend() {
        after hotplug
}

start_uarts() {
        [ -f /usr/sbin/hciattach -a -f ${UART_CONF} ] || return
        grep -v '^#' $UART_CONF | while read i; do
                /usr/sbin/hciattach $i
        done
}

stop_uarts() {
        killall hciattach > /dev/null 2>&1
}

start() {
        local RETVAL
        ebegin "Starting Bluetooth"
        [ -x /usr/sbin/hcid ] && \
                start-stop-daemon --start --quiet --exec /usr/sbin/hcid
        RETVAL=3D$?
        [ $RETVAL -a -x /usr/sbin/sdpd ] && \
                start-stop-daemon --start --quiet --exec /usr/sbin/sdpd
        RETVAL=3D$?
        start_uarts
        eend ${RETVAL}
}

stop() {
        local RETVAL
        ebegin "Shutting down Bluetooth"
        [ -x /usr/sbin/hcid ] && \
          start-stop-daemon --stop --quiet --exec /usr/sbin/hcid
        RETVAL=3D$?
        [ -x /usr/sbin/sdpd ] && \
                start-stop-daemon --stop --quiet --exec /usr/sbin/sdpd
        RETVAL=3D$?
        stop_uarts
        eend ${RETVAL}
}


bash-2.05b# more /etc/init.d/bluetooth_pan
#!/sbin/runscript
# Distributed under the terms of the GNU General Public License, v2 or later

depend() {
        need bluetooth
}

start() {
        local RETVAL
        ebegin "Starting Bluetooth PAN"
        [ -x /usr/bin/pand ] && \
                start-stop-daemon --start --quiet --exec /usr/bin/pand --\
                --listen --role NAP
        RETVAL=3D$?
        [ $RETVAL -a -x /usr/bin/dund ] && \
                start-stop-daemon --start --quiet --exec /usr/bin/dund --\
                --listen --msdun call dun
        RETVAL=3D$?
        eend ${RETVAL}
}

stop() {
        local RETVAL
        ebegin "Shutting down Bluetooth PAN"
        [ -x /usr/bin/pand ] && \
          start-stop-daemon --stop --quiet --exec /usr/bin/pand
        RETVAL=3D$?
        [ -x /usr/bin/dund ] && \
                start-stop-daemon --stop --quiet --exec /usr/bin/dund
        RETVAL=3D$?
        eend ${RETVAL}
}

bash-2.05b# more /etc/conf.d/net.bnep0
# /etc/conf.d/net:
iface_bnep0=3D"192.168.20.1 broadcast 192.168.20.255 netmask 255.255.255.0"
gateway=3D"eth0/192.168.0.1" # is this right?



bash-2.05b# more /etc/init.d/net.bnep0
#!/sbin/runscript

#NB: Config is in /etc/conf.d/net
depend() {
        use hotplug bluetooth
}

checkconfig() {
        if [ -z "${iface_IFACE}" ]
        then
                eerror "Please make sure that /etc/conf.d/net has \$iface_$=
IFACE set"
                return 1
        fi
        if [ -n "${vlans}" -a \! -x /sbin/vconfig ]
        then
                eerror "For VLAN (802.1q) support, emerge net-misc/vconfig"
                return 1
        fi
}

setup_env() {
        # No reason to check these multiple times in the file
        iface=3D"${1/\./_}"
        iface_IFACE=3D"$(eval echo \$\{iface_${iface}\})"
        dhcpcd_IFACE=3D"$(eval echo \$\{dhcpcd_${iface}\})"
        inet6_IFACE=3D"$(eval echo \$\{inet6_${iface}\})"
        alias_IFACE=3D"$(eval echo \$\{alias_${iface}\})"
        status_IFACE=3D"$(ifconfig | gawk -v IFACE=3D"${iface}" '$0 ~ /Link=
/ { if ($1 =3D=3D IFACE) print "up" }')"
        vlans=3D"$(eval echo \$\{iface_${IFACE}_vlans\})"
}

iface_start() {
        local retval=3D0

        setup_env ${1}
        checkconfig || return 1

        local IFACE=3D"${1}"
        ebegin "Bringing ${IFACE} up"
        if [ "${iface_IFACE}" !=3D "dhcp" ]
        then
                /sbin/ifconfig ${IFACE} ${iface_IFACE} >/dev/null || {
                        retval=3D$?
                        eend ${retval} "Failed to bring ${IFACE} up"
                        return ${retval}
                }
                # ifconfig do not always return failure ..
                /sbin/ifconfig ${IFACE} &> /dev/null || {
                        retval=3D$?
                        eend ${retval} "Failed to bring ${IFACE} up"
                        return ${retval}
                }
        else
                # Check that eth0 was not brough up by the kernel ...
                if [ "${status_IFACE}" !=3D "up" ]
                then
                        /sbin/dhcpcd ${dhcpcd_IFACE} ${IFACE} >/dev/null ||=
 {
                                retval=3D$?
                                eend ${retval} "Failed to bring ${IFACE} up"
                                return ${retval}
                        }
                fi
        fi
        eend 0

        if [ -n "${alias_IFACE}" ]
        then
                local x=3D""
                local num=3D0
                local aliasbcast=3D""
                local aliasnmask=3D""

                ebegin "  Adding aliases"
                for x in ${alias_IFACE}
                do
                        aliasbcast=3D"$(eval echo \$\{broadcast_${iface}\} =
\| awk \'\{ print \$$((num + 1)) \}\')
"
                        if [ -n "${aliasbcast}" ]
                        then
                                aliasbcast=3D"broadcast ${aliasbcast}"
                        fi

                        aliasnmask=3D"$(eval echo \$\{netmask_${iface}\} \|=
 awk \'\{ print \$$((num + 1)) \}\')"
                        if [ -n "${aliasnmask}" ]
                        then
                                aliasnmask=3D"netmask ${aliasnmask}"
                        fi

                        ebegin "    ${IFACE}:${num}"
                        /sbin/ifconfig ${IFACE}:${num} ${x} \
                                ${aliasbcast} ${aliasnmask} >/dev/null
                        num=3D$((num + 1))
                        eend 0
                done
                save_options "alias" "${alias_IFACE}"
        fi

        if [ -n "${inet6_IFACE}" ]
        then
                local x=3D""
                ebegin "  Adding inet6 addresses"
                for x in ${inet6_IFACE}
                do
                        ebegin "    ${IFACE} inet6 add ${x}"
                        /sbin/ifconfig ${IFACE} inet6 add ${x} >/dev/null
                        eend 0
                done
                save_options "inet6" "${inet6_IFACE}"
        fi

        if [ -n "${gateway}" ] && [ "${gateway%/*}" =3D "${IFACE}" ]
        then
                ebegin "  Setting default gateway"
                # First delete any existing routes if it was setup by kerne=
l ..
                /sbin/route del default dev ${gateway%/*} &>/dev/null
                /sbin/route add default gw ${gateway#*/} dev ${gateway%/*} \
                        netmask 0.0.0.0 metric 1 >/dev/null || {

                        local error=3D$?
                        ifconfig ${IFACE} down &>/dev/null
                        eend ${error} "Failed to bring ${IFACE} up"
                        stop
                        return ${error}
                }
                eend 0
        fi

        # Enabling rp_filter causes wacky packets to be auto-dropped by
        # the kernel.  Note that we only do this if it is not set via
        # /etc/sysctl.conf ...
        if [ -e /proc/sys/net/ipv4/conf/${IFACE}/rp_filter ] && \
           [ -z "$(egrep '^[^#]*rp_filter' /etc/sysctl.conf 2>/dev/null)" ]
        then
                echo 1 > /proc/sys/net/ipv4/conf/${IFACE}/rp_filter
        fi
}

iface_stop() {
        local myalias=3D"$(get_options alias)"
        local myinet6=3D"$(get_options inet6)"

        setup_env ${1}
        local IFACE=3D"${1}"

        ebegin "Bringing ${IFACE} down"

        # Also down the inet6 interfaces
        if [ -n "${myinet6}" ]
        then
                local x=3D""
                for x in ${myinet6}
                do
                        /sbin/ifconfig ${IFACE} inet6 del ${x} >/dev/null
                done
        fi

        # Do some cleanup in case the amount of aliases change
        if [ -n "${myalias}" ]
        then
                local x=3D""
                local num=3D0
                for x in ${myalias}
                do
                        /sbin/ifconfig ${IFACE}:${num} down >/dev/null
                        num=3D$((num + 1))
                done
        fi

        if [ "${iface_IFACE}" =3D "dhcp" ]
        then
                local count=3D0
                while /sbin/dhcpcd -z ${IFACE} &>/dev/null && [ "${count}" =
=2Dlt 9 ]
                do
                        # Give dhcpcd time to properly shutdown
                        sleep 1
                        count=3D$((count + 1))
                done
                if [ "${count}" -ge 9 ]
                then
                        eerror "Timed out trying to stop dhcpcd"
                fi
        else
                /sbin/ifconfig ${IFACE} down >/dev/null
        fi
        eend 0
}

start() {
        iface_start ${IFACE} || return 1
        for vlan in ${vlans}
        do
                /sbin/vconfig add ${IFACE} ${vlan} >/dev/null
                iface_start ${IFACE}.${vlan}
        done
}

stop () {
        setup_env ${IFACE}
        checkconfig || return 1
        for vlan in ${vlans}
        do
                iface_stop ${IFACE}.${vlan}
                /sbin/vconfig rem ${IFACE}.${vlan} >/dev/null
        done
        iface_stop ${IFACE}
}


bash-2.05b# more /etc/hotplug/net.agent
#!/bin/bash
#

cd /etc/hotplug
=2E hotplug.functions
DEBUG=3Dyes export DEBUG

if [ "$INTERFACE" =3D "" ]; then
    mesg Bad NET invocation: \$INTERFACE is not set
    exit 1
fi


script=3D/etc/init.d/net.$INTERFACE

debug_mesg "script=3D/etc/init.d/net.$INTERFACE in action $ACTION"

case $ACTION in
add|register)
    # Don't do anything if the network is stopped
#    if [ ! -f /var/lock/subsys/network ]; then
#       exit 0
#    fi

        debug_mesg "adding $INTERFACE"
    case $INTERFACE in
        # interfaces that are registered after being "up" (?)
        ppp*|ippp*|isdn*|plip*|lo*|irda*|dummy*|ipsec*|tun*|tap*)
            debug_mesg assuming $INTERFACE is already up
            exit 0
            ;;
        # interfaces that are registered then brought up
        *)
            export IN_HOTPLUG=3D1
            if [ -x "$script" ]; then
                debug_mesg invoke "$script" --quiet start
                exec "$script" --quiet start
            fi
            exit 0
            ;;
    esac
    mesg $1 $ACTION event not handled
    ;;

unregister|remove)
    case $INTERFACE in
        # interfaces that are unregistered after being "down" (?)
        ppp*|ippp*|isdn*|plip*|lo*|irda*)
            debug_mesg assuming $INTERFACE is already down
            exit 0
            ;;
        *)
            if [ -x "$script" ]; then
                debug_mesg invoke "$script" --quiet stop
                exec "$script" --quiet stop
            fi
            exit 0
            ;;
    esac
    mesg $1 $ACTION event not handled
    ;;

*)
    debug_mesg NET $ACTION event for $INTERFACE not supported
    exit 1 ;;

esac



and that's all :))




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
