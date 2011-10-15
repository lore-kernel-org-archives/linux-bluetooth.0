Return-Path: <cyrus@holtmann.org>
Date: Sat, 15 Oct 2011 07:17:38 -0400
From: "Martin G. Miller" <mgmiller@optonline.net>
Subject: Logitech bluetooth Dinovo keyboard problem
To: linux-bluetooth@vger.kernel.org
Message-id: <1318677458.18157.37.camel@tux>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear sirs;

I am writing at the request of the Ubuntu bug team for a recurrent
problem with this device.

Martin Pitt at Ubuntu.com suggested:

Can someone who is affected by this please mail this problem to
linux-bluetooth kernel at vger kernel org with the proposed rule change?
We have patched
this at least four times, and evertime we do it, some other device
stopped working. Instead of keeping to fiddle with this at the distro
level, it would be a lot better if this could be fixed/applied upstream,
and affected people could then try out potential other solutions
suggested by the bluez developers.

Here is the problem and my current work around:

First as entered  at a continuation of an older launchpad.net bug #
123920   

Total regression with this issue in 11.10 32 bit

I had this dinovo edge bluetooth keyboard/trackpad working perfectly in
11.04.  Since the upgrade to 11.10 "Oneiric"  I am back to not being
able to use it.  It refuses to pair and the old entry (changing hiddraw
to hidraw)  in lib/udev/rules.d/70-hid2hic.rules  is gone.  If I put it
in it still does not work.   The bluetooth pairing apple just goes
around in circles, asking to enter a code number that appears on screen,
followed by a failed to pair.  If you just try to use the keyboard
without running the bluetooth applet, it pops up a dialog asking to
grant permission, but checking the box and telling it grant does not
work.   Also, my Apple magic track pad, which worked perfectly in 11.04
also fails to pair in 11.10.  It now asks for a key which does not
exist.  In 11.04 it just asked to pair and then worked.

Finally, I created a new bug report because the problem had been sorted
with the older code and has reappeared in the latest code.
see launchpad.net bug # 872940 
Public bug reported:

Ubuntu 11.10 32 bit upgraded from 11.04 on 12 Oct. 2011

What is expected to happen:  The Logitech dinovo bluetooth
keyboard/trackpad should continue to work as before.
What happened instead:  The keyboard now fails to connect and cannot be
paired with the bluetooth dialog.

The problem is in the udev rules.  In 11.04 there was a special line
in /lib/udev/rules.d/70-hid2hci.rules for Logitech devices that started
with KERNEL=="hidraw*".  
This is now missing in 11.10
I edited /lib/udev/rules.d/62-bluez-hid2hic.rules and changed the hiddev
to hidraw, saved the file and rebooted.
The keyboard and trackpad now work as expected.

The file as it exists now is less complex then the one in 11.04 as there
were several items listed in the Logitech section.  I suspect that the
11.04 version allowed other logitech devices to work in hiddev mode.
Someone more knowledgeable then me needs to compare the 2 versions of
the file to ensure total compatibility.

The Logitech section from 11.04 looks like this:
# Logitech devices
KERNEL=="hiddev*", ATTRS{idVendor}=="046d",
ATTRS{idProduct}=="c70[35e]", \
  RUN+="hid2hci --method=logitech-hid --devpath=%p"
KERNEL=="hidraw*", ATTRS{idVendor}=="046d",
ATTRS{idProduct}=="c70[4abc]|c71[34bc]", \
  RUN+="hid2hci --method=logitech-hid --devpath=%p"

The Logitech section from 11.10 looks like this before modification:
# Logitech devices
KERNEL=="hiddev*", ATTRS{idVendor}=="046d",
ATTRS{idProduct}=="c70[345abce]|c71[34bc]", \
  RUN+="hid2hci --method=logitech-hid --devpath=%p"

This is what I changed it to:
# Logitech devices
KERNEL=="hidraw*", ATTRS{idVendor}=="046d",
ATTRS{idProduct}=="c70[345abce]|c71[34bc]", \
  RUN+="hid2hci --method=logitech-hid --devpath=%p"


-- 
        
"Don't fear the penguin"
    Dr. Martin G. Miller
mgmiller@optonline.net

