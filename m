Return-Path: <d_gujarathi@hotmail.com>
From: "Deepesh S Gujarathi" <d_gujarathi@hotmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
References: <LAW11-OE33GHeqXipAS00015cf1@hotmail.com> <1073314449.2508.1.camel@pegasus> <LAW11-OE14JMxg22Civ0001db81@hotmail.com> <1073394980.2508.59.camel@pegasus> <Law11-OE46C3SpmFZfs000064c7@hotmail.com> <1073481066.2508.150.camel@pegasus>
Subject: Re: blueZ-bthid testing
Date: Thu, 8 Jan 2004 16:39:14 +0530
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_03BC_01C3D605.F34769B0"
Message-ID: <Law11-OE66zpDERHZWY00000fb1@hotmail.com>
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.

------=_NextPart_000_03BC_01C3D605.F34769B0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit

Hi all,

Thanks to Marcel, finally the MS mouse is working effortlessly with the
bthid program and I am a happy man.

I had messed up two things,
- had not loaded the mousedev.o module and
- made a typo in the XF86Config-4 file.

my two cents
please find attached a howto document that details the steps involved in
making the MS IntelliExplorer mouse working with Marcel's bthid utility.

PS: maybe some one can just verify the howto document for any possible
errors.

thanks everyone for your patience.
Deepesh

Deepesh S Gujarathi
Encodex Technologies (India) Pvt. Ltd.
69 Amchi Colony, Bavdhan Khurd
Pune - 411021
91-20-2953590 , 2953591
URL: www.encodexindia.com



----- Original Message -----
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "Deepesh S Gujarathi" <d_gujarathi@hotmail.com>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Sent: Wednesday, January 07, 2004 6:41 PM
Subject: Re: blueZ-bthid testing


> Hi Deepesh,
>
> > I created the uinput node with the following command
> > # mknod /dev/input/uinput c 10 223
> > and the bthid error (bthid[2040]: can't open input device: no such file
or
> > directory (2))  is gone, but for some reason I still cant move the
cursor.
> >
> > - I checked the hcidump and it shows all the data coming from the MS
> > wireless mouse as I move the mouse and click
> >
> > - the tail -f /var/log/messages shows the following
> >     Bluetooth HID service started
> >     Connected: Microsoft Five Button Mouse
> >     Vendor HID usage 0xff00fe01 value 0x1
> >     adequate battery
> >
> > - when I do an lsmod I see
> >     Module         Used by                Not     tainted
> >     uinput            1
> >     hci_usb          1
> >     l2cap              5
> >     bluez              4 [hci_usb l2cap]
> >     input              0 (autoclean)    [uinput]
> >
> > I doubt the following, if anyone can verify it would be great
> >
> > - my XF86Config-4 file consists
> >
> > Section "InputDevice"
> >          Identifier "MSmouse"
> >          driver "mouse"
> >          option "Protocol" "IMPS/2"
> >          option "Device" "/dev/input/mice"
> >          option "ZAxisMapping" "4 5"
> >          option "Buttons" "5"
> >          option "Emulate3Buttons" "false"
> > EndSection
> >
> > now is the protocol IMPS/2 correct for a MS Intelliexplorer mouse (I
copied
> > it from the Logitech example) ?
>
> yes it is, but maybe you need to have additional CorePointer options.
> Look at some XFree config howto's.
>
> > - also in the option "Device" the value specified as "/dev/input/mice"
does
> > it need to be /dev/input/uinput or something else ?
>
> No. The mice device is correct.
>
> > - does the mousedev module need to be loaded to make it work ?
>
> Yes.
>
> Regards
>
> Marcel
>
>
>

------=_NextPart_000_03BC_01C3D605.F34769B0
Content-Type: text/plain;
	name="bthid-msmouse_howto.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bthid-msmouse_howto.txt"

	Bthid MS Wireless IntelliExplorer mouse Howto
-----------------------------------------------------------

CREDITS:
Thanks to Marcel Holtmann,Charles Beuche and Peter Klausler

Here is a list of steps required to make the MS IntelliExplorer wireless =
mouse
work with the Linux kernel using the BLueZ stack and bthid program.

1. Download the latest kernel
	# wget http://www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.22.tar.gz

2. Copy the file in the /usr/src folder
	# cp linux-2.4.22.tar /usr/src/

3. change the directory
	# cd /usr/src/

4. Unzip the file
	# tar xzf /root/linux-2.4.22.tar.gz

5. download the latest patches for linux-2.4.22 from =
http://www.holtmann.org/linux/kernel/
	patch-2.4.22-mh2.gz

6. rename the kernel source directory to include the patch name (mh2 in =
this case)
	# mv linux-2.4.22 linux-2.4.22-mh2

7. cd linux-2.4.22-mh2 and Apply the patch
	# zcat patch-2.4.22-mh2.gz | patch -p1
	make sure there were no errors while patching

8. Now to configure the kernel
	copy the old config file from previous kernel to current folder or =
start out afresh if you feel confident
	# cp ../linux-2.4.21-0.13mdk/.config .

