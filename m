Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 25 Apr 2007 09:56:03 +0400
From: John Frankish <frankish@dubai.oilfield.slb.com>
In-reply-to: <462E0A15.1070707@xmission.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-id: <7.0.1.0.2.20070425095009.03d963a8@dubai.oilfield.slb.com>
MIME-version: 1.0
References: <7.0.1.0.2.20070422102711.03d6a030@dubai.oilfield.slb.com>
	<462B9264.7030604@xmission.com>
	<7.0.1.0.2.20070423075933.03d4a650@dubai.oilfield.slb.com>
	<462E0A15.1070707@xmission.com>
Subject: Re: [Bluez-devel] Unable to set number of SCO buffers : please
 upgrade your Kernel !
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Brad,

Whilst it's reasonably difficult to move to a newer kernel in DSL-N, 
the main reason for making plugz work on this kernel is that I can 
then make it available as a DSL-N extension for many others to use.

I tried the diff2 patch on my kernel - it ran with about 5 failures, 
4 of which I added manually. After reboot, I had the same SCO buffers 
error message. I wonder - does plugz need a certain version revision 
of bluez-utils or will it work with any version? I am using 
bluez-utils 2.15 as I cannot make the "pin" part of things work on 
DSL-N with later versions.

Where would Fabien have put the earlier SCO patch?

Thanks
John

At 17:45 24-04-07, you wrote:
>John
>
> > The earliest patch in the cvs is v2.0 for 2.6.18-mh7 - given that I
> > have 2.6.12 (DSL-N is like Knoppix, you cannot easily update the
> > kernel), is there a patch archive somewhere with a patch closer to my
> > kernel or do I need to try and apply the patch "manually"?
>
>Fabien may have submitted an early patch that is closer to your kernel
>but rather than backport or dig in the archives I suggest you consider
>trying a newer kernel.
>
>Brad
>
>-------------------------------------------------------------------------
>This SF.net email is sponsored by DB2 Express
>Download DB2 Express C - the FREE version of DB2 express and take
>control of your XML. No limits. Just data. Click to get it now.
>http://sourceforge.net/powerbar/db2/
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
