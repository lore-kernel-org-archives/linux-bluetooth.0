Return-Path: <cyrus@holtmann.org>
Message-ID: <47BB3B76.6000302@suse.de>
Date: Tue, 19 Feb 2008 21:26:30 +0100
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <47B96FE9.90900@wurmsdobler.org>
In-Reply-To: <47B96FE9.90900@wurmsdobler.org>
Subject: Re: [Bluez-users] Connecting to a two-way headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Peter Wurmsdobler schrieb:
> Hello,
> =

>  >> I was prompted by a graphical (rather than command-line) prompt
>  >> (seemingly from the applet) saying "Pairing request for device:
>  >> HBH-PV702 (00:1C:A4:20:CE:BE) Enter passkey for authentication:"
> How is this "BlueTooth Applet" actually triggered such that it prompts =

> the user? What does it do (what code should I look in to understand)? =

> How would I replace what the Applet does by something else in an =

> embedded application, i.e. without gnome and kde?

I'll try to provide a little piece of the big picture here. Beware: i am not
an expert on the matter and it might not be totally accurate, but it should=
 be
mostly correct.

The applet is acting as a "passkey-agent". To do this, it registers itself =
as
one at the hcid (via DBus).
If hcid now detects that it needs a passkey, it asks the registered passkey
agent for the passkey (via a DBus signal), the passkey-agent then asks the
user and provides the passkey to hcid (again via DBus).
hcid then uses the passkey to generate a link key, which is stored on the d=
isk
and later used for subsequent connections to the same device.
If there is no passkey agent registered at the time the passkey is needed,
access is denied.

Question that popped up, but that i can't answer offhand:
- can there be more than one passkey agent at a time? (not sure, but why no=
t?)
- where can i find a sample implementation? (answer: in passkey-agent.c)

> It is perhaps difficult not only for me to accept working bluez =

> components without understanding the underlying mechanisms.

This is why it is a good idea to put the "Big Picture Document" together :-)

Thanks,
-- =

Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
