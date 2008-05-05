Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100805051440p42bbbeb5ic02a6db5b41733c7@mail.gmail.com>
Date: Mon, 5 May 2008 18:40:26 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1210020130.10069.5.camel@ubuntu>
MIME-Version: 1.0
References: <1210020130.10069.5.camel@ubuntu>
Subject: Re: [Bluez-devel] network - NAP (pan1) bridge is not initialized
	(patch)
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

Sorry but NAP is not as simple as GN, thats why the NAP bridge is not
being created by network service.
NAP server can really be consider a bluetooth router so we probably
need something more advanced than
creating a normal bridge. Perhaps we can use a daemon that can handle
this 'router' functionality, but Im
afraid it still doesn't exists.

I still need to check what is going on in case of GN server, but I
guess the debug normally helps so I will
probably make them available in cvs.

-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

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
