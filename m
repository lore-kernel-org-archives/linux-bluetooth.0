Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Esther Lopez" <esther.lopez@erzia.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Control of radiated power
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <20050929075906.1FFDF819@arbetsmyra.dyndns.org>
Message-Id: <20050929080904.90FAA1EC90C@mrelay1.st2.lyceu.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 29 Sep 2005 10:09:52 +0200

Hello Ronny

Can you please give me more details on how to do this?
What I need is to reduce the radiated power of the card, and leave it to a
fixed value.
Also, how can I disable the automatic power control at LMP? I have read the
specification and haven't found the command to do this.

Thanks and regards

Esther

-----Mensaje original-----
De: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] En nombre de Ronny L
Nilsson
Enviado el: jueves, 29 de septiembre de 2005 9:57
Para: bluez-devel@lists.sourceforge.net
Asunto: Re: [Bluez-devel] Control of radiated power


> My device is a Brainboxes PCMCIA card with BlueCore02 chipset. I have
> asked them, and they are on it...

Hi
Yes it's possible to do transmitter power control with this chipset. I 
have an alfa-patch for the bccmd utility which can do this. I haven't 
tried it with PCMCIA though, but via USB and UART it seems to work 
fine. My biggest problem now seem to be finding spare time to clean the 
patch up according to Marcels quite high demand on codingstyle...  :) 


> In the meanwhile... The LMP protocol is in charge of automatically
> controlling the power level (isn't it?). Is is possible to deactivate
> this power level control, leaving the radiated power at a fixed


Yes, this is possible too.

/Ronny



> -----Mensaje original-----
> De: bluez-devel-admin@lists.sourceforge.net
> [mailto:bluez-devel-admin@lists.sourceforge.net] En nombre de Marcel
> Holtmann
> Enviado el: lunes, 26 de septiembre de 2005 11:19
> Para: bluez-devel@lists.sourceforge.net
> Asunto: Re: [Bluez-devel] Control of radiated power
>
> Hi Esther,
>
> > Just a fast question. Is there any software way (using BlueZ) for
> > controlling the radiated power and setting it to a desired value? I
> > have been investigating and having found anything
>
> not according to the Bluetooth HCI specification. You need to find a
> vendor specific command for that. Ask you chip or dongle
> manufacturer.
>
> Regards
>
> Marcel





-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
