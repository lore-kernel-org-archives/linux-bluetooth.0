Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HID report mode protocol support in 2.6.11-mh1
	broken/missing?
From: Vesa Halttunen <vesuri@jormas.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1110826222.629.29.camel@pegasus>
References: <1110498275.3040.6.camel@pc.vesuri.net>
	 <1110796090.8158.56.camel@pegasus>
	 <200503141344.03345.florian-evers@gmx.de> <1110826222.629.29.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1110829352.3386.1.camel@pc.vesuri.net>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 14 Mar 2005 21:42:32 +0200

On Mon, 2005-03-14 at 19:50 +0100, Marcel Holtmann wrote:
> I just checked the source code again and actually I forgot to remove an
> #ifdef when I made the 2.6.11-mh1 patch. Got into hidp/core.c and remov=
e
> the "#ifdef 0" and its "#endif" in hidp_add_connection().

That fixed the problem. Thanks. (BTW it's #if 0 in case someone tries to
find it by searching for #ifdef)

Regards,

-Vesa
--=20
            =B7 Vesa Halttunen - http://www.jormas.com/~vesuri/ =B7



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
