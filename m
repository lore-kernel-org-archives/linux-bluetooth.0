Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PIN for Microsoft Mouse
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <6D4DC8B4AD16D6118E8200D0B76FE2621033CFD8@ont06exm01.comm.mot.com>
References: 
	 <6D4DC8B4AD16D6118E8200D0B76FE2621033CFD8@ont06exm01.comm.mot.com>
Content-Type: text/plain
Message-Id: <1112869698.9047.61.camel@pegasus>
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
Date: Thu, 07 Apr 2005 12:28:18 +0200

Hi Victor,

> I have Microsoft Wireless desktop  (mouse + kbd). Gentoo distro and
> 2.6.11.6 kernel.
>  
> I have no problem connecting both when pin/authentication/encryption
> are turned off, (hidd --connect <btaddr>) however, no link key is ever
> created and therefore connections must be recreated EACH time i reboot
> computer. Not to mention that some devices, such as cellphones, will
> not work in this mode at all, since they MUST use authentication.
>  
> In authenticated mode, I have no problems connecting the keyboard.
> Link key is nicely created and from there on, kbd works as expected,
> even after reboots and long periods of inactivity. But the mouse, how
> do I connect it, if there is no pin for it? I looked for stickers on
> the bottom of mouse, also tried 000, 0000, etc. with no luck. Also,
> how am I supposed to enter it with mouse buttons? I imagine it's gotta
> be a hard-wired pin of some sort. 

what does "hciconfig -a" shows on your system?

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
