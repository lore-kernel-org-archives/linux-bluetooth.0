Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] D-Link DBT-120]
From: Gene Imes <gene@ozob.net>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1078495197.7338.1.camel@tr1a.ozob.net>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 05 Mar 2004 07:59:58 -0600

On Fri, 2004-03-05 at 05:52, Marcel Holtmann wrote:
> Hi Gene,
> 
> > Disregard my previous post. 2.6.4-rc1-mm2 has fixed this problem.
> 
> I had now the same problem with 2.6.4-rc2. Please try to find the patch
> from 2.6.4-rc1-mm2 that fixes your problem, because this needs to be
> send to Linus before he releases 2.6.4 (final).
> 
> Regards
> 
> Marcel


Marcel, I am not sure which patch fixes this but I was rebooting once
and pulled the DBT-120 out and got an oops or whatever. As much as I
could see looked like it may be the USB stuff.

There is only one USB patch from rc1-mm1 to rc1-mm2 the URL is:

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm2/broken-out/bk-usb.patch

I am not sure how to check the patch and see if it is the one. I hope
this helps.

Here is the URL for all of the patches:

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm2/


Thanks,

Gene



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
