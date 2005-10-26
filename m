Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Re: Buetooth and SAMSUNG SGH-E340
From: Fredy P <digitalfredy@debiancolombia.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051025163115.GA29385@loulou-becane>
References: <20051020135234.GC28731@loulou-becane>
	<20051023123808.GA14322@elmicha.333200002251-0001.dialin.t-online.de>
	<20051023151215.GB31746@loulou-becane>
	<1130191981.9463.13.camel@localhost.localdomain>
	<20051025163115.GA29385@loulou-becane>
Content-Type: multipart/mixed;
	boundary="=-0zgVabLyfdRaHSnyBU1S"
Message-Id: <1130342970.8178.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 26 Oct 2005 11:09:28 -0500


--=-0zgVabLyfdRaHSnyBU1S
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El mar, 25-10-2005 a las 18:31 +0200, Philippe Berini escribi=F3:
i attached my /etc/init.d/bluez-utils but i'm using sarge, and if you
can write in the wiki (in spanish) how to config your movile phone (down
t610)=20
> * Fredy P <digitalfredy@debiancolombia.org> [Mon, Oct 24, 2005 at 05:12:5=
9PM -0500]:
>=20
> > El dom, 23-10-2005 a las 17:12 +0200, Philippe Berini escribi=F3:
> > umm now think to i know what is your prloblem, you can't paring the
> > devices because the pin helper by default is for X, for fix the problem
> > you need change the /usr/local/bin/bluez-localpin, see [1], again is in
> > spanish but you can read the config files and comands.
> > [1] http://el-directorio.org/index.php/Bluetooth_en_debian
>=20
> I can read Spanish, no problem about that :-)=20
>=20
> I can pair my devices, the mobile says it is paired. Obexftp still
> complains it can't connect (following the instructions given on both the
> web sites).
>=20
> # obexftp -b 00:12:47:AB:AF:46 -B 7 -l
> Browsing 00:12:47:AB:AF:46 ...
> Channel: 7
> No custom transport
> Connecting...bt: -1
> failed: connect
>=20
>=20
> I am wondering if the problem does not lie there:
>=20
> # /etc/init.d/bluez-utils restart
> Restarting bluez-utils: hcid sdpdsyntax error line 25
>  rfcomm.
>=20
> and the line 25 is as follows:
>=20
> vi /etc/init.d/bluez-utils
> [snip]=20
> SDPD=3D/usr/sbin/sdpd
>=20
> I can't see a syntax error...
>=20

--=-0zgVabLyfdRaHSnyBU1S
Content-Disposition: attachment; filename=bluez-utils
Content-Type: application/x-shellscript; name=bluez-utils
Content-Transfer-Encoding: 7bit

#! /bin/sh
#
# bluez-utils    Bluetooth subsystem starting and stopping
#
# Edd Dumbill <ejad@debian.org>
#
# startup control over dund and pand can be changed by 
# editing /etc/default/bluez-utils

PATH=/sbin:/bin:/usr/sbin:/usr/bin
DESC="Bluetooth services"

HCID=/usr/sbin/hcid
HCIATTACH=/usr/sbin/hciattach
HCID_NAME=hcid

HID2HCI=/usr/sbin/hid2hci

UART_CONF=/etc/bluetooth/uart

RFCOMM=/usr/bin/rfcomm
RFCOMM_NAME=rfcomm
RFCOMM_CONF=/etc/bluetooth/rfcomm.conf

SDPD=/usr/sbin/sdpd
SDPD_NAME=sdpd

DUND_DAEMON=/usr/bin/dund
DUND_NAME=dund
PAND_DAEMON=/usr/bin/pand
PAND_NAME=pand
HIDD_DAEMON=/usr/bin/hidd
HIDD_NAME=hidd

DUND_ENABLED=0
PAND_ENABLED=0
HIDD_ENABLED=0
DUND_OPTIONS=""
PAND_OPTIONS=""
HIDD_OPTIONS="--master --server"

test -f /etc/default/bluez-utils && . /etc/default/bluez-utils
test -f /etc/default/rcS && . /etc/default/rcS

. /lib/lsb/init-functions

# test for essential daemons
test -x $HCID || exit 0
test -x $HCIATTACH || exit 0
test -x $RFCOMM || exit 0
test -x $SDPD || exit 0

# disable nonessential daemons if not present
if test "$DUND_ENABLED" != "0"; then
	if ! test -f $DUND_DAEMON; then
		DUND_ENABLED=0
	fi
fi

if test "$PAND_ENABLED" != "0"; then
	if ! test -f $PAND_DAEMON; then
		PAND_ENABLED=0
	fi
fi

if test "$HIDD_ENABLED" != "0"; then
	if ! test -f $HIDD_DAEMON; then
		HIDD_ENABLED=0
	fi
fi

set -e

enable_hci_input()
{
	if [ "$VERBOSE" != no ]; then
 		log_success_msg "Switching on Bluetooth input devices..."
 		$HID2HCI --tohci
 	else
 		$HID2HCI --tohci >/dev/null 2>&1
 	fi
}

disable_hci_input()
{
 	if [ "$VERBOSE" != no ]; then
 		log_success_msg "Switching Bluetooth input devices back to HID mode..."
 		$HID2HCI --tohid
 	else
 		$HID2HCI --tohid >/dev/null 2>&1
 	fi
}

