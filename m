Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bandwidth when using serial cable
From: Marcel Holtmann <marcel@holtmann.org>
To: Kutschenreuter Matthias <Matthias.Kutschenreuter@siemens.com>
Cc: "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <AFE91B59A185A5439840B43AB7919047093816@mchp997a.mch.sbs.de>
References: <AFE91B59A185A5439840B43AB7919047093816@mchp997a.mch.sbs.de>
Content-Type: text/plain
Message-Id: <1071698979.21800.74.camel@pegasus>
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
Date: Wed, 17 Dec 2003 23:09:39 +0100

Hi Matthias,

> I work with several Bluetooth Chips, but they have
> one commonality: they all have to be connected via serial
> cable. Am I right, that attaching with
> 	hciattach /dev/ttyS0 any 115200 
> limits the data rate to 115,2 Kbit/s, which is the
> speed of serial cable? I am not talking about any 'baseband'
> datarate or l2ping, I am talking about the user data rate, 
> lets say for transfering a 10 MBit file.

I can't remeber that he was using a serial connection, but in case of a
limited serial connection to the Bluetooth module, the data rate of the
BNEP transmission is also limited.

> Did anyone get higher throughput than this 115, 
> when using serial cables? 

You can use many chips with higher baud rates. Look at the source code
of hciattach what kind of special setting we support.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
