Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] BNEP kernel oops
From: Marcel Holtmann <marcel@holtmann.org>
To: "Williams, Richard" <Richard.Williams@VITRONICS.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <A1F0D47583A2D711919F00600819B3A45BDCD4@goofy.vitronics.com>
References: <A1F0D47583A2D711919F00600819B3A45BDCD4@goofy.vitronics.com>
Content-Type: text/plain
Message-Id: <1092426641.4501.39.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 13 Aug 2004 21:50:41 +0200

Hi Richard,

> The single board computer I'm using comes from Applied Data Systems (ADS)- its called a 
> BitsyX. I get my kernel from kernel.org and patches from ADS, and use their 
> patches. From the instructions on  ADS web site: (http://www.applieddata.net/support/)
> 
> 
> <<<<<<<<<<<<<<<<<<<<<<<<
> Kernel source and patches
> 
> linux-2.4.26.tar.bz2 (~30MB)
> Download from the link above or from kernel.org and make a base directory.
> 
> bzcat < linux-2.4.26.tar.bz2 | tar -xf -
> 
> 
> patch-2.4.26-vrs1.gz (~595kB)
> Download from the link above or from arm.linux.org.uk.
> Change to the linux directory and apply the patch using patch level "-p1".
> 
> cd linux-2.4.26
> zcat patch-2.4.26-vrs1.gz | patch -p1
> 
> 
> linux-2.4.26-vrs1-pxa1.patch.gz (~250kB)
> Download from the link above or (uncompressed) from Robert Schwebel.
> Remain in the linux directory and apply the patch using patch level "-p1".
> 
> zcat linux-2.4.26-vrs1-pxa1.patch.gz | patch -p1
> 
> 
> diff-2.4.26-vrs1-pxa1-adsx2.gz (~220kB)
> Download from the link above and apply the patch using patch level "-p1".
> 
> zcat diff-2.4.26-vrs1-pxa1-adsx2.gz | patch -p1
> 
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> 
> 
> The two patch files and the diff file will show the differences between
> plain vanilla 2.4.26 and my embedded ARM kernel.

they are touching to many files as I can tell you where the problem can
be. Please make sure that a 2.4.26 is working fine for you on a desktop
machine and ask ADS for help. If a plain vanilla is working, then they
broke something with their patches.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
