Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <447696EC.4080804@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] LInux Bluetooth and Audio (OSS) interface
References: <c4cf8c660605252058n622d6dfak5ad964349551d662@mail.gmail.com>
In-Reply-To: <c4cf8c660605252058n622d6dfak5ad964349551d662@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Thu, 25 May 2006 23:49:32 -0600

Timmy

Maybe you could rewrite btsco.c (the userspace daemon) so it only uses
oss interfaces to the kernel. Hmm... the hooks may not all be there
however. If it could be done, the kernel mod wouldn't really have to
change since you can use alsa-oss-emulation.

There are a lot of directions we could take this. Pure oss isn't one of
the most promising.

I think an interesting option is gstreamer drivers entirely in
userspace. That should embed more easily which is one big strike against
alsa. gst events might cover the complexity we have now in interacting
with a daemon.

Brad

>    I am a newbie to bluetooth. It seems that there are no integration
> on linux bluetooth (SCO link) and audio (OSS) interface, so that there
> are no standard API for the user mode audio applications when using or
> not using bluetooth handset.
>   Bluetooth-alsa seems to be something like that, but it focuses on
> Bluetooth + ALSA, I am not sure whether it is a good starting point.
> 
>   Can anyone give me some advice on how to provide an uniform
> interface for user mode audio applications ? Since it could be
> paintful for user mode audio applications to use SCO socket interface
> directly and handle the details for bluetooth handset.
> 
>   Thanks,
> 
> Timmy
> 
> 
> -------------------------------------------------------
> All the advantages of Linux Managed Hosting--Without the Cost and Risk!
> Fully trained technicians. The highest number of Red Hat certifications in
> the hosting industry. Fanatical Support. Click to learn more
> http://sel.as-us.falkag.net/sel?cmd=k&kid7521&bid$8729&dat1642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
