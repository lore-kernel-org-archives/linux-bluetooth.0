Return-Path: <bluez-users-bounces@lists.sourceforge.net>
In-Reply-To: <1150661429.8816.24.camel@localhost>
References: <0B0B4E49-71C5-4D33-A5E6-6304B2EFDA7F@ciziunas.com>
	<1150657050.8816.15.camel@localhost>
	<7D0614E0-109E-4E3F-9017-79874501E212@ciziunas.com>
	<1150661429.8816.24.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v750)
Message-Id: <849EFB8D-4A82-4D17-BE87-8F50F5B4DAAC@ciziunas.com>
From: =?UTF-8?Q?Vincas_=C4=8Ci=C5=BEi=C5=ABnas?= <vincas@ciziunas.com>
Date: Thu, 22 Jun 2006 09:02:30 -0400
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Samsung T809/D820 association issues.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

Thanks for pointing me in the right direction.  I found the proper  
channel.  I do however keep having to delete my linux box as a device  
from the phone in order for it to keep permitting it, even if I  
'authorize' it.  I have a sneaky suspicion that this is due to the  
poor modification of the original D820 firmware to create the T809  
firmware.  That, however is another problem for another list.  Thanks  
again for your help!

--Vincas


On Jun 18, 2006, at 4:10 PM, Marcel Holtmann wrote:

> Hi Vincas,
>
>> When I try to get the computer to initiate, I get a "connection
>> refused".  Attached is the hcidump output of an  "echo ATZ > /dev/
>> rfcomm0" , which does result in "rfcomm0: connection refused".  I did
>> "Authorize" the linux box from the phone's menu, so I'm still
>> somewhat confused as to why it's denying.
>
> check with sdptool what services the phone supports on which channels.
>
> Regards
>
> Marcel
>
>
>
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
