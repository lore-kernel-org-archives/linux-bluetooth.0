Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] adding a sdp service with a 128bit uuid
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1110096690.11503.2.camel@newer.loc>
References: <42291076.5040109@gmx.ch> <1110021688.8058.108.camel@pegasus>
	 <4229B30E.8080803@gmx.ch>  <1110029911.8168.5.camel@pegasus>
	 <1110096690.11503.2.camel@newer.loc>
Content-Type: text/plain
Message-Id: <1110107963.8302.4.camel@pegasus>
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
Date: Sun, 06 Mar 2005 12:19:23 +0100

Hi Taneli,

> > > >>how to browse the local sdp services?
> > > >>[sdptool browse dev] seems to be only for remote devices. I now always did 
> > > >>it from another device to see the local seervices. how to [sdptool browse 
> > > >>localhost]?
> > > > 
> > > > 
> > > > sdptool browse local
> > > 
> > > nice :-)
> > > maybe something that should/could be mentioned in the manpage or in --help
> > 
> > feel free to send in a patch.
> 
> What do you think about this? It adds the "sdptool browse local" to the
> examples.

applied. Thanks.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
