Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth 1.2 and HID Proxy
References: <1086429803.16316.44.camel@pegasus>
In-Reply-To: <1086429803.16316.44.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200406052338.15162.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 5 Jun 2004 23:38:14 +0200

Marcel, 

pls start new webpage on bluez which will collect all known doglech which we 
know reflash with newer firmware and pls try describe step-by-step howto.

Michal

On Saturday 05 of June 2004 12:03, Marcel Holtmann wrote:
> Hi Folks,
>
> for everyone of you who is searching for a Bluetooth 1.2 capable USB
> dongle or a dongle with HID Proxy support, there is now a way to getting
> one with a minimum of costs. It is possible through the update efforts
> of Apple. Before they equiped their machines with internal Bluetooth
> adapters they sold (and I think still sell) a USB dongle from D-Link.
> According to Apple every D-Link with hardware revision B2 and higher can
> be updated through their firmware updater
>
> http://www.apple.com/downloads/macosx/apple/bluetoothfirmwareupdater.html
>
> So I bought myself a D-Link (Rev B3) and tried it. I used the DFU wizard
> from CSR and after some time I got the new firmware on the dongle
>
> hci0:   Type: USB
>         BD Address: 00:0D:88:xx:xx:xx ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:966 acl:0 sco:0 events:25 errors:0
>         TX bytes:333 acl:0 sco:0 commands:24 errors:0
>         Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'D-Link DBT-120 (Rev B3)'
>         Class: 0x1c010c
>         Service Classes: Rendering, Capturing, Object Transfer
>         Device Class: Computer, Laptop
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x4d9 LMP Ver: 1.2 (0x2) LMP Subver:
> 0x4d9 Manufacturer: Cambridge Silicon Radio (10)
>
> And now this dongle is not only capable of Bluetooth 1.2 it also uses
> the HID Proxy feature. The HID mode is the default boot mode and you
> need to use hid2hci to switch between the modes.
>
> The bad news are that you must extract the file GenericCSR.dfu from the
> Apple firmware update. Actually that is impossible without using Mac OS.
> And the other problem is that you need a DFU Upgrade utility. The CSR
> one is not for free and I never really finished the download code for
> btdfu. Right now I don't know how to get these two thinks worked out.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the new InstallShield X.
> From Windows to Linux, servers to mobile, InstallShield X is the one
> installation-authoring solution that does it all. Learn more and
> evaluate today! http://www.installshield.com/Dev2Dev/0504
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
