Return-Path: <dwmw2@redhat.com>
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1038409787.771.53.camel@pegasus.local> 
References: <1038409787.771.53.camel@pegasus.local>
	<5.1.0.14.2.20021126092054.0798bff0@mail1.qualcomm.com>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: Max Krasnyansky <maxk@qualcomm.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Reuse of H4 and BCSP code 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Nov 2002 12:35:44 +0000
Message-ID: <32494.1038486944@passion.cambridge.redhat.com>
Sender: David Woodhouse <dwmw2@redhat.com>
List-ID: <bluez-devel.lists.sourceforge.net>


marcel@rvs.uni-bielefeld.de said:
>  And it should be possible to put some quirks into the serial_cs to
> let it work with all cards supported by the bt950_cs and btuart_cs
> driver, but from my point this is the wrong way, because the serial_cs
> is a very messy beast. 

Btw, I have a patch from rmk which fixes the 8250 driver so it works with my
OXCF950 (Cyber-blue) card and btuart_cs is no longer necessary. What other 
cards currently still require btuart_cs and why?

--
dwmw2
