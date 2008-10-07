Return-Path: <cyrus@holtmann.org>
Date: Tue, 07 Oct 2008 11:43:54 +0400
From: John Frankish <frankish@dubai.oilfield.slb.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-id: <0K8C00FQXYTBUG70@ae0043mbx01.mail.slb.com>
MIME-version: 1.0
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

At 19:10 05-10-08, you wrote:
>Hi John,
>
>On Oct 5, 2008, at 16:19, John Frankish wrote:
> > $ simple-agent hci0 00:1E:45:8B:2A:33
> > Traceback (most recent call last):
> >   File "/usr/local/bin/simple-agent", line 3, in <module>
> >     import gobject
> > ImportError: No module named gobject
> >
> > I guess this means that either bluez-4.11 should be compiled against
> > python, or (more likely) I need some kind of python glib module?
>
>That means that you're missing the glib bindings for python.
>Additionally you'll also need the D-Bus python bindings to use the
>script.
>
>Johan
>
>------------
Hi Johan,

The dbus-python bindings don't seem too big a deal, but as per google 
there seem to be plenty of issues with the python-glib bindings. Is 
there a particular site/tarball you could recommend that is known to 
work with the bluez scripts like simple-agent?

Thanks
John


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
