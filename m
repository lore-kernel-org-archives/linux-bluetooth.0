Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050324184727.51038.qmail@web52809.mail.yahoo.com>
From: Shawn Rutledge <e_cloud@yahoo.com>
Subject: Re: [Bluez-devel] Need for Bluetooth A2DP sink
To: bluez-devel@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Thu, 24 Mar 2005 10:47:26 -0800 (PST)

I agree that A2DP sink support would be very useful.  How much work do
you think remains?

--- Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi,
> 
> > With intereting, I have read your article
> > (<http://www.holtmann.org/linux/bluetooth/sbc.html>). And I have
> > bought the product <http://www.bluetake.com/products/BT420EX.htm>.
> > 
> > 
> > My questions are:
> > 
> > Do you have opensource-based A2DP sink (plus SBC decoding) for
> > Windows, WinCE, or linux?
> 
> we have SBC encoding and decoding for Linux and A2DP source. Check
> out
> the page bluetooth-alsa.sf.net for more details.
> 
> > If yes, I would like to make some test with BT420's audio adapter
> > (A2DP source)?
> 
> We don't implement A2DP sink at the moment.
> 
> Regards
> 
> Marcel


. _______  Shawn T. Rutledge / KB7PWD ecloud@bigfoot.com
 (_  | |_)    http://ecloud.org/  kb7pwd@kb7pwd.ampr.org
 __) | | \______________________________________________


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
