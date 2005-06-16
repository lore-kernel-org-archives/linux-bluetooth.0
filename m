Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42B1EB97.3040303@lesagepono.be>
From: Laurent Lesage <laurent@lesagepono.be>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] How can you give the pin without using the keyboard?
References: <42B1E0EA.7010304@lesagepono.be> <42B1E2A7.8070001@gmx.ch>
In-Reply-To: <42B1E2A7.8070001@gmx.ch>
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
Date: Thu, 16 Jun 2005 21:13:59 +0000

Thanks Marco, it works well. What is the "/etc/bluetooth/pin" file for,=20
then?

Laurent


Marco Trudel a =E9crit :

> Hello Laurent
>
> replace the pin_helper utility (referenced in hcid.conf) with a script=20
> that echoes your pin:
> echo PIN:1234
> if 1234 is your pin...
>
> regards
> Marco
>
>
> Laurent Lesage wrote:
>
>> Hi all,
>>
>> I would like to pair my headset without typing the pin on the=20
>> keyboard. I use the "auto" value for security in "hcid.conf" but the=20
>> PIN is asked every time I start to use the headset (once paired, it=20
>> is ok). I have a file 'pin' with the vlaue of the pin but it seems to=20
>> be of no use.
>>
>> Thanks
>>
>> Laurent
>>
>>
>> -------------------------------------------------------
>> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
>> from IBM. Find simple to follow Roadmaps, straightforward articles,
>> informative Webcasts and more! Get everything you need to get up to
>> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dc=
lick
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>
>>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dcl=
ick
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
