Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] RFCOMM communication gets stalled
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <A1F0D47583A2D711919F00600819B3A45BDC76@goofy.vitronics.com>
From: "Williams, Richard" <Richard.Williams@VITRONICS.com>
To: "Bluez-Devel (E-mail)" <bluez-devel@lists.sourceforge.net>
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
Date: Thu, 15 Jul 2004 14:11:41 -0400


Marcel,

I use the rfcomm tty interface quite successfully for sending GPS data
strings from a GPS receiver to an Ipaq and then to another small wrist =
display.
Why use the rfcomm socket interface instead of the TTY ?=20

Should I consider changing my code from TTY to socket ? Its not so =
difficult, I just
wonder why you recommend one vs the other.

thanks and Best regards,

Rich

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]
Sent: Thursday, July 15, 2004 1:49 PM
To: Carlos AM
Cc: lista bluez
Subject: Re: [Bluez-devel] RFCOMM communication gets stalled


Hi Carlos,

> I'm using bluez-libs-2.7 and bluez-utils-2.7 to develop a GPS system
> that communicates via bluetooth. I use the RFCOMM and the connection
> and disconnection works fine but the transmission gets stalled in
> about ten minutes. Both sides indicate that they are still connected,
> but in the GPS side, the process that writes in the rfcomm device
> (/dev/bluetooth/rfcomm/0) stops on a blocking write call:
> =20
>     write(fdbluetooth,s,strlen(s));
> =20
> I open the rfcomm device this way:
> =20
>     fdbluetooth=3D open("/dev/bluetooth/rfcomm/0",O_RDWR | O_NOCTTY);
> =20
> =20
> That write call works fine for a while until the communication gets
> stalled.

don't use the RFCOMM TTY terminal emulation. Go directly throught the
RFCOMM socket interface. If you still got problems check with hcidump
what is going on.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=3D4721&alloc_id=3D10040&op=3Dclick
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
