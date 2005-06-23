Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42BAA9C2.3090805@conectiva.com.br>
From: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] how to scan for other bluetooth device
References: <42BA9D29.2070303@e28.com.hk>
In-Reply-To: <42BA9D29.2070303@e28.com.hk>
Content-Type: text/plain; charset=us-ascii
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
Date: Thu, 23 Jun 2005 09:23:30 -0300

Hi Jacky,

Jacky Cheung wrote:
> Hi all,
> 
> I am new to linux Bluetooth. I've got a question in paging other
> bluetooth device, says Bluetooth support phone.
> 
> My PC is running in Redhat9.0, and I got a USB Bluetooth device. When I
> plugin the Bluetooth device, I've got the following message from
> /var/log/message
> 
> Jun 23 18:03:48 localhost kernel: hub.c: new USB device 00:1d.2-1,
> assigned address 5
> Jun 23 18:03:49 localhost hcid[2611]: HCI dev 0 registered
> Jun 23 18:03:49 localhost hcid[2579]: HCI dev 0 registered
> Jun 23 18:03:49 localhost hcid[2611]: HCI dev 0 up
> Jun 23 18:03:49 localhost hcid[2579]: HCI dev 0 up
> Jun 23 18:03:49 localhost hcid[2579]: Starting security manager 0
> Jun 23 18:03:49 localhost hcid[2611]: Starting security manager 0
> Jun 23 18:03:49 localhost /sbin/hotplug: no runnable
> /etc/hotplug/bluetooth.agent is installed
> Jun 23 18:03:52 localhost /etc/hotplug/usb.agent: Setup hci_usb for USB
> product a12/1/1120
> 
> Actually, I can see the Bluetooth device from hciconfig, and the phone
> can scan the USB BT. However, I fail to scan the phone device in PC. Is
> that I have missed some settings?

Did you try 'hcitool scan' from the PC? Did it give some error message?

-- 
Luiz Fernando N. Capitulino


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
