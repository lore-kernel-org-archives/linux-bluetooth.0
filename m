Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <423A0656.3030409@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Cc: Antonio-Blasco Bonito <blasco.bonito@email.it>
Subject: Re: [Bluez-devel] Fwd: alsa bluetooth module
References: <e36f1e61ac13a554d52d2f7b8d7a5df4@freezone.co.uk>
In-Reply-To: <e36f1e61ac13a554d52d2f7b8d7a5df4@freezone.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Date: Thu, 17 Mar 2005 15:36:06 -0700

hi

I have never seen the kcalloc error. Kernel taint is a bad sign... can 
he reproduce it without loading anything that taints the kernel?

brad

ms419@freezone.co.uk wrote:
> I maintain a Debian package of bluetooth-alsa - for my convenience - but 
> bluetooth-alsa is so popular, some others use this package also - 
> http://cgi.sfu.ca/~jdbates/moin/moin.cgi/Bluetooth&ALSA
> 
> Blasco contacted me with this problem, but truth is - I haven't got 
> bluetooth-alsa working myself. Perhaps someone else can be more helpful 
> to him?
> 
> Many thanks!
> 
> Jack
> 
> Begin forwarded message:
> 
>> From: Antonio-Blasco Bonito <blasco.bonito@email.it>
>> Date: March 17, 2005 4:02:35 AM PST
>> To: ms419@freezone.co.uk
>> Subject: Re: alsa bluetooth module
> 
> 
> [...]
> 
>> I get:
>> # modprobe snd-bt-sco
>> FATAL: Error inserting snd_bt_sco 
>> (/lib/modules/2.6.8-2-686/extra/snd-bt-sco.ko): Unknown symbol in 
>> module, or unknown parameter (see dmesg)
>>
>> # dmesg|tail
>> ...
>> snd_bt_sco: no version for "struct_module" found: kernel tainted.
>> snd_bt_sco: Unknown symbol kcalloc
>>
>> I looked in alsa sources in the kernel and I only found 
>> "snd_magic_kcalloc"
>> Maybe kcalloc calls should be renamed as such?
>>
>> Cheers,
>>             Blasco
>> -- 
>> Email.it, the professional e-mail, gratis per te: http://www.email.it/f
>> Sponsor:
>> Bisogno di liquidità? Non devi spiegare per cosa. Fino a 4.000 € a 
>> casa tua
>> Clicca qui: http://adv.email.it/cgi-bin/foclick.cgi?mid=2291&d=17-3
>>
>>
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_ide95&alloc_id396&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-deve
> l


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
