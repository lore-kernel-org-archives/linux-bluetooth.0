Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: James Cameron <james.cameron@hp.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hci_acl_tx_to: hci0 ACL tx timeout
Message-ID: <20040630120249.GH30504@hp.com>
References: <20040630112137.GE30504@hp.com> <1088595657.4540.19.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088595657.4540.19.camel@pegasus>
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
Date: Wed, 30 Jun 2004 22:02:49 +1000

On Wed, Jun 30, 2004 at 01:40:57PM +0200, Marcel Holtmann wrote:
> I can't give you a definitv answer for that problem, but it seems that
> some Bluetooth dongles are not working very nice under heavy load. This
> is actually not a chip problem, because I saw chips working in one
> dongle and in another one it produces such timeouts.

Thanks.  I saw a load correlation before, but not with 2.6.6.

> You can of course try to increase the ACL tx timeout and see if it still
> occurs. 

Oh!  How can I increase that?  I've checked hcitool and hciconfig man
pages, and found how to change MTU and buffer size.

> Do all of your dongles use the same Bluetooth chip?

Both dongles were purchased from the same source, and both look
identical apart from the ba.

I'm not sure how to get the identity of the chip, but hciconfig -a says
at the end ...

        Manufacturer: Cambridge Silicon Radio (10)

-- 
James Cameron


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
