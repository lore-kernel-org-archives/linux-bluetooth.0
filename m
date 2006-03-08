Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Radek Rurarz <fotopiper@o2.pl>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] PIN helper
Message-Id: <20060308230109.202dc5ff.fotopiper@o2.pl>
In-Reply-To: <20060308214031.GZ4516@beta.private.mielke.cc>
References: <20060308221925.17d20407.fotopiper@o2.pl>
	<20060308214031.GZ4516@beta.private.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
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
Date: Wed, 8 Mar 2006 23:01:09 +0100

On Wed, 8 Mar 2006 16:40:32 -0500
Dave Mielke <dave@mielke.cc> wrote:


> May I use this opportunity to "readvertise" a script I tried to bring
> to your collective attention some months ago. It's attached to this
> post as "bluepin". It works in text mode, supports a file containing
> address/pin mappings, and uses the dialog utility to bring up a
> text-mode prompt on a spare virtual terminal for devices not listed
> in the file. Please give it some consideration. I'll be glad to
> enhance it as necessary regarding whatever features it's missing or
> could use in addition to what it already does. See the comments at
> the top of the script for more detail.=20

Some things I would like to have:
1. checking the permissions of the file

2. an option to chose wheather a promp should be used even if there is
no pin in the file, possibly to chose another pinhelper if there is no
pin (for instance the one for X, if that fails to create a promp).

3. In the pins file another 'slot' for the name of the device
(not nessesary the one advertised by it, rather to have an idea whot is
it)

No more ideas for now.

My regards.

--=20
Rados=B3aw Rurarz
Warsaw Poland
GG: 7249330


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
