Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4291FB2A.2090107@lesagepono.be>
From: Laurent Lesage <laurent@lesagepono.be>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] want to use M3000 bluetooth headset to receive
 voice calls on PC
References: <4291D7B2.3070703@lesagepono.be> <4291E789.1000506@xmission.com> <4291EFA9.3050803@lesagepono.be> <4291F3F7.2030905@xmission.com>
In-Reply-To: <4291F3F7.2030905@xmission.com>
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
Date: Mon, 23 May 2005 15:47:54 +0000

Good. It's more clear for me now.

Last but not least : I use Debian Sarge with 2.6.8 kernel. It's said on=20
the blue-alsa project, that you must use 2.6.11 : must I? does it work=20
only this way?

Laurent

Brad Midgley a =E9crit :

> Laurent,
>
> any recent CSR based dongle, such as the dbt-120, should work well.
>
> yes, we have the headset working through /dev/dsp
>
> hands-free and headset are two bluetooth profiles. most new sets=20
> support both profiles. we use the headset profile which is simpler.
>
> brad
>
> Laurent Lesage wrote:
>
>> Hi Brad,
>>
>> thanks for this super-fast answer! I saw that link yesterday but as=20
>> I'm newbie, this was not sure that differents models have the same=20
>> components and the same features. What about the BT dongle to use=20
>> with? And If I understand well (?!), the headset could be used like=20
>> /dev/dsp ie like any audio device? Am I right? Excuse-me but I try to=20
>> understant the difference between "hands-free" and "headset?
>>
>> thanks
>>
>> Laurent
>>
>>
>> Brad Midgley a =E9crit :
>>
>>> Laurent,
>>>
>>> I have a list of headsets people have reported success with at=20
>>> http://bluetooth-alsa.sourceforge.net/
>>>
>>> I've used the plantronics m2500 and I imagine the 3000 works the=20
>>> same. The 2500 is a real pain to turn on and off... hopefully they=20
>>> fixed that, or you just leave it on.
>>>
>>> Brad
>>>
>>> Laurent Lesage wrote:
>>>
>>>> Hi all,
>>>>
>>>> I've been looking for hours on the net to see if the Plantronics M30=
00
>>>> can be used with a bluetooth dongle (DBT-120 seems good? Or Lynksys
>>>> USBBT100, or trendnet TBW-102UB?) under Linux OS
>>>> (I use Debian Sarge). I don't see this headset in the 'features'=20
>>>> page Mr
>>>> Holtmann maintains. Does it mean it is not supported? it has the
>>>> advantage to be good quality,, and I can get one for cheap.
>>>>
>>>> If not, what model could be used (I want it to use as headset fot PC
>>>> phone, to be able to receive VOIP calls, and more with Asterisk=20
>>>> server).
>>>> It seems more difficult to make calls but it is not important for no=
w.
>>>>
>>>> Thank you for your attention
>>>>
>>>>
>>>
>>>
>>> -------------------------------------------------------
>>> This SF.Net email is sponsored by Oracle Space Sweepstakes
>>> Want to be the first software developer in space?
>>> Enter now for the Oracle Space Sweepstakes!
>>> http://ads.osdn.com/?ad_id=3D7412&alloc_id=3D16344&op=3Dclick
>>> _______________________________________________
>>> Bluez-users mailing list
>>> Bluez-users@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>>
>>>
>>
>>
>>
>> -------------------------------------------------------
>> This SF.Net email is sponsored by Oracle Space Sweepstakes
>> Want to be the first software developer in space?
>> Enter now for the Oracle Space Sweepstakes!
>> http://ads.osdn.com/?ad_idt12&alloc_id=16344&op=3Dclick
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-user
>> s
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=3D7412&alloc_id=3D16344&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
