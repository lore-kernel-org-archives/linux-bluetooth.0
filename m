Return-Path: <cyrus@holtmann.org>
Message-ID: <48CCC7CE.2000400@free.fr>
Date: Sun, 14 Sep 2008 10:14:06 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <48CBE24E.6080507@free.fr> <48CC2789.6010203@free.fr>
	<1221339462.6695.62.camel@californication>
In-Reply-To: <1221339462.6695.62.camel@californication>
Subject: Re: [Bluez-devel] Some Audio error handling fixes.
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

Hi Marcel,

> Hi Fabien,
> 
>> Updated patchset attached !
> 
> does connection_lost() handles a positive error message properly?

Yes. This is the change line 30 of the patch.
Only thing connection_lost does is call finalize_discovery().

> 
>> Luiz: I tried to find some doc to get started on gitorious but didn't 
>> found any... how to i create my remote clone ?
> 
> I would prefer having a tree to pull from, because that makes my life a
> lot easier.

I'm on it... :-)

Regards,

Fabien

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
