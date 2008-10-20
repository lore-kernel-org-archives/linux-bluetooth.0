Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100810201353v21a70714pb3c6fdc5aab4f54d@mail.gmail.com>
Date: Mon, 20 Oct 2008 17:53:47 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4AA04BF6-26EE-488D-A22C-37855410E2F7@gmail.com>
MIME-Version: 1.0
References: <mailman.81198.1224358186.3608.bluez-users@lists.sourceforge.net>
	<89b6ba3a0810181248u29129a09v50c7befde6741e5b@mail.gmail.com>
	<48FA49A4.9040908@powercraft.nl>
	<89b6ba3a0810190855g2aa8bd00v9fe2c782fe5efb3e@mail.gmail.com>
	<89b6ba3a0810190909l69688cb9n13c8000ca272767@mail.gmail.com>
	<4AA04BF6-26EE-488D-A22C-37855410E2F7@gmail.com>
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

Yes and no, it could be set to OPEN state before going really
connected, but it cannot emit the signal Connected otherwise
application will just try to get the fd which could not be available
thus a race condition could cause the problem. So if Connected signal
is mapped to OPEN state it wont work always. The problem could be that
the device simple want to go to STREAMING state which probably creates
the same situation on media transport, where headset and pulse are
competing to set the same state.

Im interested to know why the spec just don't say you need the
transport to be OPEN as the state means, since from CONFIGURED to OPEN
there is nothing else relevant to do regarding the state machine or
does it? Well for now we could just create yet another state so sink.c
could be notified when the transport is connected.


-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

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
