Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <444A7675.7020505@mail.utexas.edu>
From: Philip Langdale <philipl@mail.utexas.edu>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Experiences with mx-5000 bluetooth mouse+keyboard combo
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
Date: Sat, 22 Apr 2006 11:31:17 -0700

Hi all,

I decided to get myself an mx-5000 set this week and I've been fiddling
with it and while I've got it working well, I'm not quite there yet. I
do want to report my initial findings however.

0) Everything works fine in HID mode. All the buttons on the mouse
   and keyboard work correctly at the input level as reported by evtest.

1) The patch to hid2hci.c that Trevor Joynson provided and which was
incorporated is not correct - and this is consistent with the reported
experience of other people with the di novo laser desktop combo.

- the 0x0b02 device is the usb hub itself and it is not the right thing
  to attempt to switch to hci mode. Rather, you try to switch the HID
  devices themselves. In the case of the mx-5000, the hid devices are
  0xc70a (the mouse) and 0xc70e (the keyboard). I belive that the
  di novo devices are 0xc70b and 0xc70c.

- Once switched, the hci device appears as 0xc709 - the same as in the
  di novo receiver.

2) I did not need Trevor's hci_usb patch, which Marcel did not see a
   need for either.

3) I had to apply 2.6.15-mh1 to my 2.6.16 kernel (with the already
   applied parts stripped out) to get HID report mode support.

4) In HID report mode, the HWHEEL is mangled at some point. Instead of
   reporting a usage of 0x10036, it reports 0xC0238, causing it to be
   marked as an unknown button. I put a hack into hidp's hid.c to catch
   this case and rewrite the usage. The rest of the characteristics seem
   to be correct and the horizontal scrolling works correctly.

5) The keyboard is in a similar situation but I have not mapped out the
   broken usages yet, and even some of the multimedia keys that do work
   report different codes from HID mode.

So, the main question is: Are the usages broken in the devices
themselves or are the drivers mangling them before hidp sees them?

--phil



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
