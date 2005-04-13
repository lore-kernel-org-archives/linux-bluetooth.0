Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <425D8196.2090608@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] dongles won't initialize
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
Date: Wed, 13 Apr 2005 22:31:18 +0200

Hello everybody

maybe someone has an idea:

On my PC, I have:
Kernel 2.6.8-24.14-default
bluez-utils and bluez-libs 2.15

this is exactly the same setup as on my laptop where everything works 
perfectly fine.
the same dongle(s) used in the laptop refuse to work with the pc.

I made several (>20) tries with reboot and hcid reload.
hcitool dev and hciconfig -a:
- mostly showed nothing (no devices)
- about two times showed the dongles correctly but hciconfig -a failed with 
a timeout (hciconfig hci0 revision as well)
- once, the dongle wasn't up. doing hciconfig hci0 up freezed
- lsusb [-b] freezed
- dmesg, /var/log/messages didn't get any entries

I strongly assume this has something to to with the usb port. maybee it's 
broken or i'm missing something important (software)...


any ideas/help very appreciated

regards
Marco


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
