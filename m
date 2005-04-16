Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Using ASCII based files for link key storage
References: <1113668583.16433.76.camel@pegasus> <200504161932.39416.bluez-devel@schaettgen.de> <1113678271.16433.85.camel@pegasus>
In-Reply-To: <1113678271.16433.85.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504162321.54562.bluez-devel@schaettgen.de>
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
Date: Sat, 16 Apr 2005 23:21:53 +0200

On Saturday, 16. April 2005 21:04, Marcel Holtmann wrote:
> > > And second, The format of the link key file will be very simple:
> > >
> > > 	<bdaddr> <hex-linkkey> <type>
> >
> > This means that we will still be unable to list the devices for which a
> > link key exists without root privileges, is this correct? If yes, is this
> > intentional?
>
> there is no other way, because we must store the link keys as secure as
> possible.

Sure, but my question wasn't about the link keys themselves. Why not allow 
regular users to find out if there is a link key for a given device at all, 
without being able to see the link key itself? I don't know if knowing about 
the existance of a link key might be sensitive information, too. But at the 
moment I don't see any problem with it.  Bluez could create one file per 
device for instance, with the bdaddr as its name and the rest in it contents.

This would still leave the type and time .. oh.. it's gone.. ok, it would 
leave only the type unreadable for unprivileged users. But everybody could 
take a look into the /var/lib/bluetooth/<local-bdaddr>/ dir to find out if 
bluez might be paired with a given device or not.
But again, I don't really need this feature. I'm just throwing some thoughts 
in the ring.  

> > Anyway, I for myself don't care much about where the data goes, as long
> > as the location and the file formats stay stable, because the link key
> > manager of kdebluetooth has to be changed each time.
>
> In the long term I like to make the place totally configurable, but for
> now I think going with /var/lib/bluetooth and ASCII based files is a
> good think.

Make the paths configurable? In hcid.conf? Why would someone want *that*? 
Isn't it a good thing that we can depend on the bluez files staying at a well 
known place? If a weird distribution chooses to place the files in a 
completely different directory, then some build time options should be 
sufficient for them. Ah, ok, maybe that's just what you meant.

Fred

-- 
Fred Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
