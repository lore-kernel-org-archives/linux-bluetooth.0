Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] caching A2DP/alsa connection
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43302E11.5010103@xmission.com>
References: <432CE905.6050006@xmission.com>
	 <1127216847.5168.27.camel@localhost.localdomain>
	 <43302E11.5010103@xmission.com>
Content-Type: text/plain
Message-Id: <1127231352.5168.80.camel@localhost.localdomain>
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
Date: Tue, 20 Sep 2005 17:49:12 +0200

Hi Brad,

> I've joined the gstreamer list and I'm looking into the docs some more 
> before I ask them if gstreamer plugins can do everything we need. I hate 
> to add a dependency, but if gstreamer is a more straightforward way to 
> go and it's becoming mainstream, I don't mind requiring it.

I still think the ALSA plugin is the way to go, but there are still some
problems to solve and it doesn't help for embedded systems that don't
use ALSA. I think we have to go both ways anyhow.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
