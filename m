Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41375861.90004@conectiva.com.br>
From: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
MIME-Version: 1.0
To: gonzalo briceno <gonzalohbriceno@yahoo.com>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Key step in bluetonium setup, bcm203x does not
 load firmware
References: <20040902141108.99034.qmail@web52807.mail.yahoo.com>
In-Reply-To: <20040902141108.99034.qmail@web52807.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 02 Sep 2004 14:29:05 -0300


  Hello Gonzalo,

gonzalo briceno wrote:

 > I installed bluez-firmware-1.0 and bluez-utils-2.9,
 > however, the problem is not fixed.  When I look at
 > /proc/bus/usb/devices the bluetonium chip is listed
 > but sure enough, it does not load the usb_hci module.
 >
 > Any help?

  We had the some problem here (but the device is different).

  On our setup, we copied the firmware files to:

/usr/lib/hotplug/firmware/

  and reloaded the kernel module.

  I'm not certain if it is the right thing to do, but
it worked.

  Hope it helps,

-- 
Luiz Fernando N. Capitulino


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
