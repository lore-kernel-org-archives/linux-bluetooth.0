Return-Path: <keihachi@swissinfo.org>
Message-ID: <000a01c461a4$e79be160$0364a8c0@haruo>
From: "KeiHachi" <keihachi@swissinfo.org>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
References: <003401c45c2b$b6eab240$0364a8c0@haruo> <1088359746.3774.20.camel@pegasus>  <000c01c45d2c$ed2e5f80$0364a8c0@haruo> <1088442828.6030.27.camel@pegasus>  <002801c45dfb$c533d760$0364a8c0@haruo> <1088530908.6030.310.camel@pegasus>  <000d01c45ebe$72d6e660$0264a8c0@haruo> <1088619095.4540.126.camel@pegasus>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
Date: Sun, 4 Jul 2004 17:57:11 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
List-ID: <bluez-devel.lists.sourceforge.net>

Hi, Marcel.

> I already did that and in the fact of SEP it is nothing different from a
> PSM or RFCOMM channel. Actually because of this I thought that a socket
> based implementation is the best. Along time I prefered to keep AVDTP in
> userspace. However the only difficult part is the discover, because if
> you don't know the SEP you must use it to find the available ones and
> this includes a L2CAP connection. I must see how this gets integrated in
> a nice way.

I see.
You, Marcel, are the one of the best engineer in the world,
so I anticipate the time when AVDTP will be completed.


> There is no secret about it. Parts of the communication can be found in
> the mailing list archive. The rest was not in public, but actually only
> by accident.

I found those e-mails, thank you.


> What we had done was to fix the L2CAP and RFCOMM protocol layers and
> extend the test programs to pass the qualification tests.
> 
> There was no contract and they didn't paid us.

Thank you, you furnished me with useful information.


Regards,
KeiHachi.
