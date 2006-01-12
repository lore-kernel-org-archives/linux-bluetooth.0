Return-Path: <wolfgang.walter@studentenwerk.mhn.de>
From: Wolfgang Walter <wolfgang.walter@studentenwerk.mhn.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: patch: problem with sco
Date: Thu, 12 Jan 2006 15:59:30 +0100
References: <200601120138.31791.wolfgang.walter@studentenwerk.mhn.de> <43C64B0C.2080903@trash.net> <1137072707.5013.7.camel@localhost.localdomain>
In-Reply-To: <1137072707.5013.7.camel@localhost.localdomain>
Cc: Patrick McHardy <kaber@trash.net>, bluez-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, maxk@qualcomm.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200601121559.31203.wolfgang.walter@studentenwerk.mhn.de>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

> so it seems that Broadcom really messed the SCO MTU settings up and we
> have to workaround with some sane values.

Maybe flow control for SCO must be explicitly switched on on broadcom? It=20
seems that one can switch on and off flow control for SCO (but switched off=
=20
completion events should not be sent at all).

There is another thing with flow-control in in bluez: as far as I see the c=
ode=20
assumes to get a completion event for every packet submitted to the=20
controller. But this is not necessarily the case. A HCI_EV_DISCONN_COMPLETE=
=20
for a connection implicitly completes all packets of that connection.

I don't know if any controller uses this feature, though.

>
> Please also include the lspci for these devices.
>

Regards,
=2D-=20
Wolfgang Walter
Studentenwerk M=FCnchen
Anstalt des =F6ffentlichen Rechts
Leiter EDV
Leopoldstra=DFe 15
80802 M=FCnchen
Tel: +49 89 38196 276
=46ax: +49 89 38196 144
wolfgang.walter@studentenwerk.mhn.de
http://www.studentenwerk.mhn.de/
