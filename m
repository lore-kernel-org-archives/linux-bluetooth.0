Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SDP memory leak?
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Mischke <StefanMischke@web.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   "Stefan Mischke (E-Mail)" <survivor@upb.de>
In-Reply-To: <412F29D2.7000001@web.de>
References: <412F29D2.7000001@web.de>
Content-Type: text/plain
Message-Id: <1093610969.2581.119.camel@pegasus>
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
Date: Fri, 27 Aug 2004 14:49:29 +0200

Hi Stefan,

> I have a question about "bnep_sdp_search()" from 
> "bluez-pan-1.1/pand/sdp.c" (see below for the code).
> If I see it correctly, the memory for "sdp_list_t *srch, *rsp" is 
> allocated by "sdp_service_search_req()".
> But "bnep_sdp_search()" accesses the pointer "rsp" after it has done 
> "sdp_close()".
> So my question is: 'Who will ever free the memory allocated at "rsp" and 
> when?'
> 
> I quite new to this, so I probably have missed something. So sorry if 
> this is a stupid one :-).

no, I think you are right. I expect more memory leaks in the SDP code.
We need some people to check this and send me patches.

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
