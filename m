Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Message-Id: <e36f1e61ac13a554d52d2f7b8d7a5df4@freezone.co.uk>
Cc: Antonio-Blasco Bonito <blasco.bonito@email.it>
From: ms419@freezone.co.uk
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Fwd: alsa bluetooth module
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
Date: Thu, 17 Mar 2005 14:05:17 -0800

I maintain a Debian package of bluetooth-alsa - for my convenience -=20
but bluetooth-alsa is so popular, some others use this package also -=20
http://cgi.sfu.ca/~jdbates/moin/moin.cgi/Bluetooth&ALSA

Blasco contacted me with this problem, but truth is - I haven't got=20
bluetooth-alsa working myself. Perhaps someone else can be more helpful=20=

to him?

Many thanks!

Jack

Begin forwarded message:

> From: Antonio-Blasco Bonito <blasco.bonito@email.it>
> Date: March 17, 2005 4:02:35 AM PST
> To: ms419@freezone.co.uk
> Subject: Re: alsa bluetooth module

[...]

> I get:
> # modprobe snd-bt-sco
> FATAL: Error inserting snd_bt_sco=20
> (/lib/modules/2.6.8-2-686/extra/snd-bt-sco.ko): Unknown symbol in=20
> module, or unknown parameter (see dmesg)
>
> # dmesg|tail
> ...
> snd_bt_sco: no version for "struct_module" found: kernel tainted.
> snd_bt_sco: Unknown symbol kcalloc
>
> I looked in alsa sources in the kernel and I only found=20
> "snd_magic_kcalloc"
> Maybe kcalloc calls should be renamed as such?
>
> Cheers,
>             Blasco
> --
> Email.it, the professional e-mail, gratis per te: =
http://www.email.it/f
> Sponsor:
> Bisogno di liquidit=E0? Non devi spiegare per cosa. Fino a 4.000 =80 a=20=

> casa tua
> Clicca qui: http://adv.email.it/cgi-bin/foclick.cgi?mid=3D2291&d=3D17-3
>
>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
