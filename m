Return-Path: <x.garreau@prim-time.fr>
Message-ID: <030001c410f8$62945a80$b67ba8c0@zaz1>
From: "Xavier Garreau" <x.garreau@prim-time.fr>
To: "Stefan Mischke" <survivor@uni-paderborn.de>
Cc: "Marcel Holtmann" <marcel@holtmann.org>,
   "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
References: <405FFCB9.5050507@uni-paderborn.de> <1080040266.2663.317.camel@pegasus> <021901c410d8$724c2630$b67ba8c0@zaz1> <4060660E.5050004@uni-paderborn.de>
Subject: Re: [Bluez-devel] Accessing HCI on Windows
Date: Tue, 23 Mar 2004 18:00:46 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>

> Do I understand correctly that an USB Bluetooth dongle can be treated as
if it was connected to the serial port of the pc? In this case calling > the
Windows API Function CreateFile(SymbolicName) and doing ReadFile() and
WriteFile() according to H4 would do the job, wouldn't it?

Yes ! That's it ! But Widcomm drivers do not work this way.

> > You can download their drivers from their website et make it work with
your
> > dongle by editing the .inf file to add YOUR dongle vid&pid.
> By "their" you mean Widcomm? Ok, my Dongles are shipped with Widcomm
drivers, so I don't have to change the .inf file, correct?

No those from Com1 (http://www.com1.fr)

BTW, Widcomm documentation is very very good !

BR,
-- 
Xavier Garreau <x.garreau@prim-time.fr>
Prim'Time Technology
http://www.prim-time.fr/
