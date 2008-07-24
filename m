Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100807241345x48a0b1co22975c0fb0e0c8d9@mail.gmail.com>
Date: Thu, 24 Jul 2008 17:45:59 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3837d8b10807241238r3284fdb6q60f4c86265146756@mail.gmail.com>
MIME-Version: 1.0
References: <3837d8b10807241238r3284fdb6q60f4c86265146756@mail.gmail.com>
Subject: Re: [Bluez-devel] [PATCH] a2dp_write patch
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

Hello Keith,

Well done, now Im wondering if it isn't possible to use alsa buffer
all the time instead of copying to a temporary buffer? I mean can't we
just point to the first pcm frame processed but not encoded? (If not
freed already by alsa)
Also there is some code duplication, but still the idea is very good.
If you could please check the performance with oprofile.


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
