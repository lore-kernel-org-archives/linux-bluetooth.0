Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Malte Steiner <steiner@mobileart.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY124-W5118C7F2144DA03833009AF0610@phx.gbl>
References: <BAY124-W5118C7F2144DA03833009AF0610@phx.gbl>
Date: Sun, 01 Apr 2007 16:04:43 +0200
Message-Id: <1175436283.12319.9.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Multithread Service Discovery
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

the choice of C++ and an object orientated approach was more done by my
customer. It has some benefits, e.g. regarding encapsulating data and
functionality but didnt made life easier in the first place. Bluez and
OpenObex is C and gave me some headaches with the callback routines for
instance.

I use threading for the whole application, not only or particulary for
the SDP discovery. And in general the multitasking solution at least
feels faster than the single task one. 

You want to use Push instead of Put or FTP, Push is the only Obex
service which doesnt need pairing.

Cheers,

Malte


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
