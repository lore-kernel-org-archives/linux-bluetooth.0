Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <BAY12-F35563885BF49C62DF2513EAB9E0@phx.gbl>
In-Reply-To: <1104605311.4253.11.camel@pegasus>
From: "Pegasus ..." <uwpegasus@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Continuous Inquiry
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
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
Date: Sat, 01 Jan 2005 21:10:58 +0000

Thanks for your response.

If I do Inquiry in batches of  1.28 seconds, will that affect Inquiry 
response from other devices? ...due to the Inquiry Scan Window traversing 
the same frequencies again !

I tested the batch approach with the two Socket CF+PCMCIA cards I have and 
seem to work fine... but maybe it wont work when there are more devices from 
different vendors ?

Thanks again....


>From: Marcel Holtmann <marcel@holtmann.org>
>Reply-To: bluez-devel@lists.sourceforge.net
>To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
>CC: uwpegasus@hotmail.com
>Subject: Re: [Bluez-devel] Continuous Inquiry
>Date: Sat, 01 Jan 2005 19:48:31 +0100
>
>Hi Keshab,
>
> > My program is running a thread with continuos hci_inquiry(). I need to 
>know
> > when a new device is discovered in the middle of the inquiry. How do I 
>do
> > this?
>
>program the HCI raw socket directly maybe you should use periodic
>inquiry. You will find example code in the mailing list archive.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>The SF.Net email is sponsored by: Beat the post-holiday blues
>Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
>It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
