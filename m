Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E39BC8.2020105@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Multiple Headsets
References: <41E25ECD.2000505@fcse.co.uk> <41E267C4.5030906@dark-reality.de> <1105362147.8652.10.camel@pegasus> <41E2A9FC.2010405@dark-reality.de>
In-Reply-To: <41E2A9FC.2010405@dark-reality.de>
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
Date: Tue, 11 Jan 2005 02:26:32 -0700

Lars,

I would be happy to document it, but I'm not sure exactly what Marcel 
did. If the number of headsets is fixed at module insertion time then it 
sounds like it's just good for testing.

Brad

Lars Grunewaldt wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Marcel Holtmann wrote:
> |
> | starting with 2.6.10 the hci_usb got a module parameter "isoc". This
> | controls the alternate setting when plugging in a dongle. The default
> | value is 2 (or 0 if it is blacklisted device). Check the Bluetooth
> | specification what value you have to choose for 2 x 16-bit SCO channels.
> |
> 
> nice, did not know this yet. Should be added to the btsco documentation
> *cough*


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
