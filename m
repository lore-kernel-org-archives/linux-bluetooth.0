Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 24 Apr 2007 20:48:26 +0200
From: Marc Haber <mh+bluez-devel@zugschlus.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070424184826.GD6853@torres.zugschlus.de>
References: <20070415095728.GA6212@ifup.org>
Mime-Version: 1.0
In-Reply-To: <20070415095728.GA6212@ifup.org>
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

On Sun, Apr 15, 2007 at 02:57:29AM -0700, Brandon Philips wrote:
> I am running 2.6.21-rc6 with sco-flowcontrol-v4.2.diff applied and I am
> getting the following error when trying to use my Platronics 640
> headset.  The computer is a Thinkpad x60s running Debian unstable.

I have exactly the same issue on a hp notebook, also running Debian
unstable. I exported current CVS HEAD, applied the Debian .diff and
built a local package, and I still have the same problem. Only that
the "Unable to set number of SCO buffers" error message now has
pcm_sco.c:277 as line number.

Any more hints?

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 3221 2323190

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
