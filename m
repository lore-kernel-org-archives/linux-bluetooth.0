Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FD3E26.1000401@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] "hcitool dev" shows no devices
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
Date: Sun, 30 Jan 2005 21:05:58 +0100

Hello everybody

I've a 2.4.26 kernel. I patched it using the "patch-2.4.26-mh2.gz" from the 
bluez homepage. *
Then, in "make menuconfig" I selected this points:
# Bluetooth support -> Bluetooth subsystem support
#                      L2CAP protocol support (NEW)
#                      RFCOMM protocol support
#                        RFCOMM TTY support (NEW)
# Bluetooth support -> Bluetooth device drivers -> HCI USB driver (new)

Then I compiled and installed the new kernel.
After that I compiled and installed the bluez-libs and bluez-utils.

Everything works well...
Now I try "hcitool dev" but no devices are showed (I have two D-Link DBT120 
connected to usb ports).

Any Ideas why they aren't recognized?
Did I miss to add a feature to the kernel?

kind regards
Marco


* Something gets rejected during the patch (It doesn't seem important to 
me, but maybee it is):

Makefile.rej:
***************
*** 1,7 ****
   VERSION = 2
   PATCHLEVEL = 4
   SUBLEVEL = 26
- EXTRAVERSION =

   KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

--- 1,7 ----
   VERSION = 2
   PATCHLEVEL = 4
   SUBLEVEL = 26
+ EXTRAVERSION = -mh2

   KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
