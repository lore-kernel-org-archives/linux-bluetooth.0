Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <EFCD68F7BFDB06468769D4D9EAAA93870793AF06@scsmsx401.amr.corp.intel.com>
From: "Pering, Trevor" <trevor.pering@intel.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] hcid dbus config
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
Date: Fri, 10 Jun 2005 12:02:26 -0700

Hello -- in my hcid.conf file, I have it set up to use the pin_helper
function...

        # PIN helper
        pin_helper /bin/bluepin;
        #dbus_pin_helper;

But when I run hcid it complains about the dbus not being found...

root@smacky:~# hcid -n -f /etc/bluetooth/hcid.conf=20
hcid[10466]: HCI daemon ver 2.3 started
Failed to open connection to system message bus: Failed to connect to
socket /var/run/dbus/system_bus_socket: Connection refused
hcid[10466]: Starting security manager 0
hcid[10466]: Exit.

Also -- I'm having problems with paring devices!  Any idea what's going
on?  Why would it complain about dbus if it's configured to use
pin_helper?

Cheers,
	Trevor


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
