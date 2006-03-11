Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <441223BD.8000903@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco.ko and ACPI suspend
References: <4411710D.5000509@suse.de>
In-Reply-To: <4411710D.5000509@suse.de>
Content-Type: text/plain; charset=ISO-8859-15
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
Date: Fri, 10 Mar 2006 18:11:25 -0700

Stefan

doh. If we had been included then we wouldn't have to worry about the
older api for try_to_freeze. Can you give me a safer patch that will
work with 2.6.12 for example?

brad

> Signed-off-by: Stefan Scheler <sscheler@suse.de>
> 
> diff -ru btsco/kernel/btsco.c btsco/kernel/btsco.c
> --- btsco/kernel/btsco.c	2006-03-10 12:45:25.000000000 +0100
> +++ btsco/kernel/btsco.c	2006-03-10 12:52:15.000000000 +0100
> @@ -891,6 +891,11 @@
>  	up(&bt_sco->thread_sem);
>  
>  	do {
> +
> +#ifdef CONFIG_PM
> +		try_to_freeze();
> +#endif
> +
>  		if (signal_pending(current))
>  			flush_signals(current);
>  



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
