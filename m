Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Fwd: alsa bluetooth module
From: Fredrik Tolf <fredrik@dolda2000.com>
To: bluez-devel@lists.sourceforge.net
Cc: Antonio-Blasco Bonito <blasco.bonito@email.it>
In-Reply-To: <e36f1e61ac13a554d52d2f7b8d7a5df4@freezone.co.uk>
References: <e36f1e61ac13a554d52d2f7b8d7a5df4@freezone.co.uk>
Content-Type: text/plain
Message-Id: <1111098892.19889.88.camel@pc7.dolda2000.com>
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
Date: Thu, 17 Mar 2005 23:34:52 +0100

On Thu, 2005-03-17 at 14:05 -0800, ms419@freezone.co.uk wrote:
> Begin forwarded message:
> 
> > From: Antonio-Blasco Bonito <blasco.bonito@email.it>
> > Date: March 17, 2005 4:02:35 AM PST
> > To: ms419@freezone.co.uk
> > Subject: Re: alsa bluetooth module
[...]
> > I get:
> > # modprobe snd-bt-sco
> > FATAL: Error inserting snd_bt_sco 
> > (/lib/modules/2.6.8-2-686/extra/snd-bt-sco.ko): Unknown symbol in 
> > module, or unknown parameter (see dmesg)
> >
> > # dmesg|tail
> > ...
> > snd_bt_sco: no version for "struct_module" found: kernel tainted.
> > snd_bt_sco: Unknown symbol kcalloc

Well, I'm not sure (especially since I don't use Debian and thus have no
idea how they compile their kernels), but I would guess that this is a
matter of symbol versioning. Is this module compiled against the same
kernel (and with the same compilation options) that Blasco is using?

Try to check the output of `grep kcalloc /proc/kallsyms' and compare
that to the output of `nm /path/to/snd-bt-sco.ko | grep kcalloc'.

> > I looked in alsa sources in the kernel and I only found 
> > "snd_magic_kcalloc"
> > Maybe kcalloc calls should be renamed as such?

By no means. kcalloc() is a core kernel function, defined in mm/slab.c.
It's not an ALSA-specific routine.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
