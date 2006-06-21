Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Philip Langdale <philipl@mail.utexas.edu>
In-Reply-To: <4490C0F1.1090704@mail.utexas.edu>
References: <44867199.2000409@mail.utexas.edu>
	<1149664531.22472.4.camel@localhost> <4486EE2D.3010507@mail.utexas.edu>
	<1149714318.22472.59.camel@localhost>
	<4487B00F.7070204@mail.utexas.edu>
	<1149803817.4219.61.camel@localhost> <448A4385.4020809@mail.utexas.edu>
	<1149986039.5358.25.camel@aeonflux.holtmann.net>
	<4490C0F1.1090704@mail.utexas.edu>
Date: Wed, 21 Jun 2006 09:18:18 +0200
Message-Id: <1150874298.3950.15.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Latest 2.6.16-mh1 patch.
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

Hi Philip,

> >>> okay. I released patch-2.6.16-mh2 with doesn't contain the automatic
> >>> sniff mode feature anymore. Please check if your mouse is now working as
> >>> expected. 
> >> Yep, that did the trick, but I hope you can get the two to play well
> >> together.
> 
> I've been working with mh3 over the last couple of days and have
> noticed another regression. The mouse no longer auto-reconnects
> after being turned off and on or after it auto-disconnects due
> to a timeout.
> 
> This didn't happen with mh2.

so it is the automatic sniff mode feature mode again. Please get me the
hcidump when it times out and when it disconnects due to turned off. It
might include something that gives me a clue, because right now, I have
no idea why this might happen.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
