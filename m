Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 20 Sep 2006 17:00:01 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d23110170609200748u4d16a947q9cfa716825ea44b7@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0609201658220.14092@redbean.intranet.gw-instruments.de>
References: <450603BA.3090302@vasmac.com>
	<Pine.LNX.4.63.0609121038180.17868@redbean.intranet.gw-instruments.de>
	<1158050613.14015.1.camel@localhost>
	<Pine.LNX.4.63.0609121206040.17868@redbean.intranet.gw-instruments.de>
	<45081402.8020909@vasmac.com>
	<Pine.LNX.4.63.0609141052130.22339@redbean.intranet.gw-instruments.de>
	<1158313791.5233.9.camel@localhost>
	<d23110170609200748u4d16a947q9cfa716825ea44b7@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] socket connect returns EAGAIN
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


Hi Ulisses,

> 
> Sorry, but I'm failing to see why we can't just do a
> s/EAGAIN/EINPROGRESS/ inside bt_sock_wait_state(). Does anyone mind to
> explain, please?

The only problem here is that somebody has to implement and test it ....

Ciao, 
Peter 


|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
