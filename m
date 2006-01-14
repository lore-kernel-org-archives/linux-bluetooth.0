Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43C8FB45.8010209@libero.it>
From: jimmi <jimmi@libero.it>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-users] upgrade to btsco 0.41
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
Date: Sat, 14 Jan 2006 14:23:17 +0100

Hi,

I'm reporting for  whoever may be helpful:  I use a Jabra  BT250v with a
D-Link DBT-120 usb key, and I  upgraded yesterday both the kernel to the
new Debian 2.6.15 and the btsco to the 0.41.

After   upgrading   I   got   an    error   for   the   RFCOMM   channel
and   I  could   get  the   device   working  again   by  deleting   the
/var/lib/bluetooth/[device]/linkkeys   file,   as   indicated   on   the
bluetooth-alsa page.

Thanks again for your job guys :)
-- 
    ---        _   o        |   Perche' denunciare il reddito dopo il   |
    / immi   --  _/\_>      |         bene che vi ha fatto? MM          |
(_/         -  O,> / O     |                                           |


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
