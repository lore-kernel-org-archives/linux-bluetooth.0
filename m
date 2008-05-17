Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100805171502r2466b16fuf4fcd4d177a27b25@mail.gmail.com>
Date: Sat, 17 May 2008 19:02:58 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <56A45346-8EDB-4B30-85DE-3D371C0EC702@holtmann.org>
MIME-Version: 1.0
References: <200805162025.43120.baisheng.wang.cn@gmail.com>
	<094BCE01AFBE9646AF220B0B3F367AAB03106546@pdsmsx413.ccr.corp.intel.com>
	<56A45346-8EDB-4B30-85DE-3D371C0EC702@holtmann.org>
Subject: Re: [Bluez-devel] sound quality is very slow when using helix
	player.
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

>>From 3.19 to 3.31 there are a lot of changes, so we better focus on 2
things, sbc codec and plugin code. As helix happen to not have a
native plugin so I suppose you are using alsa plugin. What really
changed from 3.19 to 3.31 is that the configuration logic moved from
audio service to plugin, so the user application (helix player) is now
able to select the stream frequency and how many channels it has. This
could be a problem if helix is not selecting the same rate as the
stream and might cause audio degradation, it is also possible that
helix is resampling which not only may cause degradation but also
consumes more cpu.

ps: you can play with sbc parameters directly on ~/.asoundrc, so
perhaps you can find a configuration that do not degraded.

-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft =

Defy all challenges. Microsoft(R) Visual Studio 2008. =

http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
