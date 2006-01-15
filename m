Return-Path: <wolfgang.walter@studentenwerk.mhn.de>
From: Wolfgang Walter <wolfgang.walter@studentenwerk.mhn.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: patch: problem with sco
Date: Sun, 15 Jan 2006 15:40:27 +0100
Cc: bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        maxk@qualcomm.com
References: <200601120138.31791.wolfgang.walter@studentenwerk.mhn.de> <200601130031.22063.wolfgang.walter@studentenwerk.mhn.de> <1137140826.3879.1.camel@localhost.localdomain>
In-Reply-To: <1137140826.3879.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200601151540.28879.wolfgang.walter@studentenwerk.mhn.de>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

Am Freitag, 13. Januar 2006 09:27 schrieb Marcel Holtmann:
> Hi Wolfgang,
>
> > > send in the information from "hciconfig -a" for this device, because
> > > this is a hardware bug and you can't be sure that you can have eight
> > > outstanding SCO packets.
>
> does anything changes if you load the hci_usb driver with reset=3D1 ?
>

So, I tested this today: changed nothing. Neither the output of hciconfig h=
as=20
changed nor any data is sent to the headset.

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
