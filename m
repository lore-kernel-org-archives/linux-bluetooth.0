Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: James Cameron <james.cameron@hp.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Switching class II to class III?
Message-ID: <20040914234710.GD30188@hp.com>
References: <41478230.7030800@uni-paderborn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41478230.7030800@uni-paderborn.de>
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
Date: Wed, 15 Sep 2004 09:47:10 +1000

On Wed, Sep 15, 2004 at 01:43:44AM +0200, Stefan Mischke wrote:
> Stupid question: Is there a way to make a class II dongle (Acer BT600, 
> CSR) behave like class III (no signal strength adjustment, 1 mW, 10 m 
> range)? I mean without modifying the firmware. Just by HCI command.

The only method I know is to ensure that the peer dongle is close by.

-- 
James Cameron
Software Security Response Team, Linux Backline, Tru64 Backline
HP Services, Asia Pacific


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
