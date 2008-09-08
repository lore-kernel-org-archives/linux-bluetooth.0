Return-Path: <cyrus@holtmann.org>
Message-Id: <8C34E2DC-FBBF-4AE4-9231-171ADE396A3E@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <48C58092.7060103@free.fr>
Mime-Version: 1.0 (Apple Message framework v926)
Date: Mon, 8 Sep 2008 22:59:49 +0300
References: <48C58092.7060103@free.fr>
Subject: Re: [Bluez-devel] Crash bug in bluez-4.4
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Fabien,

On Sep 8, 2008, at 22:44, Fabien Chevalier wrote:
> Path attached fixes the bug... by removing three lines of code that  
> seem to me not only a premature, but also bogus optimization :-(,  
> that prevent us to trying to return the first element of an empty  
> gslist.
>
> However i'm not that familiar with that manager stuff and might be  
> wrong, so please double check that ;-)

Good catch, and the patch looks good too. Another alternative would  
have been to change the return line to
return devices ? devices->data : NULL;
but you're right in that it's just an unnecessary optimization. The  
fix is now in the kernel.org git.

Johan

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
