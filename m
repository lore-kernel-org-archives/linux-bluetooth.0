Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: David Feldman <wb0gaz@hotmail.com>
To: bluez-users@lists.sourceforge.net
Cc: wb0gaz@hotmail.com
Message-Id: <20040620122909.568AD270.wb0gaz@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: [Bluez-users] Getting started - got to l2ping, need help
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
Date: Sun, 20 Jun 2004 12:29:09 -0600

I am configuring a RH9 laptop to use bluetooth and am part way 
through the configuration process, but need help to proceed (I cannot 
get a serial connection to try out "AT" command, but some 
intermediate steps appear working.)

Configuration:

System is RH9 with 2.4.20-31.9 kernel and bluez RPMs installed.
Card is HP version of 3COM card, part number 3CRWB6096-HP
Firmware .bin file for the card taken from a working W2K installation 
has been installed.

Much searching of FAQ/howto was done.
A few edits have been done based on this searching:

/etc/modules.conf added these alias: net-pf-31 bluez, bt-proto-0 l2cap,
 bt-proto-2 sco, bt-proto-3 rfcomm

/etc/bluetooth/hcid.conf was modified just to change the entry pin_
helper to point to a shell script (the original reference to a file 
in /bin was going nowhere), and a /etc/bluetooth/bluepin was created 
that echoes back PIN:00.

Given this, here is my procedure from cold start:

1. Card installed, "cardctl insert" command issued.
2. /var/log/messages reports card detected, firmware loaded, and 
bluetooth start hci0 executed
    At this point it also reports /sbin/hotplug no runnable bluetooth.
agent installed.
3. Issue hciconfig hci0 up, then executing hciconfig hci0 shows "UP 
RUNNING PSCAN ISCAN" and some bytes received and transmitted
4. Set phone to discoverable (necessary so that hcitool scan and 
l2ping will work)
5. Issue hcitool scan, and the MAC address of the phone and it's name 
are shown
6. Issue l2ping and the MAC address, and replies are received (0 
bytes from... time xx mS)
7. When l2ping executed, the message "BlueZ L2CAP ver 2.1" was 
written to /var/log/messages

Now at this point I am getting lost. My wish is to have the phone 
usable for dial-out, and it appears the next command to use is "rfcomm
". I've set up the command

rfcomm bind 0 (mac address) 0

when executes without error, and another message in /var/log/messages 
appears, referring to "BlueZ RFCOMM ver 1.0"

Now at this point I can issue another command, just rfcomm, and it 
prints

rfcomm0: (mac address) channel 0 clean

My wish is to get to the point where I can use minicom to issue "AT" 
commands, and I've tried configuring minicom to communicate via /dev/
ttyUB0, but nothing happens (no echo, no sign of activity in the phone.)

This is where I would be grateful for help!

Dave
wb0gaz@hotmail.com
(wb0gaz - at - hotmail - dot - com)



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
