Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] tcsendbreak and flow control on hciattach (csrchip)
Message-ID: <39417DF3286A66428FA558987839F44F152D9A@SINTEFXCH01.sintef.no>
From: "Rognlien Dag Kristian" <Dag.K.Rognlien@sintef.no>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 11 Oct 2004 12:21:10 +0200



> -----Original Message-----
> From: David Woodhouse [mailto:dwmw2@infradead.org]=20
> Sent: 9. oktober 2004 11:30
> To: Marcel Holtmann
> Cc: Rognlien Dag Kristian; BlueZ Mailing List
> Subject: Re: [Bluez-devel] tcsendbreak and flow control on=20
> hciattach (csrchip)
>=20
> IIRC the CSR units ship with the 'reset on break' PS key=20
> turned off so it doesn't have any effect anyway.

There is no problem to change the PS keys through the SPI interface. We
have the 'reset on break' set on our systems.

Regards,
Dag K. W. Rognlien
Research Scientist
SINTEF ICT
Communication Systems



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
