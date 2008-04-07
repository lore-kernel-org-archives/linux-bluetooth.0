Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100804071035l37bf1643ta41a2c65f1c8f31b@mail.gmail.com>
Date: Mon, 7 Apr 2008 14:35:50 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <49f5aca0804070731j7d3a7349ta29461fad6808231@mail.gmail.com>
MIME-Version: 1.0
References: <49f5aca0804070731j7d3a7349ta29461fad6808231@mail.gmail.com>
Subject: Re: [Bluez-devel] C program for capturing AnswerRequested signal
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

Please install dbus-glib documentation and take a look, some parameters of
dbus_g_proxy_new_for_name are wrong.

You have to call ActivateService then you receive the bus name of the servi=
ce,
the object path is normally /org/bluez/<sevice name>. At this point it shou=
ld
be possible to connect to service signals.

ps: After 3.28 it is not really necessary to call ActivateService anymore, =
the
bus name is actually the same as hcid since service are all plugins now.

-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Register now and save $200. Hurry, offer ends at 11:59 p.m., =

Monday, April 7! Use priority code J8TLD2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
