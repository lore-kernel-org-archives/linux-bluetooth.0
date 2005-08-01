Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42EE3AAF.8000200@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Getting an adaptor to be supported (for SCO	audio)
References: <1122875141.6800.8.camel@amy>  <42EDBD25.4050301@xmission.com> <1122888885.6800.13.camel@amy>
In-Reply-To: <1122888885.6800.13.camel@amy>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 01 Aug 2005 09:07:27 -0600

Alexandros

>>SCO will be routed through the PCM hardware on your silicon wave chip 
>>but that PCM interface is not connected to anything in a usb dongle.
> 
> Voice audio works perfectly in Windows XP, though.

Ok, then they must have a way to route audio through the hci connection.

> Is it a case such as the one with winmodems, in that software is doing
> the voice routing?

I don't think it's like that. I think I've seen Marcel complain about 
silicon wave not working with him on specs/drivers.

> Or would these (cheap, admittedly, I got mine for 15 euros) dongles need
> some sort of (difficult) reverse engineering to pass through the audio?

Everything is cheap these days. I saw a CSR class 1 bt1.2 usb dongle for 
us$10 shipped the other day.

> I don't particulary like this TODO item:
> 
> - Find out if SCO can be mapped to HCI as it can on CSR (*no*)

yeah, I traded email with the infineon tech guy who gumstix works 
through. He danced around this question but I think it's because they 
don't have a way to do it.

Brad


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
