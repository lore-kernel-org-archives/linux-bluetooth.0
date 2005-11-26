Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Mario Demontis <mario.demontis@email.it>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1133028275.9123.29.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] Bluetooth connection too slow
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
Date: Sat, 26 Nov 2005 19:04:35 +0100

Hello
I recently bought a Bluetooth 2.0 EDR USB adapter (Trust, BT-2200Tp),
because I wanted to try it out with my new Motorola E1070 (UMTS phone).

I tried it out with my Ubuntu linux. The device has been recognized
properly. Then I tried the Internet connection (with UMTS you can have
more than 30 kBytes/s). Unfortunately all I could see was a transfer
rate (taken with wget downloading the kernel sources from a fast mirror)
of about 9 kB/s. I also tried to do the same with Windows XP and there
the transfer rate reached about 32 kB/s!! I did the same several times
and all the times I had the same results.
Furthermore, I tried to do the same under Linux with a USB connection,
and I'm getting 32kB/s as well. This brought me to think the bottleneck
is in the BT connection.

This is how I'm setting the BT connection:
$ sudo hcitool cc --role=m 00:0E:A1:45:1F:AE
$ sudo hcitool auth 00:0E:A1:45:1F:AE
$ sudo rfcomm bind 00:0E:A1:45:1F:AE
$ sudo ln -sf /dev/rfcomm0 /dev/modem

To dial I'm using exactly the same procedure as when using the USB
connection (with kppp).

I'm wondering if I need to tweak some parameter of the bluetooth
connection. hciconfig gives me many info but I don't know how to
interpret them and what options to give (where can I find
documentation?).
Here is what I'm getting with hciconfig:
$ hciconfig hci0 -a
hci0:   Type: USB
        BD Address: 00:0E:A1:45:1F:AE ACL MTU: 1017:8  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:466 acl:0 sco:0 events:27 errors:0
        TX bytes:378 acl:0 sco:0 commands:21 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'agnello-0'
        Class: 0x100100
        Service Classes: Object Transfer
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2902 LMP Ver: 2.0 (0x3) LMP
Subver: 0x4127
        Manufacturer: Broadcom Corporation (15)

Does anyone have some suggestion in order to help me to configure
properly my BT dongle?

Thanks
Mario



 

 

 --

 Email.it, the professional e-mail, gratis per te: http://www.email.it/f

 

 Sponsor:

 Per la casa dei tuoi sogni, la soluzione è un Credito Casa Findomestic, facile e senza anticipi!

 Clicca qui: http://adv.email.it/cgi-bin/foclick.cgi?mid=3939&d=26-11


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
