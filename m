Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Multiple Headsets
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41E39BC8.2020105@xmission.com>
References: <41E25ECD.2000505@fcse.co.uk> <41E267C4.5030906@dark-reality.de>
	 <1105362147.8652.10.camel@pegasus> <41E2A9FC.2010405@dark-reality.de>
	 <41E39BC8.2020105@xmission.com>
Content-Type: text/plain
Message-Id: <1105438532.8056.12.camel@pegasus>
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
Date: Tue, 11 Jan 2005 11:15:32 +0100

Hi Brad,

> I would be happy to document it, but I'm not sure exactly what Marcel 
> did. If the number of headsets is fixed at module insertion time then it 
> sounds like it's just good for testing.

with a 2.6 kernel you can change a kernel module parameter on the fly
from /sys/module/ and then you only have to re-plug your dongle to
activate the new settings.

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
