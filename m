Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BTsco
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41ADB1C2.8070805@suche.org>
References: <200412010839.06669.mailsp@sebastian-eichner.de>
	 <200412010943.33419.mail@sebastian-eichner.de>
	 <1101894192.18840.44.camel@pegasus>
	 <200412011224.29191.mail@sebastian-eichner.de>  <41ADAC67.10706@suche.org>
	 <1101901302.18840.72.camel@pegasus>  <41ADB1C2.8070805@suche.org>
Content-Type: text/plain
Message-Id: <1101902920.18840.79.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 01 Dec 2004 13:08:40 +0100

Hi Thomas,

> > this looks a way better. I am going to check it in as btsco2.c
> >   
> Uhps the S must be came in when is saved the source :-(

your version is now in the CVS as btsco2.c and I already fixed a bunch
of coding style mistakes that were still present (especially the missing
static declarations). There are still some more things that are not nice
and you should read the kernel coding style paper from Greg.

Regards

Marcel





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
