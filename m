Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Rainer Jochem <rainer@graphics.cs.uni-sb.de>
To: bluez-users@lists.sourceforge.net
Cc: jp@dcs.gla.ac.uk
Message-ID: <20030929134026.GA8628@graphics.cs.uni-sb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Subject: [Bluez-users] [HOWTO] Headset with alsa
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 29 Sep 2003 15:40:26 +0200


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


BLUETOOTH-mini-HOWTO for Headsets
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

Some words in the beginning:
I'm an absolute newbie to the whole bluetooth stuff and I'm
glad that I was able to get everything working in two days
although it wasn't that easy all the time.
A big "Thank you!" goes to Jonathan Paisley who wrote the
snd-bluez-sco driver and also was patient with me to help
me with my first steps in the Bluetooth-world.
Of course not to forget all the others of bluez:=20
kudos to all of you!

The sections marked with /* */ are just some thoughts I had
during writing this stuff. If you are only interested in the
howto, ignore them :)


I have tested it using=20

  - Anycom AHS-10 Headset
  - Anycom USB100 Bluetooth-dongle
  - Bluetake BT007SV Bluetooth-dongle

  - Kernel 2.4.22
  - Kernel 2.4.21-ac4

  - Alsa 0.9.6 (www.alsa-project.org)
    (Alsa 0.9.7 currently won't work)
    - alsa-driver-0.9.6
    - alsa-lib-0.9.6

  - from bluez.sourceforge.net:
    - bluez-libs-2.4.tar.gz
    - bluez-utils-2.3.tar.gz
    - bluez-sdp-1.5.tar.gz
    - bluez-pan-1.1.tar.gz
    - bluez-hcidump-1.5.tar.gz
    - bluez-hciemu-1.0.tar.gz
    - bluez-bluefw-0.9.tar.gz

  - from http://www.dcs.gla.ac.uk/~jp/snd-bluez-sco/
    - snd-bluez-sco-2003-09-15.tar.gz=20
=20
  - Time (lots of)...



Let's start:
~~~~~~~~~~~~

First, you'll need to patch the alsa-driver, alsa-libs and your
kernel:

Unpack the alsa stuff and the snd-bluez-sco package from J. Paisley.
You'll find the required patches in the snd-bluez-sco directory.

So do a:
   cd alsa-driver-0.9.6
   patch -p1 < alsa-driver-0.9.6-bluezsco.patch

   cd alsa-libs-0.9.6
   patch -p1 < alsa-lib-0.9.6-bluezsco.patch

   cd /usr/src/linux (or where your kernel-sources are)
   patch -p1 < hciusb-isoc.patch
   (this should not produce any errors)

   You might need to give the patch command the absolute path to
   the .patch-files=20
   (e.g. patch -p1 < /tmp/snd-bluez-sco-2003-09-15/hciusb-isoc.patch) =20


Depending on the version of your snd-bluez-sco package it might be
neccessary to add this line to alsa-driver-0.9.6/alsa-kernel/core/Makefile:
=20
 obj-$(CONFIG_SND_BLUEZ_SCO) +=3D snd-pcm.o snd-page-alloc.o snd.o snd-hwde=
p.o
=20
(see http://sourceforge.net/mailarchive/message.php?msg_id=3D6056143)

This line was forgotten in the patch and I got "unresolved symbols"
when I tried to load the module without it.



Having everything patched, you'll need bluetooth support in your
kernel:

   cd /usr/src/linux
   make menuconfig	(or xconfig, or whatever you like)
   in "Bluetooth support" enable all the modules.
  =20
   /*=20
    * I actually don't know what modules are really=20
    * needed, I've just switched everything on and=20
    * it worked - so someone with more experience
    * may enlighten me :)
    */

   Then build and install your kernel (and the modules).



Now, it's time for alsa:

   cd alsa-driver-0.9.6
   aclocal
   autoconf
   ./configure --with-cards=3Dbluez-sco=20
   (depending on your system you might want to add other soundcards or
   things like oss too - see ./configure --help for all the possibilities)
   make
   make install

   cd alsa-lib-0.9.6
   ./configure
   make
   make install



Then install the bluez-packages:

   Unpack every archive and install each one:
   cd <package-name>
   ./configure
   make
   make install



=2E..build the bluezsco-tool

   cd snd-bluez-sco-2003-09-15/bluezsco-0.1/
   ./configure
   make


After having built and installed everything you'll need to edit some
files in /etc:

   in /etc/modules.conf add the following lines:
      alias net-pf-31 bluez
      alias bt-proto-0 l2cap
      alias bt-proto-2 sco
      alias bt-proto-3 rfcomm
      alias bt-proto-4 bnep
      alias tty-ldisc-15 hci_uart

   or - depending on your distro (e.g. debian), write these=20
   lines in /etc/modutils/bluez (and do an update-modules)


   in /etc/bluetooth/ you'll find these files:
      hcid.conf
      pin
      rfcomm.conf

   I didn't need to edit hcid.conf. Just enter the
   pin of your headset in the pin-file and change the=20
   device-entry in rfcomm.conf to the MAC (or btaddr=20
   how it's called in the bluetooth-world) of your=20
   Bluetooth-USB-dongle.

   /*
    * Again, I don't really know what all the possible
    * options are good for (some of them are described though)
    * so perhaps someone might explain them a bit further
    * than it is in the files. (I like to know what I'm
    * doing when I enable certain features without having
    * to consult an RFC first ;)
    */=20


If you managed it to proceed until here, it's now=20
time to reboot your machine with the new kernel.





Testing...
~~~~~~~~~~

Plug-in your Bluetooth adapter and start the Bluetooth-subsystem
with=20
     /etc/init.d/bluetooth start

Check if the following modules are loaded (using lsmod):
    =20
     snd-bluez-sco
     hci_usb
     rfcomm
     l2cap
     bluez

If not, load them with modprobe.

Now, "hciconfig hci0" should show you the Bluetooth-Adapter:

hci0:   Type: USB=20
        BD Address: xx:xx:xx:xx:xx:xx ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN=20
        RX bytes:52636 acl:27 sco:1905 events:80 errors:0
        TX bytes:52112 acl:25 sco:1895 commands:31 errors:0

Then, switch the Headset on in Pairing-mode (on the AHS-10:=20
hold the On-Off-Switch pressed for 10 seconds until the LED
starts flashing red and green)
Do "sdptool search HSET". If a window appears asking for the
headset-pin, enter it (0000 is factory default).=20

 /*
  * I might be wrong... but if I have an /etc/bluetooth/pin=20
  * file, why is it asking me again for the pin and doesnt
  * use the one specified there?
  * Also, the pin-window irritates me... I was logged in via
  * ssh -X on my notebook and ran this command on my PC
  * and this window appeared on the notebook-screen and not
  * on the monitor of my PC.... what's that ?
  * Why is this hardcoded to the local Xserver of the PC where
  * the bluetooth-stuff is running on?=20
  * (..one should LART the person who did that ;)
  *
  * Another thing which I think is quite annoying is the fact
  * that pin and btaddr of the headset must be entered=20
  * manually each time. Support for a ~/.bluetoothrc would
  * be much more comfortable.
  */

After this you should see an output similar to this:

    Inquiring ...
    Searching for HSET on xx:xx:xx:xx:xx:xx ...
    Service Name: Headset
    Service RecHandle: 0x20000
    Service Class ID List:
      "Headset" (0x1108)
      "Generic Audio" (0x1203)
    Protocol Descriptor List:
      "L2CAP" (0x0100)
      "RFCOMM" (0x0003)
      Channel: 6
    Language Base Attr List:
      coade_ISO639: 0x656e
      encoding:    0x6a
      base_offset: 0x100

xx:xx:xx:xx:xx:xx is the btaddr of your headset=20
(called MAC ID on the sticker of the headset)



=2E..aaand Action!
~~~~~~~~~~~~~~~~

If everything worked fine until here, the following
command should finally let you send and receive audio
from your headset:

snd-bluez-sco-2003-09-15/bluezsco-0.1/bluezsco <btaddr> <channel>

where channel is the same as in the output of the sdptool command
above. i.e.=20
   =20
    bluezsco xx:xx:xx:xx:xx:xx 6
    =20
And you should get an output similar to this:

    Device is 2:0
    Voice setting: 0x0040
    RFCOMM channel connected
    SCO audio channel connected (handle 44, mtu 64)
    Setting sco fd
    Done setting sco fd
    AT+VGS=3D15
    Sending up speaker change 15


That's it!

Now you should be able to play s.th. using

    aplay -D plughw:Headset blah.wav
or
    alsaplayer -d plughw:Headset blah.mp3

And for recording:

    arecord -D plughw:Headset blah.wav


If you examine your audiodevices, you should also find your headset
there. On my PC it was /dev/dsp1, on my notebook /dev/unknown=20
=2E..yes, really...=20


Quite easy, isn't it? *SCNR*



Notes for devfs-users:
~~~~~~~~~~~~~~~~~~~~~~

If you installed the debian packages and have s.th. like

    /etc/devfs/devices.d/bluez

on your system - delete the file, or uncomment every entry
as described in:

http://sourceforge.net/mailarchive/message.php?msg_id=3D5461094

It'll work then. (my notebook has devfs and I needed to do so)




That's all folks...
Again,  I'm a complete bluetooth-newbie and just a linux-geek
who wanted to get his bluetooth headset working with linux. So if you
have any questions about some details or why something isn't working:
I'm the wrong person to ask.
Search the Mailing-list archives and read the stuff on bluez.sf.net
or if this shouldn't help, ask the bluetooth-gurus on the
mailing-list.


Of course I welcome any feedback and improvements on this topic :)


Some additional thoughts:
Is it possible to have the BT-dongle run via hotplug-agent so
everything (modules, enabling of the voice settings) is done=20
automagically and having the hcid listen to commands from the=20
headset (e.g. pushing a knob there) and doing a certain action=20
(like enabling/disabling the voice connection).=20
I guess this is what the hcid is good for?



--=20
This email was written on 100% recycled electrons.

Rainer Jochem	              rainer@graphics.cs.uni-sb.de
http://www.admininside.org/   http://graphics.cs.uni-sb.de/~rainer/


--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/eDZKH/5+6U9F1qYRAj7SAJ9A2utuBEkyur4u2QhNNlXLMcIZPQCdE4RG
fu++iVrpu9TDBEotJDSFmgE=
=r41X
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
