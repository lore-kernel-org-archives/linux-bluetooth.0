Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] AVM BlueFritz with Linux Kernel 2.6.3-15mdk
From: Marcel Holtmann <marcel@holtmann.org>
To: Sigrid Kronenberger <skronenberger@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040813212742.404662f2@localhost>
References: <20040811231204.18574a27@localhost>
	 <1092262417.4564.259.camel@pegasus> <20040812194818.7d3d1ce6@localhost>
	 <1092334021.28711.169.camel@pegasus> <20040812203428.0bd25290@localhost>
	 <1092336801.28711.172.camel@pegasus> <20040813210346.6c40aed3@localhost>
	 <1092424207.4501.27.camel@pegasus>  <20040813212742.404662f2@localhost>
Content-Type: text/plain
Message-Id: <1092425535.4501.34.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 13 Aug 2004 21:32:15 +0200

Hi Sigrid,

> > But the firmware request still fails. Where do you put your
> > bfubase.frm file? Is hotplug installed and do you have a
> > firmware.agent script under/etc/hotplug.
> 
> I've copied the bfubase.frm file to /usr/lib/hotplug/firmware 
> And, yes, I have the firmware.agent scrip under /etc/hotplug.

check the permissions of both. What does these two commands say?

	ls -la /etc/hotplug
	ls -la /usr/lib/hotplug/firmware

Attach the firmware.agent script so we can look inside.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
