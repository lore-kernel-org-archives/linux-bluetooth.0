Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 20 Nov 2006 11:25:44 +0100
From: Stefan Seyfried <seife@suse.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20061120102544.GB16495@suse.de>
References: <c303508f0611181827s178b8776g57d3dbec37264691@mail.gmail.com>
	<1164011287.28397.9.camel@localhost>
	<20061120092622.GF4941@suse.de>
	<1164015304.28397.28.camel@localhost>
MIME-Version: 1.0
In-Reply-To: <1164015304.28397.28.camel@localhost>
Subject: Re: [Bluez-devel] Rfcomm kernel crashes (2.6.18.2)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Mon, Nov 20, 2006 at 10:35:04AM +0100, Marcel Holtmann wrote:
> Hi Stefan,
> =

> > >  	BT_DBG("tty %p dev %p", tty, dev);
> > =

> > dev used
> =

> and? It will print "(nil)" which is fine. And it is debug output anyway.
> This is not a dereference.

Ok, it just popped into my eye.
I trust you that you know much better than me what you're doing there... :-)
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
