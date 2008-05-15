Return-Path: <cyrus@holtmann.org>
Message-ID: <482C5CF7.1070306@suse.de>
Date: Thu, 15 May 2008 17:55:35 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <1210786481.4797.4.camel@localhost.localdomain>
	<1210860904.7025.50.camel@violet.holtmann.net>
In-Reply-To: <1210860904.7025.50.camel@violet.holtmann.net>
Subject: Re: [Bluez-devel] bug report: trouble reconnecting keyboard	after
 timeout
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel Holtmann wrote:
> Hi Dick,
> =

>> I upgraded bluez-utils and bluez-libs (3.31) and it didn't help.
>>
>> I've attached a logfile, I hope it's sufficient.
>>
>> My mouse and keyboard couldn't connect, I've reconnected them by
>> manually disconnecting them in bluetooth-applet.
> =

> if I am not mistaken, then the attached kernel patch will fix this
> issue.

Partly. It works fine with my mouse, but my keyboard, that was happy before
now after some "roundtrips" gets unhappy and does no longer reconnect. (i
changed the idle timeout to 30 seconds to test).

I got stuff like that in hcidump:
2008-05-15 17:23:44.288599 > ACL data: handle 11 flags 0x02 dlen 12
   L2CAP(s): Connect req: psm 19 scid 0x005c
2008-05-15 17:23:44.288640 < ACL data: handle 11 flags 0x02 dlen 16
   L2CAP(s): Connect rsp: dcid 0x0000 scid 0x005c result 4 status 0
     Connection refused - no resources available

And then my dongle spontaneously disconnected itself from the USB bus and
reconnected.

I have not seen this again since then, but maybe it is something to watch o=
ut for.
-- =

Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft =

Defy all challenges. Microsoft(R) Visual Studio 2008. =

http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
