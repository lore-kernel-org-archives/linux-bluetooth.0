Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Rainer Dorsch <rdorsch@web.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200501031150.38882.rdorsch@web.de>
Subject: [Bluez-users] hotplug script needs to sleep before calling pand
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
Date: Mon, 3 Jan 2005 11:50:38 +0100

Hello,

my /etc/hotplug.d/usb/epox-bluetooth.hotplug script needs to sleep before it 
can start pand, otherwith pand won't call /etc/bluetooth/pan/dev-up (and it 
will also not bring up the device directly as discussed in a separate 
posting).

The script looks like this:


#!/bin/sh
pidfile=/var/run/pand.pid
DAEMON=/usr/bin/pand

CHARS=`echo $DEVPATH| wc -c`
VERSION=`echo $DEVPATH|cut -c $((CHARS-3))-$CHARS`

(date
echo $DEVPATH
echo $PRODUCT
echo $TYPE
echo $ACTION
echo $CHARS
echo $VERSION) >> /tmp/epox.log


case `echo $PRODUCT|cut -d / -f 1-2` in
        # a12/1/525 and a12/1/828 have been seen for the Epox BT DB02A
        a12/1) break ;;
        *) exit ;;
esac
case $TYPE in
        224/1/1) break ;;
        *) exit ;;
esac
case $ACTION in
        add)
            if [ ! -z VERSION ]; then
              if [ $VERSION = 1.0 ]; then
                sleep 1
                start-stop-daemon --start --exec $DAEMON -- --nodetach --role 
PANU --search --encrypt --pidfile $pidfile
              fi
            fi
            ;;
        remove)
            start-stop-daemon --stop --exec $DAEMON --pidfile $pidfile
            ifdown bnep0
            ;;
esac


Any ideas why sleep is needed (and 0.5 seconds are not enough) are welcome.

Thanks,
Rainer



-- 
Rainer Dorsch
Alzentalstr. 28
D-71083 Herrenberg
07032-919495
Icq: 32550367


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
