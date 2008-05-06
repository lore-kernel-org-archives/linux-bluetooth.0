Return-Path: <cyrus@holtmann.org>
Message-ID: <4820230F.2060306@suse.de>
Date: Tue, 06 May 2008 11:21:19 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <1210038664.15029.20.camel@violet.holtmann.net>
In-Reply-To: <1210038664.15029.20.camel@violet.holtmann.net>
Subject: Re: [Bluez-devel] [BlueZ-Announce] Release of bluez-libs-3.31 and
	bluez-utils-3.31
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

Marcel Holtmann wrote:
> Hi Folks,
> =

> this is an update release of the new stable versions of the Bluetooth
> library and the utilities. This release fixes various bugs from the
> plugin transition and introduces the first attempts of creating a
> Bluetooth helper library for GLib.
> =

> Currently the full service infrastructure is still available, but with
> the next release this might change. So please prepare yourself it.

Might be an issue with my build, but i get this

hcid[32361]: Can't load plugin: /usr/lib64/bluetooth/plugins/libserial.so:
undefined symbol: g_ascii_isxdigit

I did not change anything in the build system (apart from removing
"--enable-glib" again).
-- =

Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Don't miss this year's exciting event. There's still time to save $100. =

Use priority code J8TL2D2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
