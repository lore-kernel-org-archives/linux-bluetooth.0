Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?iso-8859-1?Q?Riikka_Jylh=E4?= <jylhar@ac.tut.fi>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <000701c36193$7dd9fa30$ba2ae682@ac.tut.fi>
MIME-Version: 1.0
Subject: [Bluez-users] Instructions to get audio working
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 13 Aug 2003 15:07:39 +0300
Content-Type: text/plain; CHARSET=iso-8859-1

Hi all,

I got a question how did I make audio working with Bluez. Here=92s
detailed instructions how I got headset working with Linux-PC. This is a
feature developed all the time so this probably applies only at current
(August 2003) situation. Hope there aren=92t many typos or other false
information.
-Riikka

1) Check that your device supports SCO-link and it is listed to be
supported hardware.

-Some older devices don=92t have support for SCO. If device is attached to
your Linux-PC with Bluez installed this can be checked with =93hciconfig
hci0 features=94. If the device is attached to another computer =93hcitool
info <bdaddr>=94 will show features. If there is at least =93<SCO link>
<CVSD>=94 on the output device should support SCO.

-There is a listing of supported hardware at Bluez-site=20
(http://bluez.sourceforge.net -> Hardware support).

-UART-devices are too slow for audio-link. PCMCIA-cards with working
audio at this time (August 2003) are Xircom and 3Com.

-CSR-chip based USB-devices should work but some changes need to be done
in Linux kernel code. Some USB-chipsets are not produced according to
Bluetooth spec so they need a patch for Linux kernel. Actual changes
that need to be done with USB-devices to work are discussed next.

2) If USB-device is used there are some things in Linux kernel that need
to be checked and changed.

-Kernel version has to be at least 2.4.21 (uname =96a will tell kernel
version) and there needs to be support for Bluetooth audio in
USB-driver. To check this Linux kernel code has to be installed in
/usr/src/linux. Give command =93cat /usr/src/linux/.config | grep BLUEZ=94
and check if CONFIG_BLUEZ_USB_SCO is listed on the output. If it is
that=92s good so far. If  USB_SCO is not configured you need to install
new kernel.

-If kernel version is 2.4.21 at least mh2-patch from
http://bluez.sourceforge.net -> =93Kernel Patches=94 has to be applied.
Anything that has something to do with SCO is good to apply.
2.4.21-mh2-patch is needed when USB device happens to be the one that
isn=92t build according to Bluetooth spec (it doesn=92t=92 have ISOC
endpoints).

-USB-SCO support is in development. Until it=92s ready kernel code needs
to be
changed a bit to make SCO working. A patch from Jonathan Paisley makes
it
working. I=92ve changed it to work with default voice setting 0x0060.
Apply this:
=09
beginning of patch
******************************************************************
diff -ur --exclude=3D'.*' drivers/bluetooth.orig/hci_usb.c
drivers/bluetooth/hci_usb.c
 --- drivers/bluetooth.orig/hci_usb.c2003-07-20 15:25:49.000000000 +0100
 +++ drivers/bluetooth/hci_usb.c2003-07-20 15:19:20.000000000 +0100
 @@ -302,6 +302,7 @@
=20
  #ifdef CONFIG_BLUEZ_USB_SCO
  if (husb->isoc_iface)
 +    for (i =3D 0; i < HCI_MAX_ISOC_RX; i++)
  hci_usb_isoc_rx_submit(husb);
  #endif
  } else {
 @@ -522,7 +523,7 @@
  #ifdef CONFIG_BLUEZ_USB_SCO
  /* Process SCO queue */
  q =3D __transmit_q(husb, HCI_SCODATA_PKT);
 -if (!atomic_read(__pending_tx(husb, HCI_SCODATA_PKT)) &&
 +if (atomic_read(__pending_tx(husb, HCI_SCODATA_PKT)) < HCI_MAX_ISOC_TX
&&
  (skb =3D skb_dequeue(q))) {
  if (hci_usb_send_isoc(husb, skb) < 0)
  skb_queue_head(q, skb);
 @@ -830,7 +831,7 @@
=20
  #ifdef CONFIG_BLUEZ_USB_SCO
  case USB_ENDPOINT_XFER_ISOC:
 -if (ep->wMaxPacketSize < size)
 +if (ep->wMaxPacketSize !=3D 17)
  break;
  size =3D ep->wMaxPacketSize;
=20
 Only in drivers/bluetooth: hci_usb.c.orig
 diff -ur --exclude=3D'.*' drivers/bluetooth.orig/hci_usb.h
drivers/bluetooth/hci_usb.h
 --- drivers/bluetooth.orig/hci_usb.h2003-07-20 15:25:49.000000000 +0100
 +++ drivers/bluetooth/hci_usb.h2003-07-20 14:20:43.000000000 +0100
 @@ -41,6 +41,9 @@
  #define HCI_MAX_BULK_TX     4
  #define HCI_MAX_BULK_RX     1
=20
 +#define HCI_MAX_ISOC_RX     2
 +#define HCI_MAX_ISOC_TX     2
 +
  #define HCI_MAX_ISOC_FRAMES     10
=20
  struct _urb_queue {

***********************************************************
End of patch.

-This is what I did when I had  CSR-based USB-dongle and needed to
install new kernel with these two patches. I used instructions for
kernel compilation from http://www.linuxheadquarters.com -> =93Guides and
Tutorials=94 -> =93Tuning and Performance=94.
	1) Get kernel source 2.4.21 from http://kernel.org.
	2) put tar-file to /usr/src
	3) cd /usr/src
	4) if there is an old kernel source remove the symbolic link to
