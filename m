Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4086FFD9.50104@over-here.org>
From: Eran <eran_l@over-here.org>
MIME-Version: 1.0
To: Pavel Ruzicka <pavouk@pavouk.org>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Ambicom BT2000E card, can't get hciattach to work
References: <4086DDFC.5000107@over-here.org> <200404220027.02236.pavouk@pavouk.org>
In-Reply-To: <200404220027.02236.pavouk@pavouk.org>
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
Date: Thu, 22 Apr 2004 02:12:25 +0300

Sorry I forgot to mention it - but hciconfig shows a fully 'up and 
running' interface. I use the bt950_cs driver.
I further checked and most hcitool commands work except the link quality.
I Have tried removing the bluetooth.conf from my pcmcia/ directory and 
use hciattach with /dev/ttyS03, but no success here as well (could not 
find correct parameters). Why is it the preferred way?


Pavel Ruzicka wrote:

>Hello,
>
>  
>
>>I can get an RFCOMM to work, but when trying to work with hci I fail:
>>1) on /etc/init.d/bluetooth I have a line that does hciattach:
>>root@thumper:/etc/pcmcia# /usr/sbin/hciattach /dev/ttyS3 bcsp 57600
>>Can't get port settings: Input/output error
>>Can't initialize device: Input/output error
>>    
>>
>
>I have this card (Pretec BT2000E) with Sharp Zaurus SL-C860 with Cacko rom.
>For this card exists now 3 drivers.
>
>1. bt950_cs
>This driver is probably from Marcel Holtmann and is part of BlueZ.
>hciattach is not needed for this driver.
>http://www.holtmann.org/linux/bluetooth/
>
>2. bt2000e_cs
>I use mometally this driver, because it works for me and it is part of Cacko
>rom installation. There are some fixes with suspend/resume problems
>and uart speed.
>hciattach is not needed for this driver too.
>http://www.iral.com/~albertr/linux/bt2000e/
>
>3. serial_cs
>This path is preferred, but I can't find right parameters for hciattach.
>I've tried many combinations like this:
>hciattach /dev/ttyS3 ericsson 460800
>But all without success.
>If somebody run card with this driver please write to the list!
>
>  
>
>>2) hcitool scan and cc <phone> works, but hci lq fails:
>>root@thumper:/etc/pcmcia# hcitool lq 00:80:37:D6:93:D5
>>HCI get_link_quality cmd failed (0x01)
>>    
>>
>
>If this works, you must have corretly runned hciattach...
>What shows "hciconfig"?
>
>  
>
>>root@thumper:/etc/pcmcia# cardctl ident
>>Socket 0:
>>  product info: "AmbiCom,Inc", "BT2000E", "Bluetooth PC/CF Card"
>>  manfid: 0x022d, 0x2000
>>  function: 2 (serial)
>>    
>>
>
>This is my cardctl ident:
>Socket 0:
>  product info: "Pretec", "BT2000E", "Bluetooth PC/CF Card"
>  manfid: 0x022d, 0x2000
>  function: 2 (serial)
>
>  
>
>>dmesg of bluez drivers doesn't show anything special, And before I
>>installed bluetooth drivers the card showed as serial device on /dev/ttyS3.
>>    
>>
>
>Yes card is identified as UART.
>
>I have this config file: /etc/pcmcia/bt2000e.conf
>-----------------------------------------------------------------------------
>device "bt2000e_cs"
>  class "bluetooth" module "bt2000e_cs"
>
>card "AmbiCom BT2000E Bluetooth Card"
>  version "AmbiCom,Inc", "BT2000E"
>  bind "bt2000e_cs"
>
>card "Pretec BT2000E Bluetooth Card"
>  version "Pretec", "BT2000E"
>  bind "bt2000e_cs"
>------------------------------------------------------------------------------
>
>This card works good for me.
>
>Best regards,
>
>Pavel Ruzicka
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: IBM Linux Tutorials
>Free Linux tutorial presented by Daniel Robbins, President and CEO of
>GenToo technologies. Learn everything from fundamentals to system
>administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>  
>


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
