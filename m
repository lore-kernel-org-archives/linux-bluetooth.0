Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41AB4CFE.2000602@vdsoft.org>
From: Vladimir Dvorak <dvorakv@vdsoft.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BCM203x - firmware load failed
References: <41AA747D.5020800@vdsoft.org> <1101692136.9527.7.camel@pegasus>
In-Reply-To: <1101692136.9527.7.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Mon, 29 Nov 2004 17:23:26 +0100

Marcel Holtmann wrote:

>Hi Vladimir,
>
>  
>
>>I have a problem with Belkin Bluetooth USB adapter based on BCM203x 
>>chip. When I plug this dongle into USB port, kernel returns:
>>
>>Bluetooth: Broadcom Blutonium firmware driver ver 1.0
>>bcm203x_probe: Mini driver request failed
>>bcm203x: probe of 2-1:1.0 failed with error -5
>>usbcore: registered new driver bcm203x
>>    
>>
>
>you must make sure that the firmware files are installed. On a Debian
>System is should be enough to install the bluez-firmware package.
>
>Regards
>
>Marcel
>
>
>  
>
Hi Marcel,

thank you very much! Now it is working.

Vladimir



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
