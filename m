Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] seems that device is not found
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <cnv248$vgv$1@sea.gmane.org>
References: <cnv248$vgv$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1101204892.26578.63.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 23 Nov 2004 11:14:52 +0100

Hi,

> OK, I have just installed a ready fresh Fedora Core 3 distribution kernel
> 2.6.9-1.667, no additional packages from bluez.org (I'm guessing they are
> included in my linux distribution, is this correct?). So, I plug a
> Conceptronic CBT100U adapter device (listed in bluetooth adapter list
> www.holtmann.org), execute hcitool dev, and all I get is:
> 
> Devices:
> 
> ...anything else. By the way, I get the same response in three different
> linux boxes with the same kernel version.
> I'm afraid this is not the best welcome I could hope, or it is? so I would
> like your opinion for that. Also, I wonder how can I know which of the bluez
> downloads should I install and which don't, and how can I know if they are
> already installed on my system (also Linux novice, excuses for that..)

check with "hciconfig -a" if your device is detected and if it is up and
running.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
