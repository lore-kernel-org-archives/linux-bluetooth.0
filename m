Return-Path: <x.garreau@prim-time.fr>
Message-ID: <021901c410d8$724c2630$b67ba8c0@zaz1>
From: "Xavier Garreau" <x.garreau@prim-time.fr>
To: "Marcel Holtmann" <marcel@holtmann.org>,
   "Stefan Mischke" <survivor@uni-paderborn.de>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
References: <405FFCB9.5050507@uni-paderborn.de> <1080040266.2663.317.camel@pegasus>
Subject: Re: [Bluez-devel] Accessing HCI on Windows
Date: Tue, 23 Mar 2004 14:12:08 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>

> as I know there is no Windows stack that provides full access to the HCI
> layer as BlueZ do. Actually it must be possible in some kind of way, but
> in most cases you have to pay for their development kit.


The COM1 stack used to allow direct HCI access (H4 interface) if opening as
a serial port the special file declared in
HKLM\SYSTEM\CurrentControlSet\Enum\USB\Vid_xxxx&Pid_xxxx\something_goes_here
\Device Parameters\SymbolicName
(replace Vid_xxxx&Pid_xxxx with the ones from your device)

You can download their drivers from their website et make it work with your
dongle by editing the .inf file to add YOUR dongle vid&pid.

Just kill their btstack and write your own...

It's surely not usable for commercial products but it works for
testing/development purposes ... I used it to create some demos but am now
working with widcomm SDK which gives acces to all levels of the stack
beginning from l2cap (or HCI vendor commands)

Hope it helps.

I did reply to the list because there are often questions about
bluetooth/windows here ...

BR,
-- 
Xavier Garreau <x.garreau@prim-time.fr>
Prim'Time Technology
http://www.prim-time.fr/
