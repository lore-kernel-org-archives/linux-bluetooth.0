Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Continuous Inquiry
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY12-F35563885BF49C62DF2513EAB9E0@phx.gbl>
References: <BAY12-F35563885BF49C62DF2513EAB9E0@phx.gbl>
Content-Type: text/plain
Message-Id: <1104622566.8286.2.camel@pegasus>
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
Date: Sun, 02 Jan 2005 00:36:06 +0100

Hi,

> If I do Inquiry in batches of  1.28 seconds, will that affect Inquiry 
> response from other devices? ...due to the Inquiry Scan Window traversing 
> the same frequencies again !
> 
> I tested the batch approach with the two Socket CF+PCMCIA cards I have and 
> seem to work fine... but maybe it wont work when there are more devices from 
> different vendors ?

I think this will lead into problems some time. Use the HCI raw socket
directly and read every inquiry result event.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
