Return-Path: <cyrus@holtmann.org>
Message-Id: <1C1E133D-5809-41CC-8803-A975C8362CD7@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2d5a2c100810201353v21a70714pb3c6fdc5aab4f54d@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Date: Tue, 21 Oct 2008 00:05:36 +0300
References: <mailman.81198.1224358186.3608.bluez-users@lists.sourceforge.net>
	<89b6ba3a0810181248u29129a09v50c7befde6741e5b@mail.gmail.com>
	<48FA49A4.9040908@powercraft.nl>
	<89b6ba3a0810190855g2aa8bd00v9fe2c782fe5efb3e@mail.gmail.com>
	<89b6ba3a0810190909l69688cb9n13c8000ca272767@mail.gmail.com>
	<4AA04BF6-26EE-488D-A22C-37855410E2F7@gmail.com>
	<2d5a2c100810201353v21a70714pb3c6fdc5aab4f54d@mail.gmail.com>
Subject: Re: [Bluez-devel] [Bluez-users] Motorola S9 and BlueZ 4.14
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Luiz,

On Oct 20, 2008, at 23:53, Luiz Augusto von Dentz wrote:
> Im interested to know why the spec just don't say you need the
> transport to be OPEN as the state means, since from CONFIGURED to OPEN
> there is nothing else relevant to do regarding the state machine or
> does it? Well for now we could just create yet another state so sink.c
> could be notified when the transport is connected.

I don't really understand either why the spec is as it is with regard  =

to the OPEN state. OTOH I think the current solution of going to OPEN  =

when we have the transport seems to work well enough so unless  =

something doesn't work with this approach I wouldn't go making the  =

code more complicated by adding another state.

Johan

P.S. Parab=E9ns sobre o casamento! ;)
-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
