Return-Path: <bergmann.peter@gmx.net>
Date: Fri, 3 Oct 2003 11:42:01 +0200 (MEST)
From: "Peter Bergmann" <bergmann.peter@gmx.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
References: <1065171540.1734.97.camel@pegasus>
Subject: Re: [Bluez-users] bluetooth and wireless lan horror
Message-ID: <28385.1065174121@www39.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <bluez-users.lists.sourceforge.net>

Thx for the hint.
I will check how to do this.  

Does anyone know if bluez supports this "language code switching" ?

regards,
pet

> Hi Peter,
> 
> > this question/problem is (maybe) not directly related with bluez .
> > i use bluez with a class 2 usb dongle together with a wireless lan
> > pcmcia card.  bluez is used for a rfcomm connection to a bluetooth
> > input device and works really great!  actually data is beeing 
> > transmitted not very often and only a few bytes, but the rfcomm 
> > connection has to be open all the time.
> > 
> > i knew that bluetooth and wireless lan use the same frequenzy band
> > and that this may lead to problems but for me it's  totally unuseable!
> > 
> > as soosn as i move more than 10 feet away from the wlan accesspoint
> > i get a packetloss from more than 30 percent even if no data is
> > being transmitted via the rfcomm connection.
> > 
> > i dont' understand why wlan transmission is affected even if no data 
> > goes over the bluez rfcomm connection!?
> 
> even if is there is no traffic on the RFCOMM connection doesn't mean
> that there is no traffic at all. Due the fast hopping frequency of
> Bluetooth it is more robust than WLAN and in general there is nothing
> you can do ;) You can use LAN access or PAN over Bluetooth.
> 
> One thing you can try is that you switch your language code of your
> Bluetooth device to france and in this case it won't use all 79 channels
> anymore. Then you can put your WLAN card on a frequency which is no
> longer used by Bluetooth. Maybe this helps, but don't ask me how to do
> this in detail.
> 
> Regards
> 
> Marcel
> 
> 

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++
