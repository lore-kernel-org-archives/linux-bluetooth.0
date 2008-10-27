Return-Path: <cyrus@holtmann.org>
Message-ID: <40aff9180810271553n6022b0f1l711a3f65eb39665d@mail.gmail.com>
Date: Mon, 27 Oct 2008 23:53:52 +0100
From: Fiorellino <fiorellino@gmail.com>
Sender: alfonso.fiore@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: Fwd: how to pair blueZ 4.17 with my keyboard (what happened to hidd?)
Cc: "Marcel Holtmann" <marcel@holtmann.org>
In-Reply-To: <40aff9180810271552rc0b7689g43c29ca1c9c0dc6d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <40aff9180810271552rc0b7689g43c29ca1c9c0dc6d@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel.

Thank you for your answer. I understand that 3.36 is very outdated.

I tried to download and compile 4.17. Finally after compiling,
installing 4.17 and rebooting I got the dongle up and running but I
don't know which commands to issue to try to pair with my keyboard.

dmesg | grep -i blue

Bluetooth: Core ver 2.11
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.9

voyage:~# lsusb
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd
Bluetooth Dongle (HCI mode)
Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

voyage:~# hciconfig
hci0:   Type: USB
       BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
       DOWN
       RX bytes:0 acl:0 sco:0 events:0 errors:0
       TX bytes:0 acl:0 sco:0 commands:0 errors:0

voyage:~# hciconfig hci0 up
voyage:~# hciconfig
hci0:   Type: USB
       BD Address: 00:1B:DC:0F:74:09 ACL MTU: 310:10 SCO MTU: 64:8
       UP RUNNING
       RX bytes:2784 acl:0 sco:0 events:85 errors:0
       TX bytes:285 acl:0 sco:0 commands:37 errors:0

voyage:~# hcitool scan
Scanning ...
       00:18:00:00:78:86       BTKB-7886

voyage:~# hcitool cc 00:18:00:00:78:86
voyage:~#

#####################
Behaviour is exactly the same as with the old BlueZ. It goes back to
prompt without asking me for any PIN code, and the keyboard keeps
blinking.
#####################

I bet I don't know the correct sequence of commands to pair with this
new release of BlueZ....

Any idea?

Thank you,

alfonso

----------------------------

Just some additional info regarding my compiling, since I had to use a
little "hack" to get it done...

(please allow me to let you know that configure does not check for
yacc and flex)

#dpkg -l | grep -i blue

apt-get remove bluez-utils libbluetooth2 (I think, I'm not sure about
the 2nd one)
dpkg --purge bluez-utils libbluetooth2

apt-get install build-essential pkg-config libdbus-1-dev
libglib2.0-dev libusb-dev byacc flex (these were missing on my system)

wget http://www.kernel.org/pub/linux/bluetooth/bluez-4.17.tar.gz
tar xvzf bluez-4.17.tar.gz
./configure
make

[...]
make[3]: Entering directory `/root/bluez-4.17/rfcomm'
test -f lexer.c || /bin/sh ../ylwrap lexer.l .c lexer.c -- /bin/sh
/root/bluez-4.17/missing --run flex
make[3]: *** [lexer.c] Error 1
make[3]: Leaving directory `/root/bluez-4.17/rfcomm'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/root/bluez-4.17/rfcomm'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/root/bluez-4.17'
make: *** [all] Error 2

So I run the following

########################
cd rfcomm
flex -o lexer.c lexer.l
########################

and then compilation went all right.

hcitool was complaining about libbluetooth.so.3 so I run:

ldconfig -v


On Mon, Oct 27, 2008 at 8:47 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Fiorellino,
>
>> I have a keysonic bluetooth keyboard.
>> It works perfectly under windows (I know you don't care, but at least
>> the keyboard is working fine!) using the embedded BT controller of my
>> laptop.
>>
>> Now I'd like to use it under Debian lenny/sid in an embedded PC
>> (alix3d3) using a Trust Ultra Small Bluetooth 2 USB Adapter.
>>
>> With "apt-get install" I installed bluez-utils 3.36-1.
>
> we are already at bluez-4.17 release. So 3.36 is pretty outdated and it
> has a bug within its HID support.
>
> Regards
>
> Marcel
>
>
>
