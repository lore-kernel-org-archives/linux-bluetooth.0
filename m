Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1220904984.8005.8.camel@pancake.floe.gotdns.org>
References: <1220904984.8005.8.camel@pancake.floe.gotdns.org>
Date: Mon, 08 Sep 2008 21:38:48 +0100
Message-Id: <1220906328.24928.9.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Can't connect to Trust Bluetooth mouse..
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

On Mon, 2008-09-08 at 22:16 +0200, Florian Echtler wrote:
> Hello everyone,
> 
> I just bought a Trust Bluetooth Mouse 15351. However, I can't connect to
> it via bluez-gnome, nor via hcitool. Here's what hcidump shows when I
> try:
<snip>
> Unfortunately, I have to admit I can't really make sense out of this,
> except that it seems that the mouse terminates the connection after the
> "Remote Name Request" command.. I have bluez 3.36 installed.
> 
> Could anybody give me a hint?

In my experience with a similarly cheap Trust mouse, my advice is:
change the batteries to known working ones, check that they make contact
properly.

I'm lucky the one I bought was just a test mouse, not something I'd
really use...


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
