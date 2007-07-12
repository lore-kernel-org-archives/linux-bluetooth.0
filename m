Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: "Niels v/d Spek" <gmaneBluez@lumensoft.nl>
Date: Thu, 12 Jul 2007 06:58:56 +0200
Message-ID: <f74cej$323$1@sea.gmane.org>
References: <1184178600.6062.27.camel@Epimenides>
	<d89ddf300707111302n15fa8e01u65697135b8ab03fc@mail.gmail.com>
Subject: Re: [Bluez-devel] Handling simultaneous SCO connections: Does
	BlueZhave multiple SCO buffers?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Brad Midgley wrote:
> George
>
> bluetooth adapters that are connected by usb need to have a kernel mod
> to allow the alternate setting to be changed dynamically. There's an
> experimental patch out there:
>
> http://article.gmane.org/gmane.linux.bluez.devel/11999
>
> the patch also assumes you have the flowcontrol patch applied first:
>
> http://bluetooth-alsa.cvs.sourceforge.net/bluetooth-alsa/plugz/patches/sco-flowcontrol-v4.2.diff?view=log
>
Brad,

I'm using Ubuntu 7.4 and like to know of this patches are there also needed?

thanks anyway

Niels
> Brad
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/ 




-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
