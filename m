Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] a2play and Toshiba SR-1 Bluetooth Headset
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A6F09C.5000801@parrot.fr>
References: <20041125091124.GA19805@snoopy.src.ricoh.co.jp>
	 <20041125112509.75347786.henryk@ploetzli.ch>
	 <20041125105615.GA19821@snoopy.src.ricoh.co.jp>
	 <1101440449.6465.64.camel@pegasus>
	 <20041126045659.6a3291f5.henryk@ploetzli.ch>
	 <1101442380.6465.77.camel@pegasus>  <41A6F09C.5000801@parrot.fr>
Content-Type: text/plain
Message-Id: <1101490174.6514.39.camel@pegasus>
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
Date: Fri, 26 Nov 2004 18:29:34 +0100

Hi Sebastien,

> > actually for me it is not clear if we have to insert that header (even
> > with no content protection information) when the capabilities shows that
> > record. Maybe I missed something in the specification.
> 
> In fact you have to insert the content protection header only if you 
> want to use it.
> 
> This capablity is optional, so you can skip it during the stream 
> configuration process.

this don't answers my question. If we don't use it in set configuration
then we don't have add the content protection header?

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
