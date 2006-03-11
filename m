Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <44121F70.6050503@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco.ko and ACPI suspend
References: <4411710D.5000509@suse.de> <1141995491.32726.78.camel@pmac.infradead.org>
In-Reply-To: <1141995491.32726.78.camel@pmac.infradead.org>
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
Date: Fri, 10 Mar 2006 17:53:04 -0700

David

>>currently snd-bt-sco.ko is breaking ACPI suspend. So can we please apply
>>a minor patch like the following to CVS and fix this? Thanks.
> 
> If it had been merged into Linus' kernel tree, that would have happened
> already long ago. Why hasn't it been merged?

I patched cvs.

I believe it would take more work to get it to the stage that it would
be acceptable for inclusion. Probably as much effort as just moving it
entirely to userspace, where it (arguably) belongs.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
