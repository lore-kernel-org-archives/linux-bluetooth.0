Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4526789C.5040807@xmission.com>
Date: Fri, 06 Oct 2006 09:39:08 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <BAY108-F8AEDD15BC11FA229795F584130@phx.gbl>
In-Reply-To: <BAY108-F8AEDD15BC11FA229795F584130@phx.gbl>
Subject: Re: [Bluez-devel] L2CAP Broadcasting
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

mark

I believe bluez doesn't have code to broadcast. Affix can do it ostensibly.

It's not clear what the bluez api for setting up a broadcasting socket
would look like.

brad

> i want to know how l2cap broadcasting is done. I already created sockets to 
> receive datagram packets and have set up the broadcasting flag.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
