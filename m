Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42CA787D.7050105@ibdcon.org.br>
From: Paulo Wollny <paulo.wollny@ibdcon.org.br>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] problem compiling btsco....
References: <42C971CD.8050106@ibdcon.org.br> <42C99E83.8090305@xmission.com>
In-Reply-To: <42C99E83.8090305@xmission.com>
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
Date: Tue, 05 Jul 2005 09:09:33 -0300

Hi,

wher do i get this cvs?

Cheers,

Paulo

Brad Midgley wrote:
> you may have more luck with btsco from cvs with 2.6.12
> 
> Paulo Wollny wrote:
> 
>> Hi All,
>>
>> i'm trying to compile the kernel portion of btsco, but am getting the 
>> following errors:
>>
>> Does anyone knows what's going on?
>>
>> Best regards,
>>
>> Paulo Wollny
>>
>> hirschberg:/home/paulo/Bluetooth-Linux/btsco-0.4/kernel # make
>> make[1]: Entering directory `/usr/src/linux-2.6.5-7.155.29'
>>   CC [M]  /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.o
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c: In function 
>> `snd_card_bt_sco_playback_trigger':
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c:140: error: 
>> `snd_card_bt_sco_t_magic' undeclared (first use in this function)
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c:140: error: (Each 
>> undeclared identifier is reported only once
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c:140: error: for 
>> each function it appears in.)
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c: In function 
>> `snd_card_bt_sco_capture_trigger':
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c:161: error: 
>> `snd_card_bt_sco_t_magic' undeclared (first use in this function)
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c: In function 
>> `snd_card_bt_sco_playback_open':
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c:334: error: 
>> `snd_card_bt_sco_t_magic' undeclared (first use in this function)
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c: In function 
>> `snd_card_bt_sco_capture_open':
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c:367: error: 
>> `snd_card_bt_sco_t_magic' undeclared (first use in this function)
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c: In function 
>> `snd_card_bt_sco_playback_close':
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c:400: error: 
>> `snd_card_bt_sco_t_magic' undeclared (first use in this function)
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c: In function 
>> `snd_bt_sco_volume_get':
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c:497: error: 
>> `snd_card_bt_sco_t_magic' undeclared (first use in this function)
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c: In function 
>> `snd_bt_sco_volume_put':
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c:510: error: 
>> `snd_card_bt_sco_t_magic' undeclared (first use in this function)
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c: In function 
>> `snd_bt_sco_loopback_get':
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c:546: error: 
>> `snd_card_bt_sco_t_magic' undeclared (first use in this function)
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c: In function 
>> `snd_bt_sco_loopback_put':
>> /home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.c:558: error: 
>> `snd_card_bt_sco_t_magic' undeclared (first use in this function)
>> make[2]: *** [/home/paulo/Bluetooth-Linux/btsco-0.4/kernel/btsco.o] 
>> Fehler 1
>> make[1]: *** [_module_/home/paulo/Bluetooth-Linux/btsco-0.4/kernel] 
>> Fehler 2
>> make[1]: Leaving directory `/usr/src/linux-2.6.5-7.155.29'
>> make: *** [default] Fehler 2
>> hirschberg:/home/paulo/Bluetooth-Linux/btsco-0.4/kernel #
>>
>>
>> -------------------------------------------------------
>> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
>> from IBM. Find simple to follow Roadmaps, straightforward articles,
>> informative Webcasts and more! Get everything you need to get up to
>> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
