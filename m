Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] more encoder stuff
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20041126000655.1a762210.henryk@ploetzli.ch>
References: <41A56774.1000308@xmission.com>
	 <20041125071423.10e449c3.henryk@ploetzli.ch>
	 <1101365484.7538.74.camel@pegasus>
	 <20041126000655.1a762210.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1101425014.6465.39.camel@pegasus>
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
Date: Fri, 26 Nov 2004 00:23:34 +0100

Hi Henryk,

> > The MAD library (www.underbit.com/products/mad/) is using fixed-point
> > integer computation. Do you think it is possible to do the same thing
> > for SBC? Will it give us some extra performance?
> 
> Unfortunately I'm not familiar with fixed-point arithmetics, especially
> with how to handle multiplication. So if anyone who has done this before
> would step forward ...
> 
> Well, I did some naive tests: I probably did something wrong, but I'm
> not seeing any significant difference between floating point and fixed
> point (that is: integer). For multiplication the difference is not
> noticeable (1.38s vs. 1.36s in my test program) and for addition it is
> not that big (0.77s vs. 0.47s).
> 
> I guess we'll be fine using floating point as long as there is an FPU.

we can optimize at any time if needed, because the SBC API should hide
this stuff. For me this sounds perfect for a diploma thesis for someone
interested in audio codec stuff and Bluetooth.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
