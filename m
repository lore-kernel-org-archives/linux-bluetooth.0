Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Mathias Adam <a2@adamis.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Once again: Socket CF card and Kernel 2.6
Message-ID: <20050305144205.GC21208@adamis.de>
References: <20050226031901.GL11723@adamis.de> <1109578431.17256.9.camel@pegasus> <20050228220209.GA8151@adamis.de> <1109665776.17256.122.camel@pegasus> <42294598.6010004@adamis.de> <1110014266.13601.10.camel@kabel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1110014266.13601.10.camel@kabel>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 5 Mar 2005 15:42:05 +0100

On 05.03.05 10:17:46, Erwin Authried wrote:
> > seems to initialize the actual UART with only 230400 baud. Is this 
> > really the case or are those UARTs clocked at nonstandard (higher) 
> > frequencies so that this setting does result in a higher real baud rate?
> 
> I can't say for sure if that applies to your specific CF card, but
> usually PCMCIA/CF uarts are just register-compatible emulations of a
> standard uart, and the clockrate doesn't matter at all. The actual data
> rate can be very high.

Hmm, I don't know... as the card didn't work with the wrong baud rate
programmed in its UART I think it does use the selected clock rate - ok, at
least the divisor must be right, the UART might be clocked internally at
much more than the standard ~1.8MHz giving a higher real baud rate.

Regards
Mathias



-- 
Twenty years from now you will be more disappointed by the things that
you didn't do than by the ones you did do. So throw off the bowlines.
Sail away from the safe harbor. Catch the trade winds in your sails.
Explore. Dream. Discover.  (Mark Twain)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
