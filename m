Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <HV4JYI$A76840F1DFBE95344225AA2AE2138988@laposte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "Antoine Maisonneuve" <antoine02@laposte.net>
To: "bluez-users" <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Ipaq problem with kernel 2.4.19-rmk6-pxa1-hh36
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
Date: Thu, 25 Mar 2004 10:06:18 +0100

Hi all,
I install the last revision 0.72 of familiar on my Ipaq 3970,=0D
=
with no problem (kernel 2.4.19-rmk6-pxa1-hh30). And Bluetooth
works well=
, but I would like activate some networking options.
So I get the last k=
ernel on familiar CVS server
2.4.19-rmk6-pxa1-hh36 I use the file
arch/=
arm/def-configs/ipaqpxa to configure my kernel and add
networking option=
s.
But when use my new kernel Bluetooth don't works anymore,(the
rest o=
f the system works well) I look at Bluetooth part in
kernel options, all=
 seem right.... (Bluetooth subsystem
support and HCI UART driver correct=
ly checked as modules).
I also try to create a kernel with the ipaqpxa c=
onfiguration
(without adding or remove any options) and it's the same pr=
oblem.

When I use lsmod, hci_uart seems unused, if someone could help=0D
=
me ?
Does an Ipaq needs any special options to activate Bluetooth
in th=
e kernel ?

Thanks for your help

Antoine Maisonneuve

lsmod report=
 :

hci_uart               11860   0 (unused)
pxa-i2s                 =
1136   0
i2c-core               13752   0
pxa-audio               9136 =
  0
ds                      7476   2
h3600_generic_sleeve    6504   0 (=
unused)
pxa_cs                 12584   2 [h3600_generic_sleeve]
pcmcia_=
core            35416   0 [ds pxa_cs]
usbcore                57256   0 (=
unused)
usb-eth                 5988   0 (unused)
pxausb_core          =
   8904   0 [usb-eth]
sa1100-rtc              5688   1
ipaq-sleeve     =
        7876   0 [h3600_generic_sleeve pxa_cs]
ircomm-tty             35=
128   0 (unused)
ircomm                 15964   0 [ircomm-tty]
irda    =
              162632   0 [ircomm-tty ircomm]
h3600_ts                978=
8   1
apm                     4412   1
bnep                    9288   0=
 (unused)
l2cap                  17276   0 [bnep]
bluez                =
  32088   1 [hci_uart bnep l2cap] 
=0A=0AAcc=E9dez au courrier =E9lectro=
nique de La Poste : www.laposte.net ; =0A3615 LAPOSTENET (0,34=80/mn) ; t=
=E9l : 08 92 68 13 50 (0,34=80/mn)=0A=0A



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
