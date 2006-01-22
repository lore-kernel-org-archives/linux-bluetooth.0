Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Francesco <francesco.doffizi@email.it>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset="us-ascii"
Message-Id: <200601221759.00714.francesco.doffizi@email.it>
Subject: [Bluez-users] RE: Trust 5300M BT Mouse
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
Date: Sun, 22 Jan 2006 17:59:00 +0000

Some updates. I did some modify to hcid.conf and I managed to use the mouse:

removing "master" from lm parameter made the mouse work and not to disconnect 
and reconnect every few seconds.

removig rswitch from lp parameter made mouse work smoothly (with rswitch it 
goes in a choppy way).

Now I'd like to know if I have a chance to make it work together with my gprs 
phone connection. If I run the connection, phon connects and mouse gets 
disconnected (and reconnect and disconnect and so on...).

As if the bluetooth device can't switch between mouse and gprs quickly as it 
should. Can't believe that it's not possible to have two, or more, connections 
to different bt devices. (With my pocket pc I can be online with same phone 
and receive bt gps signal without problems).

Is there some works to do on bluez stacks or something with my Silicon Wave 
chipset?

my hciconfig -a output now is:

hci0:   Type: USB
        BD Address: 00:03:7A:07:6F:12 ACL MTU: 60:20 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:28732 acl:2003 sco:0 events:77 errors:0
        TX bytes:468 acl:7 sco:0 commands:18 errors:0
        Features: 0xff 0x02 0x04 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'ITOSHY'
        Class: 0x100100
        Service Classes:
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver: 0x514
        Manufacturer: Silicon Wave (11)


-- 
Francesco
 

 

 --

 Email.it, the professional e-mail, gratis per te: http://www.email.it/f

 

 Sponsor:

 Grande concorso: gioca e vinci con Suzi Wan, puoi vincere premi fino al 17 febbario 2006!

 Clicca qui: http://adv.email.it/cgi-bin/foclick.cgi?mid=4629&d=22-1


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
