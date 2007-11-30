Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <a8e1da0711292234t22b9a31ej4bbbcbcfba6a7a4c@mail.gmail.com>
Date: Fri, 30 Nov 2007 14:34:49 +0800
From: "Dave Young" <hidave.darkstar@gmail.com>
To: bluez@t3i.nl
In-Reply-To: <E1Ixsmq-00086k-Is@daffy.sipo.nl>
MIME-Version: 1.0
References: <E1Ixsmq-00086k-Is@daffy.sipo.nl>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] second usb bluetooth device not detected
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Nov 30, 2007 7:27 AM, thHog <bluez@t3i.nl> wrote:
> Hi,
>
> I have two bluetooth USB dongles attached. Both devices work OK if they are
> attached seperately. But, when they are both attached, then just one is
> activated. How can they both be activated? I have attached some info:
>
>
> Zeus ~ # lsusb
> Bus 001 Device 009: ID 0a5c:200a Broadcom Corp.
> Bus 001 Device 008: ID 1131:1001 Integrated System Solution Corp. KY-BT100
> Bluetooth Adapter
>
>
> Zeus ~ # hcid -s -n -d
> hcid[10226]: Bluetooth HCI daemon
> hcid[10226]: Enabling debug information
> hcid[10226]: HCI dev 0 registered
> hcid[10226]: HCI dev 0 already up
> hcid[10226]: Device hci0 has been added
> hcid[10226]: Starting security manager 0
> hcid[10226]: Device hci0 has been activated
> hcid[10226]: Starting SDP server
> hcid[10226]: Adding rec : 0x80872c0
> hcid[10226]: with handle : 0x1
> hcid[10226]: Adding rec : 0x8087440
> hcid[10226]: with handle : 0x0
> hcid[10226]: Service classes 0x00
> hcid[10226]: Creation of inotify context failed
> hcid[10226]: Created local server at
> unix:abstract=/var/run/dbus-Ol6xcYn7qF,guid=93e6418dd3ca50759dcd2200474f4937
> hcid[10226]: Registering service object: ident=input, name=Input service
> (/org/bluez/service_input)
> input[10229]: Bluetooth Input daemon
> input[10229]: Registered input manager path:/org/bluez/input
> hcid[10226]: /usr/lib/bluetooth/bluetoothd-service-input executed with PID
> 10229
> hcid[10226]: Registering service object: ident=serial, name=Serial service
> (/org/bluez/service_serial)
> serial[10230]: Bluetooth Serial Port daemon
> serial[10230]: Registered manager path:/org/bluez/serial
> hcid[10226]: /usr/lib/bluetooth/bluetoothd-service-serial executed with PID
> 10230
> hcid[10226]: Registering service object: ident=network, name=Network service
> (/org/bluez/service_network)
> hcid[10226]: /usr/lib/bluetooth/bluetoothd-service-network executed with PID
> 10231
> hcid[10226]: /etc/bluetooth/audio.service: Key file does not have key
> 'Autostart'
> hcid[10226]: Registering service object: ident=audio, name=Audio service
> (/org/bluez/service_audio)
> network[10231]: Bluetooth Network daemon
> network[10231]: Parsing /etc/bluetooth/network.conf failed: No such file or
> directory
> network[10231]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null),
> GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1,
> Security=true
> network[10231]: Failed to open control socket: Protocol not supported (93)
> network[10231]: Can't init bnep module
> hcid[10226]: child 10228 exited
> hcid[10226]: Network service (network) exited with status 1
> hcid[10226]: child 10227 exited
> hcid[10226]: Child PID 10229 got the unique bus name :1.25
> hcid[10226]: name_listener_add(:1.25)
> hcid[10226]: Child PID 10230 got the unique bus name :1.26
> hcid[10226]: name_listener_add(:1.26)
> hcid[10226]: Got NameOwnerChanged signal for :1.27 which has no listeners
>
>
> Zeus ~ # cat /etc/bluetooth/hcid.conf
> #
> # HCI daemon configuration file.
> #
>
> # see man hcid.conf
>
> # HCId options
> options {
>         autoinit yes;
>         pairing multi;
>         offmode devdown;
>         passkey "1234";
>         security auto;
> }
>
> # Default settings for HCI devices
> device {
>         name "BlueZ (%h)";

Maybe you can try
    name "BlueZ(%d)";

>         #class 0x3e0100;
>         class 0x000100;
>         iscan enable;
>         pscan enable;
>         lm accept;
>         lp rswitch,hold,sniff,park;
>         discovto 0;
> }
>
>
> -------------------------------------------------------------------------
> SF.Net email is sponsored by: The Future of Linux Business White Paper
> from Novell.  From the desktop to the data center, Linux is going
> mainstream.  Let it simplify your IT future.
> http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
