Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HSP and audio -- "right thing" to look at?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4aaa2e1c04121406315ecf8659@mail.gmail.com>
References: <4aaa2e1c04121406315ecf8659@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1103107921.2143.197.camel@pegasus>
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
Date: Wed, 15 Dec 2004 11:52:01 +0100

Hi Wartan,

> As far as I see, most development on audio transmission is happening
> at bluetooth-alsa, which is a separate project from bluez (right?).
> Having read the mailing list, I didn't quite understand the
> development direction that bluez would like to follow "mainstream"
> implementing audio and headset profiles, and if things now being
> implemented by bluetooth-alsa are "Right Way".

the Bluetooth-ALSA project is somekind of spin-off to play with headset,
handsfree and advanced audio support that is actually to experimental to
merge it back into BlueZ mainline. However it will be merged back when
it is more stable and the best solution is found. Besides the different
website and their CVS, the bluez-devel mailing list is used for the
discussion.

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
