Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Using ASCII based files for link key storage
References: <1113668583.16433.76.camel@pegasus>
In-Reply-To: <1113668583.16433.76.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504161932.39416.bluez-devel@schaettgen.de>
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
Date: Sat, 16 Apr 2005 19:32:38 +0200

On Saturday, 16. April 2005 18:23, Marcel Holtmann wrote:
> Hi Folks,
>
> currently the link keys are stored in a binary format and they are
> stored under the "/etc/bluetooth/" directory. Both things are not very
> handy and we should start doing something to change this.
>
> So first the new place for runtime things like link keys, names etc. I
> decided to use "/var/cache/bluetooth/<bdaddr>/" as the base directory
> and then use the file "linkkeys" for the actual link keys. And we will
> use "names" for the device name cache. The "bdaddr" is the address of
> the local adapter.

According to the file hierarchy standard, /var/cache is for files which "can 
be deleted without data loss". For cached device names it's probably fine. 
They can't be recomputed if a device isn't in reach, but if it is, the device 
name can be fetched again automatically. But I'm not if this should include 
link keys. They can't be regenerated automatically without bothering the 
user. Deleting them might even break at setup, where the peer device isn't 
reachable easiliy after initial setup. Maybe /var/lib..? I'm not really an 
expert in this area.

> And second, The format of the link key file will be very simple:
>
> 	<bdaddr> <hex-linkkey> <type>

This means that we will still be unable to list the devices for which a link 
key exists without root privileges, is this correct? If yes, is this 
intentional?
Anyway, I for myself don't care much about where the data goes, as long as the 
location and the file formats stay stable, because the link key manager of 
kdebluetooth has to be changed each time.

regards
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
