Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42264BBF.7040507@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth PC Headset - SCO connection failed
References: <f54d86405022806312ab4142a@mail.gmail.com>	 <4223466A.2010701@xmission.com> <f54d86405030108254b6085b@mail.gmail.com>
In-Reply-To: <f54d86405030108254b6085b@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 02 Mar 2005 16:26:55 -0700

Benny

> We need to transfer additional data(full duplex between a linux PC and
> the Headset) parallely apart from the headset functionality. Is this
> possible?

It's not clear what you're asking since most (all?) headsets only 
support audio data.

I believe you can open an rfcomm connection to the headset and transfer 
data in parallel to audio if your headset knew what to do with it.

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
