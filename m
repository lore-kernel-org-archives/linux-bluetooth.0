Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4230049C.5040108@suche.org>
From: "suche.org" <admin@suche.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: btsco and alsa driver interaction
References: <d0ktcr$n2i$1@sea.gmane.org> <422E59A9.2040408@xmission.com> <d0meub$s51$1@sea.gmane.org>
In-Reply-To: <d0meub$s51$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Thu, 10 Mar 2005 09:26:04 +0100

soraberri wrote:

> Hi
>
> many thanks Brad! I didn't think in the mixer before... now I think I
> got it :O
> (by the way, I haven't forgotten about adding support in the audio
> gateway as you suggested one day, in order to let the headset intiate
> an audio connection. This would require the proper SDP record in the
> database with the proper RFCOMM channel number, and a RFCOMM socket
> listening in the application. I made some copy-paste for the first
> thing in sdptool code, but I haven't find the rigth place for the
> listening socket yet... I have much left to study I guess!)

Hi,

in btso2 the listen socket can be easyly integretet.
You aktivate hin in the main while loop. It should be no problem
since the programm is desinged to handle multiple connections.
But currently only supprt one since i do not know how to add an second
headset, and have none.

Cu Thomas


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
