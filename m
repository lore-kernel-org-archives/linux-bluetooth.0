Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <00ac01c83704$8f17aef0$9901a8c0@kcoe74512670e8>
From: "Leiyu" <leiyu_83@163.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
References: <005b01c8366a$5b6e07b0$9901a8c0@kcoe74512670e8>	<475545AC.2030509@gmail.com><000d01c83672$7fecdbe0$9901a8c0@kcoe74512670e8>
	<47554E19.6000803@gmail.com>
Date: Wed, 5 Dec 2007 14:03:29 +0800
MIME-Version: 1.0
Subject: Re: [Bluez-users] how to use bluetooth audiotools	inbluez-utils-3.22
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Dear All,

I create ~/.asoundrc  and modify it to contain 
pcm.bluetooth {
   type bluetooth
   device 00:18:6a:00:01:06
}then call mplayer -ao alsa:device=bluetooth /wulai.mp3 to play musicthen meet the error:alsa-lib:pcm_bluetooth.c1240:(bluetooth_init) connection failalsa-init:playback open error: Connection refusedBest regards,Leiyu

----- Original Message ----- 
From: "Rahul Tank" <gr8rahul@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Sent: Tuesday, December 04, 2007 8:54 PM
Subject: Re: [Bluez-users] how to use bluetooth audiotools inbluez-utils-3.22


> Leiyu wrote:
>> Dear Rahul,
>>
>> I do not find ~/.asoundrc  in system, am I lack of something installed?
>>
>>   
> Create one manually :)
> 
> 
> regards,
> rahul !!
> 
>> Best regards,
>> Leiyu
>> ----- Original Message ----- 
>> From: "Rahul Tank" <gr8rahul@gmail.com>
>> To: "BlueZ users" <bluez-users@lists.sourceforge.net>
>> Sent: Tuesday, December 04, 2007 8:18 PM
>> Subject: Re: [Bluez-users] how to use bluetooth audio tools inbluez-utils-3.22
>>
>>
>>   
>>> Leiyu wrote:
>>>     
>>>> Dear All,
>>>>
>>>> I want to use sco or a2dp with bluetooth stereo headset to listen music,then install bluez-utils-3.22 with "--enable-audio" parameter.
>>>> I do not know what should be done next,may anyone give me a hint? Thanks very much
>>>>
>>>>   
>>>>       
>>> http://wiki.bluez.org/wiki/HOWTO/AudioDevices
>>>
>>>
>>> HTH,
>>>
>>> regards,
>>>   rahul
>>>
>>>     
>>>> Best regards,
>>>> Leiyu 
>>>> ------------------------------------------------------------------------
>>>>
>>>>       
>>   
> 
> 
> -------------------------------------------------------------------------
> SF.Net email is sponsored by: The Future of Linux Business White Paper
> from Novell.  From the desktop to the data center, Linux is going
> mainstream.  Let it simplify your IT future.
> http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