it with =93rm linux=94. If linux is not a symbolic folder rename it.
	5) untar the new source with =93tar xzvf linux-2.4.21.tar=94
	6) make symbolic link from linux to your new source with =93ln =96s
linux-2.4.21 linux=94
	7) get patch-2.4.21-mh2 from bluez-site and put tar-file in
/usr/src/linux
	8) cd /usr/src/linux
	9) Untar the patch with =93tar xzvf patch-2.4.21-mh2.tar=94
	10) Apply it with =93patch =96p1 < patch-2.4.21-mh2=94
	11) Apply the patch from Jonathan Paisley above. I couldn=92t make
this work so I
	changed the files /usr/src/linux/drivers/Bluetooth/hci_usb.c and
=85/hci_usb.h myself according to the patch. This means take off 	those
lines with =93-=93 at the beginning and write =93+=94 lines.There 	are just
a couple of changes.
	12) Configure your kernel with =93make xconfig=94. A configure
window 	will pop up. If you have an old kernel configure file load it
in.  	There is a button for that. Old configurations are found at your
old kernel source file /usr/src/linux.old.version.number/.config.
If no such is available I recommend to ask help from a Linux 	expert.
After loading go to Bluetooth-section and mark everything 	=93m=94 for
module or if it is not possible mark =93y=94 for yes. Make 	sure there is
support for USB_SCO. Save configure and exit.
	13) make dep
	14) make clean
	15) make bzImage (takes a while)
	16) make modules (takes a while)
	17) make modules_install
	18) make install
	19) Check /etc/lilo.conf-file. Command =93make install=94 should
make 	it right but it sometimes failes. The default image should be
the 	new 2.4.21 version. Check it from folder /boot. There are files
with vmlinuz in their names. You should give command =93ls =96l 	/boot=94
to see any symbolic links.
	20) /sbin/lilo
	21) reboot

3) Install Bluez-packaces.

-I used the latest versions from Bluez site. RPM:s are fine but compile
bluez-utils from source. Command =93urpmi file.rpm=94 installs RPM:s. They
can be uninstalled with command urpme. If you install everything from
sources you need to have libglib1.2-devel and flex installed. Packages
are installed with commands =93./configure=94, =93make=94 and =93make insta=
ll=94,
after untar ofcourse.

-Make changes to Bluez-utils package. Replace files hciconfig.c and
Makefile.am from folder Bluez-utils/tools with ones found at Bluez site
-> CVS tree -> tools. Take also files csr.c and csr.h. Remove
Makefile.in. In folder =85/bluez-utils/ give command =93automake
tools/Makefile=94

-Remove or comment lines 224-230 from file bluez-utils/test/hstest.c.
This is the part where voice setting is tested. We want it to be 0x0060
instead of 0x0040. Hstest is being developed so this change will
hopefully be useless in the future.

-Install the modified bluez-utils package.

-Check file /etc/modules.conf. Lines below should be there. If you had
to add them run =93depmod =96a=94.
alias net-pf-31 bluez
alias bt-proto-0 l2cap
alias bt-proto-2 sco
alias bt-proto-3 rfcomm
alias bt-proto-4 bnep
alias tty-ldisc-15 hci_uart

4) Plug device and make last check.

-When device is up run =93hciconfig hci0 revision=94. If there is =93SCO
mapping: HCI=94 in output it should work.

5) Use .sw-audio-files.

-I can only listen to audio files in .sw format. Command =93sox sound.au
sound.sw=94 makes .au-file into .sw-file. Sox-command didn=92t transform
.wav or .mp3 files right but that should be possible somehow.

6) Make sure voice setting is 0x0060 and play or record.

-Voice setting is checked with command =93hciconfig hci0 voice=94

-To listen audio from headset give command =93./hstest play sound.sw
<bdaddr> <channel>=94. If you want to record for example your speech from
headset give command =93./hstest record my_recording.sw <bdaddr>
<channel>=94 You can listen the recording with =93play my_recording.sw=94

7) Notes

-I don't know if it's device, kernel or Bluez problem but sometimes
after some succesful ./hstest commands audio suddenly stops working and
gives error message on SCO connection saying that fuction is not
implemented. Unplugging Bluetooth device or rebooting Linux usually
helps.




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
