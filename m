Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] patch for d-bus support in hcid
From: Philip Blundell <pb@nexus.co.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1062710287.32473.12.camel@hades.cambridge.redhat.com>
References: <1056040950.3518.18.camel@mill.nexus.co.uk>
	<1062710287.32473.12.camel@hades.cambridge.redhat.com>
Message-Id: <1062714838.801.41.camel@kc.cam.armlinux.org>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 04 Sep 2003 23:33:58 +0100
Content-Type: text/plain

On Thu, 2003-09-04 at 22:18, David Woodhouse wrote:
> On Thu, 2003-06-19 at 17:42 +0100, Philip Blundell wrote:
>  -  | K_PINHELP  PATH    {
>  +  | K_PINHELP  WORD    {
> 
> It also removes support for actually configuring a pin helper as before.
> Reverting the above removes support for the magic '*dbus' value. 

Hm, right.  I was under the impression that WORD was a superset of PATH,
but looking at the code again it seems I was mistaken about that.  

Making the lexer more permissive about what characters can go in a PATH
would probably clear it up, and might not be a bad thing to do on
general principle, but the "*dbus" thing was always a bit of a crock
anyway.  I've modified the patch to use a completely different keyword,
so you now replace the whole pin_helper ... line with a
"dbus_pin_helper" statement.  That should remove any chance of ambiguity
and avoid altering the behaviour of existing config files.

> I suspect we should just be using a script wrapper around 
> dbus-send, or a simple external program, rather than putting support for
> dbus directly into hcid.

For PIN entry that would be a reasonable solution, but there are other
ways in which I think it would be useful for hcid to support D-BUS
directly; for example, manipulating the list of paired devices and
turning discoverability on and off.

I don't think it should be hard to arrange for hcid to tolerate failure
to connect to dbus a little better.  Try
http://handhelds.org/~pb/bluez-dbus-20030904.diff.gz and see if you get
on any better with that one.

p.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
