Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <465A8875.9090801@access-company.com>
Date: Mon, 28 May 2007 09:44:53 +0200
From: Frederic Dalleau <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <20070526171539.GA16843@kobayashi-maru.wspse.de>
	<4658C395.6010908@jlab.org>
In-Reply-To: <4658C395.6010908@jlab.org>
Subject: Re: [Bluez-devel] bluetooth-audio and bug in a2dpd (Patch included)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Mathias,

Thanks for the patch,
I forgot that DBG was erasing errno, irk...

I integrated it in order to get a working solution but as you said, this =

is not a solution.

> With my patch it is: 4 seconds filling the buffer, waiting up to 500ms
> (spectrum analyzer in XMMS stops), 2-3 seconds filling the buffer
> (spectrum analyzer runs smoothly), waiting again for 500ms, and so on.

This behavior is strange, a2dpd calculate delays precisely ;) Can you =

send me on my private email a whole .a2dprc and logfile, done with =

enabledebug=3D255 in .a2dpdrc?

a2dpd > logfile
press play, wait something like 10 secs then press stop on xmms.
Don't wait too much as this is very verbose (+/- 10mb).

Thanks,
Fr=E9d=E9ric.



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
