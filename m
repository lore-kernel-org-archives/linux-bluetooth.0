Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Fabrice =?iso-8859-1?q?M=E9nard?= <menard.fabrice@wanadoo.fr>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405041444.45061.menard.fabrice@wanadoo.fr>
Subject: [Bluez-users] Boot problem
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
Date: Tue, 4 May 2004 14:44:45 +0200

Hi all

I've succeeded to make my dinovo work in bluetooth mode.
Thanks for your great work !!

But in boot time nothing happens and I don't have any error message.
No response from the keyboard and the media pad but the mouse is ok.

Any clue ?

Here is my init script:

#!/bin/bash
# D=E9marrage du sous-syst=E8me bluetooth

# Source function library.
=2E /etc/init.d/scripts/functions

start()=20
{
        echo $"D=E9marrage de Bluetooth..."
        loadproc /sbin/hcid
	evaluate_retval

	echo "Passage du mode USB au mode Bluetooth pour le DiNovo..."
	hid2hci > /dev/null
	evaluate_retval

	echo "Lancement du d -b=E9mon de service HID..."
	bthid -d
	evaluate_retval

 	touch /var/lock/bluetooth
}

stop()=20
{
        echo "Arr=EAt du d=E9mon de service HID..."
	bthid -k
	evaluate_retval

        echo $"Arr=EAt de Bluetooth..."
	killproc hcid
	evaluate_retval

	rm -f  /var/lock/bluetooth
}

[ -f /sbin/hcid ] || exit 0

case "$1" in
  start)
	start
        ;;
  stop)
	stop
        ;;
  restart|reload)
	stop
	start
	;;
  condrestart)
	[ -e /var/lock/bluetooth ] && (stop; start)
	;;
  *)
        echo $"Utilisation: $0 {start|stop|restart|reload|condrestart}"
        exit 1
esac

exit 0

=2D-=20
=46abrice M=E9nard
menard.fabrice@wanadoo.fr

ps: if my english is very bad, please send me a note !!



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
