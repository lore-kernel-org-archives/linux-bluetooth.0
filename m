Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <001901c4dcfb$d2909810$6401000a@zool>
From: "Steffen Larsen" <zool@zool.dk>
To: <bluez-devel@lists.sourceforge.net>
References: <00a001c4cee6$5271b4c0$0000fea9@zool> <1100958396.7213.126.camel@pegasus>  <00f101c4dca6$93973a60$6401000a@zool> <1102478767.8447.65.camel@pegasus>
Subject: Re: [Bluez-devel] updating the PSM in SDP..
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Wed, 8 Dec 2004 08:59:19 +0100

> Hi Steffen,
>
> > > The library contains a sdp_record_update() function, but I never tried
> > > it so far.
> >
> > hmmm.. I tried this sdp_record_update() function, but I can't make it
work.
> > Anyone in here, who have tried it, where it actually worked?
>
> then send me a patch for the library that makes it working.

Surely I will.. But I have to have some spare time at first. :-)

> > Well the deletion and adding a new record of cause works fine, but it
could
> > be nicer to have a update function instead. ;-)
>
> As I said, maybe changing a PSM and keeping the record is not a good
> idea. If you change the PSM then the service is also changed, right?

Yes yes for sure.. But I wanted to change the attribute that contained the
PSM integer value, through the update function.

/Steffen



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
