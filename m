Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 1 Jun 2006 17:16:38 -0400
Message-ID: <70DCB28C5BB04A4BBB1C8512589BAC65D4F2D8@MAIL006.mail.lan>
In-Reply-To: <1149196284.28511.73.camel@localhost>
From: "Brand, Chris" <chris.brand@wideray.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Strange behaviour
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

> Do you really need to use a thread to produce this behavior. 
> I normally try to avoid any threaded programs at all. Can you 
> please remove all extra stuff from your code (and use simply 
> hci0 only) and try to not to use threads?
> 

I think the problem only occurs when I'm sending and receiving at the
same time, which could well mean that it will only occur with a threaded
program.

Chris


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
