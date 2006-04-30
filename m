Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <330d2d2b0604300412x7f8faf9uca23728b708ddd7d@mail.gmail.com>
From: "Philipp Glaser" <johndoe.ois@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] bluetooth keyboard connects, but does not work
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
Date: Sun, 30 Apr 2006 13:12:19 +0200

i am using ubuntu breezy, with ms intelli mouse explorer and the
according bt usb dongle.
i would like to use an HP iPAQ Bluetooth Foldable Keyboard (because it
is so handy) and ran into the following problem:

i can connect to the keyboard and request the link quality, info, or
whatever. what i cannot is to type something using my keyboard.

i was also using sdptool search HID, and got no output, but when using
sdptool search SP i got:

Searching for SP on <bt-addr> ...
Service Name: SPP slave
Service RecHandle: 0x10000
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100

also when using kbluetoothd i just see, that my keyboard comes up with SPP.

i would like to know now, what i could do, to use keyboard as a
secondary keyboard for my computer.

thanks for your suggestions

philipp


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
