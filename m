Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <423A0877.1080704@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Fwd: alsa bluetooth module
References: <e36f1e61ac13a554d52d2f7b8d7a5df4@freezone.co.uk>
In-Reply-To: <e36f1e61ac13a554d52d2f7b8d7a5df4@freezone.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 17 Mar 2005 15:45:11 -0700

hi

regarding the text on your page at 
http://cgi.sfu.ca/~jdbates/moin/moin.cgi/Bluetooth&ALSA

> A Bluetooth headset ALSA driver is apparently available - [WWW] http://www.dcs.gla.ac.uk/~jp/snd-bt-sco/
> 
> The bluetooth-alsa project is now on SourceForge - [WWW] http://bluetooth-alsa.sourceforge.net/ - I don't know its relationship to the old link. 

the sourceforge project supercedes the jp version.

> snd_bt_sco: Unknown symbol snd_hwdep_new

select emu10k1 support and the kernel will pull in snd_hwdep_new. i 
think the alsa folks are trying to deprecate snd_hwdep_new but i haven't 
looked into what replaces it...

brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
