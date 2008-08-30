Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <e96e9eeb0808300018m19b922a4i4060960b0ab91fb3@mail.gmail.com>
References: <e96e9eeb0808300018m19b922a4i4060960b0ab91fb3@mail.gmail.com>
Date: Sat, 30 Aug 2008 11:25:09 +0200
Message-Id: <1220088309.7145.46.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-users] no one here uses OPP/FTP ?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Voni,

> do you use OPP or FTP profiles using Bluez ?
> 
> Can you please tell how ? which package do you use ?
> 
> I'm looking for simple, command line, ftp/opp profiles, client and
> server, for embedded system...

all of them are based on OpenOBEX and it includes demo clients by
itself. Also obexd and obex-data-server might be a good choice for you.
Especially the obexd will be interesting since it is heavily developed
at the moment and besides Bluetooth, it should also support USB OBEX
gadgets at some point in the future. I give obexd my blessing for a
server on embedded systems. It also suppose to be part of the next Maemo
development platform.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
