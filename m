Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <44771111.60404@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] LInux Bluetooth and Audio (OSS) interface
References: <c4cf8c660605252058n622d6dfak5ad964349551d662@mail.gmail.com>	 <447696EC.4080804@xmission.com> <fe0a97c20605252311k20a25dffyfb37603a5d322d6f@mail.gmail.com>
In-Reply-To: <fe0a97c20605252311k20a25dffyfb37603a5d322d6f@mail.gmail.com>
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
Date: Fri, 26 May 2006 08:30:41 -0600

Sowmya

Are you suggesting we wouldn't need the kernel mod at all?

The only way to avoid the kernel mod for an oss client is to do a
shared-object interceptor hack like libaoss that catches
read/write/ioctl to /dev/dsp and processes it in some other way.

Brad

> But Brad.... incase we write the OSS Api dependency in btsco we need not
> have to upgrade the kernel to have kernel with inbuilt ALSA drivers.....
> I feel this is the advantage we are filling up with SCO amd OSS appln
> incase if we have to.... isn't it??
> 
> On 5/26/06, *Brad Midgley* <bmidgley@xmission.com
> <mailto:bmidgley@xmission.com>> wrote:
> 
>     Timmy
> 
>     Maybe you could rewrite btsco.c (the userspace daemon) so it only uses
>     oss interfaces to the kernel. Hmm... the hooks may not all be there
>     however. If it could be done, the kernel mod wouldn't really have to
>     change since you can use alsa-oss-emulation.


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
