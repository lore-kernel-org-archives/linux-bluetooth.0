Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Using ASCII based files for link key storage
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1113676428.16433.80.camel@pegasus>
References: <1113668583.16433.76.camel@pegasus>
	 <200504161932.39416.bluez-devel@schaettgen.de>
	 <200504162001.57955.bluez-devel@schaettgen.de>
	 <1113676428.16433.80.camel@pegasus>
Content-Type: text/plain
Message-Id: <1113824107.16233.93.camel@pegasus>
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
Date: Mon, 18 Apr 2005 13:35:07 +0200

Hi Fred,

> > > > So first the new place for runtime things like link keys, names etc. I
> > > > decided to use "/var/cache/bluetooth/<bdaddr>/" as the base directory
> > > > and then use the file "linkkeys" for the actual link keys. And we will
> > > > use "names" for the device name cache. The "bdaddr" is the address of
> > > > the local adapter.
> > >
> > > According to the file hierarchy standard, /var/cache is for files which
> > > "can be deleted without data loss". For cached device names it's probably
> > > fine. They can't be recomputed if a device isn't in reach, but if it is,
> > > the device name can be fetched again automatically. But I'm not if this
> > > should include link keys. They can't be regenerated automatically without
> > > bothering the user. Deleting them might even break at setup, where the peer
> > > device isn't reachable easiliy after initial setup. Maybe /var/lib..? I'm
> > > not really an expert in this area.
> > 
> > After thinking about it a little longer, I would even put the device name 
> > cache under /var/lib/bluetooth. /var/cache is intended for files with the 
> > purpose to reduce the load on any kind of resource, be it cpu, memory or 
> > network. But that's not why bluez is caching device names. It's because we 
> > want a reliable offline lookup capability. Caches should be completely 
> > transparent, but this wouldn't be the case here. If the cache is gone, then 
> > applications could not display a user friendly name, no matter how hard they 
> > try. It's the same difference as the difference between a browser cache and a 
> > proxy for offline browsing.
> 
> I am fine with it to put it under the /var/lib/bluetooth/ directory. The
> code in the CVS has been changed now.

actually I have everything working like it should be. The code for
dealing with the ASCII files is not the best, but it seems to work fine
for this case. So does everybody agree to store all Bluetooth related
files under /var/lib/bluetooth/ or should we put them somewhere else. It
would be great if people comment on this and test the code, because I
wanna release it as bluez-libs-2.16 and bluez-utils-2.16.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
