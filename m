Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1aef62250611300052p3ed2a9i1f8e1d236eb4957@mail.gmail.com>
References: <1aef62250611300052p3ed2a9i1f8e1d236eb4957@mail.gmail.com>
Date: Sun, 03 Dec 2006 14:46:38 +0100
Message-Id: <1165153598.19590.26.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Hexadecimals (What are they really?)
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

Hi David,

> Over at Jellingspot (www.jellingspot.com), we have a client/server
> based location marketing server ... we'd just added (not yet released)
> "bluecasting" abilities to this server .... in short ... the server
> scans the area, and should send content to phones.  We have
> implemented hexadecimal discovery into the server, which basically
> finds the hexadecimal number of the BT device in question, and would
> send content to that phone garnered to that phone type ...
> 
> My understanding was that each hexadecimal was unique for each phone
> type ... however, it appears that it's unique for each phone...
> 
> Can somebody tell me, precisely, if the hexadecimal is relates to
> specific phone type, phone chip, phone region, phone brand, or ????  I
> was under the impression I'd be able to at least tell if the phone
> would be a Nokia 7650 or 6600 .... is this type of bluepriting
> possible, or is this beyond what BT allows (or what has been
> implemented by device makers?)

I actually have no clue what you are talking about. I assume you are
talking about the BD_ADDR of remote devices and in this case, you can't
tell the brand or model from that 6 byte value. You can make some wild
guesses, but that is basically it.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
