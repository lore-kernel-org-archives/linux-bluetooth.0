Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Bluetooth address specific device
	configuration
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Edd Dumbill <edd@usefulinc.com>
In-Reply-To: <1075316178.553.18.camel@akka.yeti.nocrew.org>
References: <1075316178.553.18.camel@akka.yeti.nocrew.org>
Content-Type: text/plain
Message-Id: <1075355567.26729.65.camel@pegasus>
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
Date: Thu, 29 Jan 2004 06:52:47 +0100

Hi Fredrik,

> Attached patch makes it possible to use a configuration in hcid.conf
> for a device with a certain Bluetooth device address:
> 
>    options
>    {
> 	# hcid options...
>    }
> 
>    device
>    {
> 	# Default device options...
>    }
> 
>    device 00:11:22:33:44:55
>    {
> 	# Device options for bdaddr 00:11:22:33:44:55...
>    }
> 
> It's useful to do persistent device specific configurations, for example
> setting unique and meaningful names. I've only done limited testing.

I like the idea (also the second one with hci0). Please send me a patch
that enables both possibilities. But be aware of that I don't even had
reviewed your first one, so this can take some time before I will apply
it.

Has anyone already tested this patch? Do it break some other stuff?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
