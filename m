Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41FF7E71.3080206@clarinet.u-strasbg.fr>
From: Nicolas Montavont <montavont@clarinet.u-strasbg.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] btsco doesn't start
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 01 Feb 2005 14:04:49 +0100

Dear Developers,

I just bought an Plantronics M2500 headset and I have problems to make 
it work in my linux box. I hope you can help me.

The problem is I can not start btsco. Here is the output when I try to 
start btsco :

Device is 2:0
Error: btsco open (2-0): No such device or address

Here are the details of my settings:

I have a bluetooth PCMCIA 3com card, version 3 (driver serial_cs and 
hci_uart), and a linux-2.6.9 kernel (with bluetooth support from this 
kernel), btsco from CVS (revision 1.4 when I load the module). Alsa 
driver (1.0.8) were compiled outised the kernel.

I also try with the linux-2.6.10 kernel with patch-2.6.10-mh3.gz from 
bluez, and I get the same.

Once I did hciconfig hci0 up and hciattach ttySx 3com, I can see my 
headseat :
hcitool scan gives me :

00:03:89:79:84:48       M2500 by Plantronics
(to have this result, I have to put the headset in connection mode.)

but hcitool info 00:03:89:79:84:48 gives me :

Requesting information ...
Can't create connection: Connection timed out

I have same outputs if I try sdptool (sdptool browse or cc...)

In the Readme file it is written
3. run the daemon (enter the passkey if it's the first time 'round)
         btsco bdaddress

How can I set the passkey ? I know I have a code (0000), when do I have 
to set up this code ?

Here are other details, as you suggest in readme file :

hciconfig -a :

hci0:   Type: UART
         BD Address: 00:0A:5E:00:E1:12 ACL MTU: 192:8 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:1605 acl:0 sco:0 events:63 errors:0
         TX bytes:296 acl:0 sco:0 commands:29 errors:0
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy:
         Link mode: SLAVE ACCEPT
         Name: 'NICONET'
         Class: 0x000000
         Service Classes: Unspecified
         Device Class: Miscellaneous,
         HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP 
Subver: 0x1bb
         Manufacturer: Cambridge Silicon Radio (10)

hciconfig hci0 revision

hci0:   Type: UART
         BD Address: 00:0A:5E:00:E1:12 ACL MTU: 192:8 SCO MTU: 64:8
         HCI 15.3
         Chip version: BlueCore02-External
         Max key size: 56 bit
         SCO mapping:  HCI

Any help would be really appreciated. Thanks a lot...

Nicolas



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
