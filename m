Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <BAY12-F96C49A8056B58A97FFE7BAB9F0@phx.gbl>
In-Reply-To: <1104622566.8286.2.camel@pegasus>
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
Date: Sun, 02 Jan 2005 19:37:36 +0000

Hi Marcel:

>From: Marcel Holtmann <marcel@holtmann.org>
>Reply-To: bluez-devel@lists.sourceforge.net
>To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
>Subject: Re: [Bluez-devel] Continuous Inquiry
>Date: Sun, 02 Jan 2005 00:36:06 +0100
>
>Hi,
>
> > If I do Inquiry in batches of  1.28 seconds, will that affect Inquiry
> > response from other devices? ...due to the Inquiry Scan Window 
>traversing
> > the same frequencies again !
> >
> > I tested the batch approach with the two Socket CF+PCMCIA cards I have 
>and
> > seem to work fine... but maybe it wont work when there are more devices 
>from
> > different vendors ?
>
>I think this will lead into problems some time. Use the HCI raw socket
>directly and read every inquiry result event.
>
>Regards
>
>Marcel


I am a bit lost here.

I looked at the code for hic_inquiry and hci_send_req... still not sure how 
to read raw socket event for inquiry.  Any other pointer to look at?

Thanks for your time and help...




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
