Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 21 Oct 2006 12:41:53 +0200 (CEST)
From: d@vide.bz
To: bluez-devel@lists.sourceforge.net
Message-ID: <28110456.261161427313822@vide.bz>
MIME-Version: 1.0
Subject: [Bluez-devel] Error: btsco open (1-0): No such device or address
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I am running bluetooth and I like to connect a headset with skype.
I triing this steps (on slax)

----------------------------------------

# Talky
HEADSET="00:08:1B:01:CE:DD"


#
#  Using SCO
#
mo2dir snd_bt_sco_module.mo /
mo2dir btsco-0.42-i386-1.mo /
mo2dir kbtsco-1.4.4-noarch-1sl.mo /
#
#  Load kernel module anche the message for error
#
ldconfig
depmod -ae
modprobe sco
modprobe snd_bt_sco
tail -20 /var/log/messages

esdctl stop
hciconfig hci0 voice 0x0060 
#
#  Put headset in pairing mode??
#  Hit enter
echo "Put headset in pairing mode then hit return"
read X

/usr/local/bin/btsco -v "$HEADSET"

----------------------------------------

the ouput of log/message is:

----------------------------------------
Oct 21 10:41:47 (none) hcid[9965]: Bluetooth HCI daemon
Oct 21 10:41:47 (none) kernel: Bluetooth: L2CAP ver 2.8
Oct 21 10:41:47 (none) kernel: Bluetooth: L2CAP socket layer initialized
Oct 21 10:41:47 (none) sdpd[9967]: Bluetooth SDP daemon
Oct 21 10:41:48 (none) hcid[9965]: HCI dev 0 up
Oct 21 10:41:48 (none) hcid[9965]: Starting security manager 0
Oct 21 10:41:48 (none) kernel: Bluetooth: RFCOMM socket layer initialized
Oct 21 10:41:48 (none) kernel: Bluetooth: RFCOMM TTY layer initialized
Oct 21 10:41:48 (none) kernel: Bluetooth: RFCOMM ver 1.7
Oct 21 10:42:38 (none) kernel: Bluetooth: SCO (Voice Link) ver 0.5
Oct 21 10:42:38 (none) kernel: Bluetooth: SCO socket layer initialized
Oct 21 10:42:38 (none) kernel: snd-bt-sco revision 1.12 $
Oct 21 10:42:38 (none) kernel: snd-bt-sco: snd-bt-scod thread starting 
----------------------------------------

but at the time of btsco:
----------------------------------------
btsco v0.42
Device is 1:0
Error: btsco open (1-0): No such device or address
----------------------------------------

hcidump does not show activity running btsco. The
same message come without parameter, with wrong parameter ...

I can paaring the headset with hcitool cc MAC and it is
show in /proc/asound/cards

Thanks in advance for any help!


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
