Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] "comlicated" setup - known issues for	hid and
	SCO?
From: Marcel Holtmann <marcel@holtmann.org>
To: Lars Grunewaldt <lgw@dark-reality.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <411810BF.8010001@dark-reality.de>
References: <4117A907.7010006@dark-reality.de>
	 <1092071597.4564.17.camel@pegasus>  <4117B376.3030507@dark-reality.de>
	 <1092073484.4564.32.camel@pegasus>  <4117BA71.5000800@dark-reality.de>
	 <1092090585.4564.51.camel@pegasus>  <411810BF.8010001@dark-reality.de>
Content-Type: text/plain
Message-Id: <1092142275.4564.105.camel@pegasus>
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
Date: Tue, 10 Aug 2004 14:51:15 +0200

Hi Lars,

> I'd not have asked if I thought it would have to do (much) with btsco.
> 
> Here's what this channel does (default if not given is 2):
> 
> 	addr.rc_family = AF_BLUETOOTH;
> 	bacpy(&addr.rc_bdaddr, dst);
> 	addr.rc_channel = channel;
> 	if (connect(s, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> 		close(s);
> 		return -1;
> 	}
> 
> I just thought you might remember something from the BT specs or so. But
> if you don't, I don't want to bother you, I can read up myself :)

the channel is headset specific. You must use SDP to retrieve the
correct value. The first headset on the market (HBH-10) used RFCOMM
channel 6. Some others uses channel 1 etc.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
