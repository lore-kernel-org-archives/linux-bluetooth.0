Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4190FB84.1040000@eidosspa.it>
From: Rizzo Davide <rizzo@eidosspa.it>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] How to emulate slave serial ports ?
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 09 Nov 2004 18:16:52 +0100

Hi to all.
I'm experimenting with Bluez, I got some important results, but ...
I found a lot of mailings about how to use RFCOMM as a master, so how to 
use Phones as slaves to connect to internet or phone lines.
My approach is different: I have a target system based on Linux 2.6.9 
(ARM architecture), on which I fitted an USB to Bluetooth dongle. I want 
my target system to make available one virtual serial port, and to 
connect to it from an external Windows-based PC.
Now I have all low-level working, I use hciconfig, hcid and sdpd 
(currently my sdpd has some problems, it doesnt'returns so I have to 
call it as "hcid & ls"). Currently, from the Windows PC I successfully 
browsed my linux device and paired it, but I'm not able to view the list 
of exported services.
I understand how to establish a serial connection to an external device, 
knowing its 6-bytes address, but I didn't found any literature on how to 
export a "virtual" serial port.
Should I use "sdptool add SP" ? Or maybe "rfcomm listen /dev/rfcomm0" ?
Which tool is needed to achieve this ?
Thanks
Davide




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
