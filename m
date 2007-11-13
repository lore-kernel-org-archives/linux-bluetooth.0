Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <36c9ddd40711130004t6e77df83y44ef846a3ade34d6@mail.gmail.com>
Date: Tue, 13 Nov 2007 18:04:12 +1000
From: "Nick Irvine" <nfirvine@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <36c9ddd40711122352m2bdb4e49ud9790c487ee7800b@mail.gmail.com>
MIME-Version: 1.0
References: <36c9ddd40711122352m2bdb4e49ud9790c487ee7800b@mail.gmail.com>
Subject: [Bluez-users] Unsupported bluetooth adaptor?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi all,

I've bought a cheapo bluetooth adaptor from China without a brandname.
 According to lsusb, it uses the Broadcom 2035 chipset:

Bus 002 Device 082: ID 0a5c:2035 Broadcom Corp. BCM2035 Bluetooth

As far as I can tell, it's unsupported by linux/bluez.  But I was
hoping it would work anyway.  If anybody has this particular chipset
and has got it working, I'd like to know how.

There are a couple of things that indicate to me that it's not going to work:

1) Sometimes it won't show up in lsusb.  dmesg | tail shows a few
lines like this everytime I plug it in:
[13965.928000] usb 2-1: new full speed USB device using uhci_hcd and address 91
[13966.336000] usb 2-1: device not accepting address 91, error -71
with various addresses.  There is a light on the device, but when this
happens, it doesn't turn on.  Eventually though, after a few unplugs
and replugs, the light will come
on, the GNOME bluetooth preferences applet will say it's connected
(and will give it a consistent name -- not sure if this is relevant).
At this point though...

2) dmesg shows:
[14111.892000] usb 2-1: configuration #1 chosen from 1 choice
[14114.076000] hci_cmd_task: hci0 command tx timeout
>>From other people's adventures with bluetooth, I can see that there
should be lines after that about bluetooth, but there isn't.

3) I was feeling desperate, and was looking at the kernel drivers
source for bluetooth (namely drivers/bluetooth/hci_usb.c).  I found
this in an array called "blacklist_ids:", which indicates to me that
it's blacklisted or something:
 113         /* Broadcom BCM2035 */
 114         { USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET |
HCI_WRONG_SCO_MTU },
 115         { USB_DEVICE(0x0a5c, 0x2009), .driver_info = HCI_BCM92035 },
However, in lsusb, my device shows up as 0a5c:2035, not
:200a or :2009.  I found less than ten references to this device ID on
Google, most of which were Chinese or Russian, and none of which
seemed to have a solution (based on Google translation).  I'm no
kernel hacker, but when I read something about my device being
blacklisted, I know it's not a good sign.

4) hciconfig shows a 0'd address:
hci0:   Type: USB
       BD Address: 00:00:00:00:00:00 ACL MTU: 377:10 SCO MTU: 16:0
       UP RUNNING
       RX bytes:352 acl:0 sco:0 events:14 errors:0
       TX bytes:306 acl:0 sco:0 commands:16 errors:1
Yet, it shows RX and TX bytes, as well as commands.

5) I did an hcidump -x while doing an hcitool scan in another
terminal.  It gave me this:
hcidump -x
HCI sniffer - Bluetooth packet analyzer ver 1.39
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
 03
< HCI Command: Read Local Name (0x03|0x0014) plen 0
< HCI Command: Inquiry (0x01|0x0001) plen 5
 33 8B 9E 08 00
hcitool scan yields "Inquiry failed: connection timed out".
Interesting to note, each of the above lines were for separate runs of
hcitool scan, i.e., a new one would pop up every time I did the scan.

So it doesn't look good, but any help would be appreciated.  The
device I'm trying to connect via bluetooth is a Nintendo Wii Remote,
which I've heard connects up fine and you can even transfer files from
its memory.  I have had no such luck.

Anyway, thanks in advance,
Nick Irvine

PS  I may have double-posted this by mistake.  If I did, I apologise.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
