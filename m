Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40F03526.3000900@thomae-privat.de>
From: Matthias Thomae <bluez@thomae-privat.de>
MIME-Version: 1.0
To: Edd Dumbill <edd@usefulinc.com>
Cc: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] starting order in debian init script for bluez
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 10 Jul 2004 20:27:50 +0200

Hi Edd, all,

I noticed that in /etc/init.d/bluez-utils from bluez-utils 2.7-4, the 
hcd2hci command is executed after starting all other bluez stuff:

case "$1" in
   start)
         echo -n "Starting $DESC:"
         start-stop-daemon --start --quiet --exec $HCID || true
         echo -n " $HCID_NAME"
         start_uarts || true
         start_rfcomm || true
         start-stop-daemon --start --quiet --exec $SDPD || true
         echo -n " $SDPD_NAME"
         start_pan || true
         start_hid || true
         echo "."
         enable_hci_input || true
         ;;

Wouldn't it be better to start it before rfcomm/sdpd/pand/hidd, to allow 
these services to use the dongle immediately?

I had a problem connection a Logitech-Hub-dongled PC to a NAP, and 
changing the order (and adding 'sleep 2' before start_pan, but that's a 
different story I guess) helped here.

Regards.
Matthias


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
