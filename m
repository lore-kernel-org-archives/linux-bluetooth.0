Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Fwd: alsa bluetooth module
From: Fredrik Tolf <fredrik@dolda2000.com>
To: bluez-devel@lists.sourceforge.net
Cc: ms419@freezone.co.uk
In-Reply-To: <e36f1e61ac13a554d52d2f7b8d7a5df4@freezone.co.uk>
References: <e36f1e61ac13a554d52d2f7b8d7a5df4@freezone.co.uk>
Content-Type: text/plain
Message-Id: <1111099329.19889.91.camel@pc7.dolda2000.com>
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
Date: Thu, 17 Mar 2005 23:42:09 +0100

On Thu, 2005-03-17 at 14:05 -0800, ms419@freezone.co.uk wrote:
> I maintain a Debian package of bluetooth-alsa - for my convenience - 
> but bluetooth-alsa is so popular, some others use this package also - 
> http://cgi.sfu.ca/~jdbates/moin/moin.cgi/Bluetooth&ALSA
> 
> Blasco contacted me with this problem, but truth is - I haven't got 
> bluetooth-alsa working myself.

Regarding that -- I assume your problem is still getting snd-hwdep as a
module, as you stated on the website? I'm just wondering; can't you just
add one of those modules that require snd-hwdep and not care whether
it's actually being used later on? As long as it gets snd-hwdep built...

Fredrik Tolf




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
