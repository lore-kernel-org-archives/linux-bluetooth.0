Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SBC packer done, kind of
From: Marcel Holtmann <marcel@holtmann.org>
To: Brad Midgley <bmidgley@xmission.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A4C6A8.2080508@xmission.com>
References: <20041123014732.3a03b10e.henryk@ploetzli.ch>
	 <1101191260.26578.43.camel@pegasus>
	 <20041123074829.7f978ce7.henryk@ploetzli.ch>
	 <1101201897.26578.54.camel@pegasus>
	 <20041123204901.776fe240.henryk@ploetzli.ch>
	 <1101243809.27351.18.camel@pegasus>
	 <20041124042114.5e1fee94.henryk@ploetzli.ch>
	 <1101272477.27351.67.camel@pegasus>  <41A43E8A.8030602@xmission.com>
	 <1101307146.27351.104.camel@pegasus>  <41A4C6A8.2080508@xmission.com>
Content-Type: text/plain
Message-Id: <1101318257.27351.138.camel@pegasus>
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
Date: Wed, 24 Nov 2004 18:44:17 +0100

Hi Brad,

> a2play in cvs w/NONSPECAUDIO should behave for you like it did when it 
> was last working for you. i disabled all the new stuff (it didn't help 
> or hurt the bluetake).

for the Aiptek headphone I only get the NONSPECAUDIO version working and
you must send 0xff 0xff for the first media payload. For all further
media payloads it seems that it doesn't matter anymore.

Setting the pt, timestamp and ssrc is working for me. Does it also work
for you? If yes, there is no need to uncomment it.

> that's really too bad the framing didn't fix things for yours like it 
> did the bluetake. they are totally out of spec. that doesn't bode well 
> for interoperating with the other headsets out there.

This is very sad. So I can't help here with testing this until someone
sends me a Bluetake headphone.

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
