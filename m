Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Disconnections are not being detected.
From: Marcel Holtmann <marcel@holtmann.org>
To: Xavier GARREAU <x.garreau@prim-time.fr>
Cc: Vlad <vkorolev@nist.gov>, bluez-devel@lists.sourceforge.net
In-Reply-To: <003f01c48755$3dfe6a70$0301a8c0@zazoumobile>
References: <loom.20040820T185934-862@post.gmane.org>
	 <1093073294.3544.12.camel@notepaq>
	 <003f01c48755$3dfe6a70$0301a8c0@zazoumobile>
Content-Type: text/plain
Message-Id: <1093083055.3650.7.camel@notepaq>
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
Date: Sat, 21 Aug 2004 12:10:55 +0200

Hi Xavier,

> >> 1093025241.319200 > ACL data: handle 0x0006 flags 0x02 dlen 16
> >>     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0000 result 2 status 0
> >> 1093025241.320195 < ACL data: handle 0x0006 flags 0x02 dlen 10
> >>     L2CAP(s): Command rej: reason 0
> 
> 
> > actually that is not quite right. The server (phone) sends back a
> > connect response with PSM not supported error status. And we then
> > send a command reject for that. This is really stupid. What kernel
> > version do you use and what kind of hardware is this? Can you
> > reproduce it with the latest 2.4 or 2.6 kernel?
> 
> I guess the command reject is due to scid and dcid being both set to 0 by
> the remote device. So bluez doesn't know who it's to talking to (as we can
> have several cid on one ACL link) ...

you are right. It should fill in dcid and scid. The remote device is
broken. Blame SE about that. I still don't know where the command reject
came from :(

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
