Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
From: Marcel Holtmann <marcel@holtmann.org>
To: Charles Bueche <charles@bueche.ch>
Cc: Olivier Bornet <Olivier.Bornet@smartdata.ch>,
   BlueZ Developers List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1071432083.6305.24.camel@bluez.bueche.ch>
References: <1070218289.8534.30.camel@bluez.bueche.ch>
	 <20031201093804.A1281@schnell.us.cray.com> <1070380522.19169.52.camel@saag>
	 <1070380907.19169.55.camel@saag> <1070482683.18058.6.camel@bluez.bueche.ch>
	 <1070483755.24159.114.camel@pegasus> <20031204085314.GA1780@smartdata.ch>
	 <1071001915.13464.33.camel@bluez.bueche.ch>
	 <20031209224217.GE26896@smartdata.ch>
	 <1071043970.8979.5.camel@bluez.bueche.ch>
	 <20031210083002.GG26896@smartdata.ch>
	 <1071330995.4307.27.camel@bluez.bueche.ch>
	 <1071333541.27252.177.camel@pegasus>
	 <1071341513.4307.36.camel@bluez.bueche.ch>
	 <1071342247.1548.6.camel@pegasus> <1071410118.5988.8.camel@bluez.bueche.ch>
	 <1071411737.4356.56.camel@pegasus>
	 <1071432083.6305.24.camel@bluez.bueche.ch>
Content-Type: text/plain
Message-Id: <1071432572.4358.104.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 14 Dec 2003 21:09:32 +0100

Hi Charles,

> > this shouldn't be needed, because the mouse reconnects if you start
> > moving it. The only thing you need is a HID server process on your host.
> 
> I have to test more. What is your command line for this ? I use
> /data/util/bthid-0.8-2.6/bthid -m -d -p 600 00:07:61:08:7E:2E

I used Peter's code only once, but I remember that you must use -l to
fork a server process.

> You do a very good job in that limited time, given all these beginners
> like me asking basic stuff on mailing lists :-)

Thank you.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
