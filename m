Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci_acl_tx_to: hci0 ACL tx timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: James Cameron <james.cameron@hp.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040630120249.GH30504@hp.com>
References: <20040630112137.GE30504@hp.com>
	 <1088595657.4540.19.camel@pegasus>  <20040630120249.GH30504@hp.com>
Content-Type: text/plain
Message-Id: <1088599419.4540.24.camel@pegasus>
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
Date: Wed, 30 Jun 2004 14:43:39 +0200

Hi James,

> > I can't give you a definitv answer for that problem, but it seems that
> > some Bluetooth dongles are not working very nice under heavy load. This
> > is actually not a chip problem, because I saw chips working in one
> > dongle and in another one it produces such timeouts.
> 
> Thanks.  I saw a load correlation before, but not with 2.6.6.

I really think this is buggy hardware in the USB dongle or in the USB
host controller. Maybe it is also only a software problem and related to
the USB subsystem. I don't know.

> > You can of course try to increase the ACL tx timeout and see if it still
> > occurs. 
> 
> Oh!  How can I increase that?  I've checked hcitool and hciconfig man
> pages, and found how to change MTU and buffer size.

Forget about that comment. I checked the kernel code and I don't think
that increasing the timeout to more than 45 seconds makes sense.

        /* ACL tx timeout must be longer than maximum
         * link supervision timeout (40.9 seconds) */
        if (!hdev->acl_cnt && (jiffies - hdev->acl_last_tx) > (HZ * 45))
                hci_acl_tx_to(hdev);

> > Do all of your dongles use the same Bluetooth chip?
> 
> Both dongles were purchased from the same source, and both look
> identical apart from the ba.
> 
> I'm not sure how to get the identity of the chip, but hciconfig -a says
> at the end ...
> 
>         Manufacturer: Cambridge Silicon Radio (10)

If it is CSR based you can try "hciconfig hci0 revision".

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
