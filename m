Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BlueZ GUI
From: David Woodhouse <dwmw2@infradead.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200505201554.12647.bluez-devel@schaettgen.de>
References: <BAY104-F31990E531BA06F8AF71435C1090@phx.gbl>
	 <200505201554.12647.bluez-devel@schaettgen.de>
Content-Type: text/plain
Message-Id: <1119086759.24842.42.camel@localhost.localdomain>
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
Date: Sat, 18 Jun 2005 10:25:58 +0100

On Fri, 2005-05-20 at 15:54 +0200, Fred Schaettgen wrote:
> I guess he's talking about a GUI to edit hcid.conf. At least kdebluetooth 
> doesn't include any tool to do that. It implements the client and server side 
> of a some Bluetooth profiles, but it doesn't deal with the configuration. 
> Except for the link key manager maybe. I don't really know the gnome 
> bluetooth tools, but I guess it's the same there. 

Only root can edit hcid.conf, and you shouldn't be using GUI
point-and-drool tools as root.

-- 
dwmw2



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
