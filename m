Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Code questions
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1108566885.11909.29.camel@g-necml5-146.rd.francetelecom.fr>
References: <1108566885.11909.29.camel@g-necml5-146.rd.francetelecom.fr>
Content-Type: text/plain
Message-Id: <1109027849.7626.38.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 22 Feb 2005 00:17:29 +0100

Hi Emmanuel,

> I've looked to the code of BlueTooth in the linux 2.6.10 kernel, and
> I've a few questions : 
> 
> - I've noticed that OCF_PIN_CODE_REPLY and OCF_PIN_CODE_NEG_REPLY are
> defined in include/net/bluetooth/hci.h, but never used in the code; and
> that the function hci_pin_code_request_evt() is void. Does it mean that
> the current BlueZ implementation doesn't support PIN codes? (Just making
> sure.)

currently these events are handled by the hcid, but for the upcoming
security and profile manager they will be moved inside the kernel.

> - Is the PIN Code Request event masked away (I think it is, because I
> also read the BlueTooth Specification, and it doesn't allow not reacting
> to this event), and in this case, were is it masked? I didn't found the
> masking in the code.

Nothing is masked away.

> - I've noticed the same for other events (that they were not treated).
> Are they also just masked away, and, if yes, were in the code do this
> masking happens?

Explain what you mean.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
