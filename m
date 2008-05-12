Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100805120740r6e716ad8ob5a6a7a506e05f90@mail.gmail.com>
Date: Mon, 12 May 2008 11:40:40 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1210600054.16390.55.camel@violet.holtmann.net>
MIME-Version: 1.0
References: <094BCE01AFBE9646AF220B0B3F367AAB030C0117@pdsmsx413.ccr.corp.intel.com>
	<1210600054.16390.55.camel@violet.holtmann.net>
Subject: Re: [Bluez-devel] I can't use 3.31 release,
	but 3.19 release works on the same platform
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

Hi Halley,

It looks like you have some problem in your configuration otherwise
you shouldn't be getting this:

ALSA lib pcm_bluetooth.c:1517:(audioservice_expect) Bogus message
BT_GETCAPABILITIES_REQ received while BT_GETCAPABILITIES_RSP was
expected

Could you please send us the hcid output, then we can help configuring
it correctly, also make sure you are really
installing the new alsa plugin as marcel said.

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
