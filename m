Return-Path: <cyrus@holtmann.org>
Subject: The Big Picture
From: Robert Siemer <Robert.Siemer@backsla.sh>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Dec 2009 17:29:17 +0800
Message-Id: <1260955757.21218.9.camel@asus-1130818068>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear list members...

Is there any place where I can find the big picture of the working of
bluetooth under linux? In this case: how does the binding work and do
HID devices get discovered and handled.


I imagine something like that (example for a bluetooth mouse):

1) the mouse, once switched on, looks for the last host to connect to 
   (standard mice store only one host and cannot find laptop _and_ 
   desktop PC by themselves...)
2) /usr/sbin/bluetoothd notices and establishes a XYZ connection, with 
   the help of key files in /var/.../.../...
3) after the establishment bluetoothd queries for the device type and 
   dispatches an event on dbus / for listeners on /dev/bluesock, ...
4) this is normally /sbin/udevd, which should make sure hidp is loaded
5) hidp in turn checks (who informs it?) for HID bluetooth devices and 
   creates /dev/input/..., this results in another event, etc, etc, but 
   the device is ready for use anyway...


Okay, this is completely invented here, but I would like to know the
truth, especially in case the device is not bound yet, e.g. something
like this:


2b) /usr/sbin/bluetoothd will not be able to completely open the
connection, because of missing keys. So it tries to do a keyexchange,
which requires the famous PIN, which bluetoothd will try to get via
dbus. You can see the request with "dbus_dump --class xxx --listen" and
you can send a corresponding answer via  "dbus_messenger --id yyy --send
--string '0000'; the yyy corresponds to the id seen in the request; and
take care that some mice require to skip the pin negotiation,
because ..., ... ... you can do that with the command ... ...

2c) In case the mouse does not connect to the host, because it never
knew it before, you can connect to the mouse with "hcitool --connect
hw_addr", this will trigger the rest as written above... ...




I think this describes best what I’m looking for: the big picture, and
the command lines, to walk through it.



Thanks,
Robert 

