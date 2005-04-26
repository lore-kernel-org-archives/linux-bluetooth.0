Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050426122943.20997.qmail@web8304.mail.in.yahoo.com>
From: Mayank Batra <mayankbatra@yahoo.co.in>
Subject: Re: [Bluez-devel] A2DP sink code finally
To: bluez-devel@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 26 Apr 2005 13:29:43 +0100 (BST)

Brad,
 
> I suspect the distortion could be happening if the
> read() gets an sbc 
> frame fragment at the end... it would be discarded
> by the decoder if 
> that happens.
 
Well, I did printf()s whenever each sbc frame was
being deoded and it turned out that the no. of sbc
frames being decoded from the a2dp packet were EXACTLY
the no. present in the packet.

If mtu is 676 then there are approx 8 sbc frames, and
exactly 8 were getting decoded.
Also, the sound produced(whatever that was being
produced) was similar to the original music.

Just the fact that it is not exactly same.
It means two things:

1) Either we are not configuring the sound card
properly.

2) Or our SBC decoder is not working properly. Henryk,
what do you say about this possibility. Is it possible
?

Mayank

Mayank Batra


Whether you think you can or whether you think you can't, you are right. -Henry Ford.

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
