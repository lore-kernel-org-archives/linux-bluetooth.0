Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] CVS doubles
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41B6CBDC.4010802@suche.org>
References: <20041206225609.GA1177@zeus.galaxy.org.uk>
	 <cp3mkk$m7t$1@sea.gmane.org> <1102407664.8447.20.camel@pegasus>
	 <cp3rr7$1vv$1@sea.gmane.org> <1102411047.8447.28.camel@pegasus>
	 <cp4a8v$959$1@sea.gmane.org> <1102425729.8447.41.camel@pegasus>
	 <cp4df4$i6l$1@sea.gmane.org> <1102439143.8447.47.camel@pegasus>
	 <cp6fpq$167$1@sea.gmane.org> <1102496771.9988.35.camel@pegasus>
	 <41B6CBDC.4010802@suche.org>
Content-Type: text/plain
Message-Id: <1102499338.9988.44.camel@pegasus>
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
Date: Wed, 08 Dec 2004 10:48:58 +0100

Hi Thomas,

> since i wan't to test sdptool with HF (Handsfree) i found some ugly points.
> 1. On the webside there is no more link to bluez-sdp
> 2. In CVS bluez/dsp contain sdptool AND bluez/utils contain sdptoll
> but bluez/utils depends on bluez/dsp for (libdsp)

the bluez-pan and bluez-sdp packages were deprecated a long time ago and
I will delete the CVS repositories once I checked that we don't any code
from them anymore. Use bluez-libs and bluez-utils. Everything you need
is in there.

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
