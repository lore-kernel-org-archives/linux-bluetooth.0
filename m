Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 6 Jun 2007 16:46:23 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070606144623.GE31613@suse.de>
References: <200706060847.21565.dennisveatch@bellsouth.net>
	<1181134253.13429.150.camel@violet>
	<200706061001.33464.dennisveatch@bellsouth.net>
MIME-Version: 1.0
In-Reply-To: <200706061001.33464.dennisveatch@bellsouth.net>
Subject: Re: [Bluez-devel] bluez-utils-3.11 and configure
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

On Wed, Jun 06, 2007 at 10:01:33AM -0400, Dennis Veatch wrote:

> Um, well ok. I'm not trying to piss anyone off here and my apologies for =

> asking about something that is totally contray to what I _EXPECTED_ to ha=
ppen =

> when running ./configure --enable-all, make and make install.
> =

> I was going to submit a patch for configure (at lease the --enable-all pa=
rt) =

> to really make all but I get the sense from your statement to just piss =

> off....... so I will.

These are basically examples and test applications that are just for that:
being an example or a test application, so they are not installed by defaul=
t.

On openSUSE i have some of them in the bluez-test package (apitest, as an
example, is sometimes useful, but you don't want it in the default install
since it drags in the python dependency).
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
