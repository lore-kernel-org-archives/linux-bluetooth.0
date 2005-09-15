Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43297D56.70908@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] multiple btsco istance
References: <43293D53.4060200@cefriel.it>
In-Reply-To: <43293D53.4060200@cefriel.it>
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
Date: Thu, 15 Sep 2005 07:55:34 -0600

Luca,

It's in our todo list but there is still a significant amount of work to 
do it...

With two dongles, we would need btsco the daemon to accept a 
command-line parameter for the adapter to bind to.

With one dongle, we need to load the sco kernel mod with a parameter 
that tweaks one of the sco settings. This is from memory and it's a bit 
fuzzy.

Either way, we then need to make multiple alsa devices available using 
btsco the kernel mod and work out a way to communicate with the 
corresponding daemon.

Brad

Luca Pizzamiglio wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi to all.
> 
> I want to establish a SCO connection with btsco with two another device
> (two headset). I need two bluetooth dongle?
> At the moment, when I launch two istance of btsco, only the last works.
> 
> Using two dongles, hci0 and hci1, how to tell to btsco what interface to
> use?
> 
> Is it possible modify btsco to work with two device or it need kernel
> changes (snd-bt-sco)? I'm studying source code, but I don't clearly
> understand the use of bind syscall before the connect.
> 
> Thanks in advance!
> 
> Cheers,
> Pizza
> 
> - -------------------------------------------
> Luca Pizzamiglio
> CEFRIEL - Embedded Systems Design Unit
> Via Fucini, 2 - 20133 MILANO (ITALY)
> Phone:		+39 02 23954 343
> e-mail:		pizzamiglio@cefriel.it
> ICQ:		5046978
> - -------------------------------------------
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.7 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
> 
> iD8DBQFDKT1TAoUy56ORfbERAi89AKCUk8RcsMH+m7YbLTkrBDWz0cuRLACfegFG
> qQsBznGWBAHCAbWbqrHOJ/E=
> =UHaC
> -----END PGP SIGNATURE-----
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server. 
> Download it for free - -and be entered to win a 42" plasma tv or your very
> own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
