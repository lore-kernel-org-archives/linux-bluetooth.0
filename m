Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SDP memory leak?
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Mischke <StefanMischke@web.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   "Stefan Mischke (E-Mail)" <survivor@upb.de>
In-Reply-To: <412F3619.40202@web.de>
References: <412F29D2.7000001@web.de> <1093610969.2581.119.camel@pegasus>
	 <412F3619.40202@web.de>
Content-Type: text/plain
Message-Id: <1093613316.2581.133.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 27 Aug 2004 15:28:36 +0200

Hi Stefan,

> Well then, I just figured out (in my own TestApp based on 
> "bnep_sdp_search()") that it simply doesn't work like this. I propose to 
> do "sdp_close()" as the last sdp_* call (as in the code below). Same 
> with dund. So there might be no memory leak but an illegal pointer 
> access. One has to correct "pand/sdp.c" and "dund/sdp.c".

I am very busy with some other problems and I am not the expert when it
comes to the SDP code. Write a patch that I can apply and show me that
it is the right way to do it. Be careful with the other return pathes in
that functions.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
