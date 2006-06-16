Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4492B0C9.6010305@marples.net>
Date: Fri, 16 Jun 2006 09:23:21 -0400
From: Dave Marples <dave-lists@marples.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] rfcomm device blocking/data available behaviour
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Folks,

I've got a problem using rfcomm to a generic BT device (actually a SE 
K750i phone, but that's just what I'm using for an example).  It looks 
to me like a bug in the rfcomm/socket interface, but what do I know?

The problem seems to be that blocking/select on a rfcomm serial port 
isn't working correctly. This is using Ubuntu Dapper (latest release) 
and I've checked the bluetooth/rfcomm directory against patch 2.6.16-mh3 
to ensure that all of the current changes are in there, and they are (in 
fact, only core.c has changed, and that's mostly beautification).

The easiest way to create the problem is as follows;

1) In /etc/bluetooth/rfcomm.conf establish a connection to the phone;

rfcomm3 {
   bind yes;
   # Bluetooth address of the device
   device xx:xx:xx:xx:xx:xx;
   # RFCOMM channel for the connection
   channel    1;
   # Description of the connection
   comment "K750i";
}

2) ...then cat /dev/rfcomm3

Obviously, at this point nothing happens.
3) _RING_ the phone

The output from the 'cat' job goes crazy, and never finishes.

Another way to create the problem  is the following (using python);

fd=open("/dev/rfcomm3","r+")
fd.write("ATZ\n")
while 1:
   c=fd.read(1)
   print "Got",len(c),"Detail:",ord(c),c

Can anyone help?  I'm stuck here....it's quite possible I'm doing 
something _really_ silly, but I need someone to hold a mirror up to be 
able to see that...

Regards

DAVE



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
