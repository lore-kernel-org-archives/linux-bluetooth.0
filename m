Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth and wireless lan horror
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Bergmann <bergmann.peter@gmx.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <30847.1065160235@www33.gmx.net>
References: <30847.1065160235@www33.gmx.net>
Content-Type: text/plain
Message-Id: <1065171540.1734.97.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 03 Oct 2003 10:58:54 +0200

Hi Peter,

> this question/problem is (maybe) not directly related with bluez .
> i use bluez with a class 2 usb dongle together with a wireless lan
> pcmcia card.  bluez is used for a rfcomm connection to a bluetooth
> input device and works really great!  actually data is beeing 
> transmitted not very often and only a few bytes, but the rfcomm 
> connection has to be open all the time.
> 
> i knew that bluetooth and wireless lan use the same frequenzy band
> and that this may lead to problems but for me it's  totally unuseable!
> 
> as soosn as i move more than 10 feet away from the wlan accesspoint
> i get a packetloss from more than 30 percent even if no data is
> being transmitted via the rfcomm connection.
> 
> i dont' understand why wlan transmission is affected even if no data 
> goes over the bluez rfcomm connection!?

even if is there is no traffic on the RFCOMM connection doesn't mean
that there is no traffic at all. Due the fast hopping frequency of
Bluetooth it is more robust than WLAN and in general there is nothing
you can do ;) You can use LAN access or PAN over Bluetooth.

One thing you can try is that you switch your language code of your
Bluetooth device to france and in this case it won't use all 79 channels
anymore. Then you can put your WLAN card on a frequency which is no
longer used by Bluetooth. Maybe this helps, but don't ask me how to do
this in detail.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
