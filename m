Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: ALBERT RIBAS GUASCH <albert.ribas@estudiants.urv.es>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Message-id: <8934986c29.86c2989349@estudiants.urv.es>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: [Bluez-users] rfcomm connection refused / Host is down
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
Date: Tue, 30 Mar 2004 17:02:25 +0200

Hi!

I'm using the BlueZ stack in kernel 2.4.24, and I've
got an usb dongle and I try to connect to an
RS232-bluetooth attached to a robot's serial port.

So, I do hciconfig and I get
hci0:
Type: USB
	BD Address: 00:0A:3A:50:20:15 ACL MTU: 192:8  SCO
MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:8280 acl:233 sco:0 events:233 errors:0
	TX bytes:3096 acl:93 sco:0 commands:45 errors:0


When I do an hcitool -i hci0 inq, I can find the
RS232 adapter, but on doing
rfcomm -i hci0 connect /dev/rfcomm0 00:c0:1B:05:C8:2A 1

I get a message with:
 Can't connect RFCOMM socket: Connection refused
or either:
Can't connect RFCOMM socket: Host is down

Can anybody help me??

Thank you!!!

Albert



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
