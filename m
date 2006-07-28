Return-Path: <Bearcat@feline-soul.com>
From: "Bearcat M. Sandor" <Bearcat@feline-soul.com>
Reply-To: Bearcat@feline-soul.com
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] can't connect EPOX Keyboard BT-KB01B
Date: Fri, 28 Jul 2006 10:48:06 -0600
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
References: <44C8FB2F.9070403@kernelconcepts.de> <44C9DB62.1000103@kernelconcepts.de> <1154079988.2298.23.camel@localhost>
In-Reply-To: <1154079988.2298.23.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200607281048.07126.Bearcat@feline-soul.com>
List-ID: <bluez-users.lists.sourceforge.net>

Folks, 

Thank you again for the help so far. I have placed a bunch of output files on 
my server for your viewing pleasure, instead of giving you large outputs in 
an email body.

This is the output from hcidump -X -V while just pressing keys on the keyboard 
after pressing the connect button:
http://www.feline-soul.com/files/hcidump

This is the output from hcidump -X -V when a "hcitool cc 00:07:61:1B:50:9B" is 
run:
http://www.feline-soul.com/files/hcidump_hcitool_connect

This is the output from hcidump -X -V when a "hidd --connect 
00:07:61:1B:50:9B" is run:
http://www.feline-soul.com/files/hcidump_hidd_connect

My hcid configuration file:
http://www.feline-soul.com/files/hcid.conf

My rfcomm configuration file (I have never altered it)
http://www.feline-soul.com/files/rfcomm.conf

The daemon hidd is indeed running:
root      4750  0.0  0.0   5040   484 ?        Ss   Jul26   
0:00 /usr/bin/hidd --server

Pertainent modules are as follows:
hidp                   17152  3
l2cap                  22408  14 rfcomm,hidp
usbhid                 37024  0
bluetooth              47268  12 rfcomm,hidp,l2cap,hci_usb
hci_usb                15892  6


I have taken the batteries out of the keyboard, pressed the gray button, 
pressed the button on my hub, unplugged and plugged the hub back in, and 
sacrificed AOL Cd's on an alter in the name of Tux.

I am never prompted for a pin (and i don't know what it would be if i was). I 
have taken the kde pin handler line out of the config and still i am never 
asked for a pin. Truthfully, i don' t even know if i should be or not.

What else can i provide?

Thank you again,

Bearcat M. Sandor

On Friday 28 July 2006 03:46 in an email titled "Re: [Bluez-users] can't 
connect EPOX Keyboard BT-KB01B" Marcel Holtmann wrote:
>Hi Nils,
>
>> > No such luck for me yet. Strangly the hcitool does not allow the auth
>> > option for me. I had to do a hciconfig /dev/usb/hci0 auth to turn the
>> > auth on the hub. Auth is now on but the keyboard still doesn't connect.
>> > As usuall nothing is reported in the syslogs.
>> >
>> > Do i need to turn on the auth for the keyboard too (is that even an
>> > option)?
>>
>> No, the keyboard will require that automatically.
>
>actually only the Apple keyboards require this and this is wrong
>according to the HID specification. The host must make the decision to
>authenticate and switch on encryption.
>
>Regards
>
>Marcel

-- 
Bearcat M. Sandor
Bearcat@feline-soul.com
ICQ: 6628727
MSN: bearcatsandor@hotmail.com
Yahoo: bearcatsandor
AIM: bearcatmsandor
Jabber: bearcatsandor@jabber.org
