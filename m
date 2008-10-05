Return-Path: <cyrus@holtmann.org>
Message-Id: <0AF54F7F-8AEB-409F-BB0F-47B772A16099@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <0K8900APARTING30@ae0043mbx01.mail.slb.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Date: Sun, 5 Oct 2008 17:10:15 +0200
References: <0K89001SP271DK10@ae0043mbx01.mail.slb.com>
	<0K8900APARTING30@ae0043mbx01.mail.slb.com>
Subject: Re: [Bluez-devel] Simple pairing script instead of bluez-gnome
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi John,

On Oct 5, 2008, at 16:19, John Frankish wrote:
> $ simple-agent hci0 00:1E:45:8B:2A:33
> Traceback (most recent call last):
>   File "/usr/local/bin/simple-agent", line 3, in <module>
>     import gobject
> ImportError: No module named gobject
>
> I guess this means that either bluez-4.11 should be compiled against
> python, or (more likely) I need some kind of python glib module?

That means that you're missing the glib bindings for python.  
Additionally you'll also need the D-Bus python bindings to use the  
script.

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