start_pan()
{
	if test "$DUND_ENABLED" != "0"; then
		start-stop-daemon --start --quiet --exec $DUND_DAEMON -- $DUND_OPTIONS
                [ "$VERBOSE" != no ] && log_success_msg "Starting $DUND_NAME..."
	fi
	if test "$PAND_ENABLED" != "0"; then
		start-stop-daemon --start --quiet --exec $PAND_DAEMON -- $PAND_OPTIONS
                [ "$VERBOSE" != no ] && log_success_msg "Starting $PAND_NAME..."
	fi
}


stop_pan()
{
	if test "$DUND_ENABLED" != "0"; then
		start-stop-daemon --stop --quiet --exec $DUND_DAEMON || true
		[ "$VERBOSE" != no ] && log_success_msg "Stopping $DUND_NAME..."
	fi
	if test "$PAND_ENABLED" != "0"; then
		start-stop-daemon --stop --quiet --exec $PAND_DAEMON || true
		[ "$VERBOSE" != no ] && log_success_msg "Stopping $PAND_NAME..."
	fi
}

start_hid()
{
	if test "$HIDD_ENABLED" != "0"; then
		start-stop-daemon --start --quiet --exec $HIDD_DAEMON -- $HIDD_OPTIONS
		[ "$VERBOSE" != no ] && log_success_msg "Starting $HIDD_NAME..."
	fi
}

stop_hid()
{
	if test "$HIDD_ENABLED" != "0"; then
		$HIDD_DAEMON --killall
		start-stop-daemon --stop --quiet --exec $HIDD_DAEMON || true
		[ "$VERBOSE" != no ] && log_success_msg "Stopping $HIDD_NAME..."
	fi
}

start_uarts()
{
	[ -f $HCIATTACH ] && [ -f $UART_CONF ] || return
	grep -v '^#' $UART_CONF | while read i; do
        	if [ "$VERBOSE" != no ]; then
                        $HCIATTACH $i 
                else
                        $HCIATTACH $i >/dev/null 2>&1
                fi
	done
}

stop_uarts()
{
	killall hciattach > /dev/null 2>&1 || true
}

start_rfcomm()
{
	if [ -x $RFCOMM ] && [ -f $RFCOMM_CONF ] ; then
		# rfcomm must always succeed for now: users
		# may not yet have an rfcomm-enabled kernel
 		if [ "$VERBOSE" != no ]; then
 			 log_success_msg "Starting $RFCOMM_NAME..."
 			$RFCOMM -f $RFCOMM_CONF bind all || true
 		else
 			$RFCOMM -f $RFCOMM_CONF bind all >/dev/null 2>&1 || true
 		fi
	fi
}

stop_rfcomm()
{
	if [ -x $RFCOMM ] ; then
 		if [ "$VERBOSE" != no ]; then
 			log_success_msg "Stopping $RFCOMM_NAME..."
 			$RFCOMM unbind all || true
 		else
 			$RFCOMM unbind all >/dev/null 2>&1 || true
 		fi		
	fi
}

restart_rfcomm()
{
	if [ -x $RFCOMM ] && [ -f $RFCOMM_CONF ] ; then
 		if [ "$VERBOSE" != no ]; then
 			log_success_msg  "Restarting $RFCOMM_NAME..."
 			$RFCOMM unbind all || true
 			$RFCOMM -f $RFCOMM_CONF bind all || true
 		else
 			$RFCOMM unbind all >/dev/null 2>&1|| true
 			$RFCOMM -f $RFCOMM_CONF bind all >/dev/null 2>&1 || true
 		fi
	fi
}

case "$1" in
  start)
        log_begin_msg "Starting $DESC..."
	start-stop-daemon --start --quiet --exec $HCID || true
	echo -n " $HCID_NAME"
	start_uarts || true
	start-stop-daemon --start --quiet --exec $SDPD || true
	echo -n " $SDPD_NAME"
	start_hid || true
	enable_hci_input || true
	start_rfcomm || true
	start_pan || true
        log_end_msg 0
	;;
  stop)
        log_begin_msg "Stopping $DESC..."
	stop_pan || true
	stop_rfcomm || true
	disable_hci_input || true
	stop_hid || true
	start-stop-daemon --stop --quiet --exec $SDPD || true
	echo -n " $SDPD_NAME"
	start-stop-daemon --stop --quiet --exec $HCID || true
	echo -n " $HCID_NAME"
	stop_uarts || true
        log_end_msg 0
	;;
  restart|force-reload)
	log_begin_msg "Restarting $DESC..."
	stop_hid || true
	stop_pan || true
	start-stop-daemon --stop --quiet --exec $SDPD || true
	start-stop-daemon --stop --quiet --exec $HCID || true
	sleep 1
	start-stop-daemon --start --quiet --exec $HCID || true
	start-stop-daemon --start --quiet --exec $SDPD || true
	start_pan || true
	start_hid || true
	restart_rfcomm
	log_end_msg 0
	;;
  *)
	N=/etc/init.d/bluez-utils
	log_success_msg "Usage: $N {start|stop|restart|force-reload}"
	exit 1
	;;
esac

exit 0

--=-0zgVabLyfdRaHSnyBU1S--



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
