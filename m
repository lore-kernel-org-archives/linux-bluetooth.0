Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: zze-COLBUS Emmanuel RD-MAPS-GRE <emmanuel.colbus@rd.francetelecom.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1108566885.11909.29.camel@g-necml5-146.rd.francetelecom.fr>
Mime-Version: 1.0
Subject: [Bluez-devel] Code questions
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
Date: Wed, 16 Feb 2005 16:14:45 +0100

Hello,

I've looked to the code of BlueTooth in the linux 2.6.10 kernel, and
I've a few questions : 

- I've noticed that OCF_PIN_CODE_REPLY and OCF_PIN_CODE_NEG_REPLY are
defined in include/net/bluetooth/hci.h, but never used in the code; and
that the function hci_pin_code_request_evt() is void. Does it mean that
the current BlueZ implementation doesn't support PIN codes? (Just making
sure.)

- Is the PIN Code Request event masked away (I think it is, because I
also read the BlueTooth Specification, and it doesn't allow not reacting
to this event), and in this case, were is it masked? I didn't found the
masking in the code.

- I've noticed the same for other events (that they were not treated).
Are they also just masked away, and, if yes, were in the code do this
masking happens?

Emmanuel Colbus

-- 
Please don't care about this useless mail signature:

M. Emmanuel Colbus de l'ENSIMAG intervenant à FTRD/MAPS/AMS du 01/02/05 
au 30/06/05 sous la responsabilité de M. Tahar Jarboui dans le cadre 
d'un stage de fin d'études.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