9. make xconfig

10. Select the 'm' option for the "User level driver support" from the =
"Input Core support"
	Enable the BLuetooth support as loadable module

11. Save and Exit

12. # make dep

13. # make clean

14. # make bzImage (take a nap)

15. # make modules (take another nap, long one)

16. # make modules_install
	after this step ensure you have the following modules
	/lib/modules/2.4.22-mh2/kernel/net/bluetooth/bluez.o
	/lib/modules/2.4.22-mh2/kernel/net/bluetooth/l2cap.o
	/lib/modules/2.4.22-mh2/kernel/drivers/bluetooth/hci_usb.o
	/lib/modules/2.4.22-mh2/kernel/drivers/input/input.o
	/lib/modules/2.4.22-mh2/kernel/drivers/input/uinput.o
	/lib/modules/2.4.22-mh2/kernel/drivers/input/mousedev.o

17. copy the bzImage to the /boot directory
	# cp arch/i386/boot/bzImage /boot/bzImage_bluez_02Jan2004

18. backup the current System.map file
	# mv /boot/System.map /boot/System.map.old

19. copy current System.map file to /boot and rename it
	# cp System.map /boot/System.map-2.4.22-mh2
	# cd /boot
	# rm System.map
	# ln -s System.map-2.4.22-mh2 System.map

20. create a softlink to new kernel
	# rm /usr/src/linux
	# ln -s linux-2.4.22-mh2/ linux

21 Make changes to /etc/lilo.conf and add the following section, dont =
copy the lines below blindly
they might not work for you.

	image=3D/boot/bzImage_2ndJan2004
	label=3D"BlueZ-Jan7"
	root=3D/dev/hda3
	vga=3D788
	read-only

22. run # lilo
	to verify lilo has been updated

23. # reboot

24. install the latest BlueZ packages by updating the rpms
	# cd /home/bluetooth/rpms
	# rpm -Uhv bl*.rpm

25. download and compile the latest version of libs2 and utils2 from CVS
	# cd libs2
	# ./bootstrap
	# ./configure --prefix=3D/opt/bluetooth
	# make && make install

 	# cd utils2
	# ./bootstrap
 	# ./configure --prefix=3D/opt/bluetooth =
--with-bluetooth=3D/opt/bluetooth
	# make && make install

26. update the linker
	# echo /opt/bluetooth/lib >> /etc/ld.so.conf
	# ldconfig

27. load the following modules
	# insmod /lib/modules/2.4.22-mh2/kernel/net/bluetooth/bluez.o
	# insmod /lib/modules/2.4.22-mh2/kernel/net/bluetooth/l2cap.o
	# insmod /lib/modules/2.4.22-mh2/kernel/drivers/bluetooth/hci_usb.o
	# insmod /lib/modules/2.4.22-mh2/kernel/drivers/input/input.o
	# insmod /lib/modules/2.4.22-mh2/kernel/drivers/input/uinput.o
	# insmod /lib/modules/2.4.22-mh2/kernel/drivers/input/mousedev.o

28. bthid sends its events to the uinput device (/dev/misc/uinput or =
/dev/input/uinput), which might not exist on your system. Here is a =
small list of things you should check if you miss it :

is your kernel compiled with the uinput module ? Check with
	# grep UINPUT /usr/src/linux/.config
do you have the module loaded ? Check with
	# lsmod | grep uinput
do you have the device ? Check with
	# ls /dev/misc/uinput /dev/input/uinput
if you miss the device file, create it with
	# mknod /dev/misc/uinput c 10 223, or setup your /etc/devfsd.conf if =
you are a devfs user

29. make the following changes to the /etc/X11/XF86Config-4, but first =
back it up

add
Section "InputDevice"
     Identifier "MSMouse"
     Driver "mouse"
     Option "Protocol" "IMPS/2"
     Option "Device" "/dev/input/mice"
     Option "ZAxisMapping" "4 5"
     Option "Buttons" "5"
     Option "Emulate3Buttons" "false"
EndSection

and add

    InputDevice "MSMouse" "SendCoreEvents" to the Server Layout section

30. Restart the xserver (Ctrl + Alt + BkSpace works on most systems)

31. login as root

32. attach the bluetooth dongle to the host machine and fire it up
	# hciconfig hci0 up

33. run the hcid and bthid daemon
	# hcid
	# /opt/bluetooth/sbin/bthid -d

34. find the bluetooth address of the Microsoft mouse using
	# hcitool scan

35. finally connect to the mouse using
	# /opt/bluetooth/sbin/bthid -c <btaddress of ms mouse>

also refer to the following
	http://www.holtmann.org/linux/kernel/debian.html
	http://www.bueche.ch/comp/mx900/mx900.html
the README provided by Peter Klausler in his bthid program
	http://klausler.com/msbtkb-linux.html
and also			=
http://sourceforge.net/mailarchive/forum.php?thread_id=3D3615960&forum_id=
%20%20=3D1881%3E%20&forum_id=3D1881

------=_NextPart_000_03BC_01C3D605.F34769B0--
