Return-Path: <xavier@xgarreau.org>
From: Xavier Garreau <xavier@xgarreau.org>
To: Stefan Mischke <survivor@uni-paderborn.de>,
   Xavier Garreau <x.garreau@prim-time.fr>
Subject: Re: [Bluez-devel] Accessing HCI on Windows
Date: Tue, 23 Mar 2004 21:47:40 +0100
Cc: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <405FFCB9.5050507@uni-paderborn.de> <030001c410f8$62945a80$b67ba8c0@zaz1> <40607CB2.3050608@uni-paderborn.de>
In-Reply-To: <40607CB2.3050608@uni-paderborn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403232147.41149.xavier@xgarreau.org>
List-ID: <bluez-devel.lists.sourceforge.net>

> But the Com One drivers ARE Widcomm drivers. So where is the difference?

Ouch, i've been to their website and saw the new drivers ... What i did worked 
with tech0776 and they were not from widcomm ...

> Anyway I tried to install the Com One drivers by outcommenting the
> "ExcludeFromSelect" in the .inf file. As a result, the driver
> installation doesn't recognize the fake, but when I try to start the
> Bluetooth Software it says "Your Bluetooth license does not include use
> with this Bluetooth device". After clickeng "Ok" it asks for a license
> file. The license file from my original drivers does not work (version
> differs?). So how can I do it?

Well, it looks like you'll have to code the usb to H4 driver yourself ...

Regards
-- 
Xavier Garreau <xavier@xgarreau.org>
http://www.xgarreau.org/
