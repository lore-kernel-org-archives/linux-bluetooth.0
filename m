Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42BC2399.7090007@ibdcon.org.br>
From: Paulo Wollny <paulo.wollny@ibdcon.org.br>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] problem building btsco.
References: <42BC08BA.10603@ibdcon.org.br>	 <1119620816.3896.210.camel@baroque.rococosoft.com>	 <42BC17FC.6080506@ibdcon.org.br> <1119623544.3896.221.camel@baroque.rococosoft.com> <42BC20DF.9030305@ibdcon.org.br>
In-Reply-To: <42BC20DF.9030305@ibdcon.org.br>
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
Date: Fri, 24 Jun 2005 12:15:37 -0300

When i try to browse my phone, i get this:

Device Discovery Info
  Discovery Time: Fr Jun 24 12:13:20 BRT 2005
  Bluetooth Device Address: 00:01:E3:43:D0:2C
  Bluetooth Device Name: PWS65

Services
Failed to connect to SDP server on 00:01:E3:43:D0:2C: Function not 
implemented


Paulo Wollny wrote:
> Hi Steve,
> 
> My distribution is suse 9.1 and i upgraded all the bluez packages from 
> suse 9.3. Is working... kbluetoothd, kbtobexclient (i can call it), 
> kbtobexsrv, multisync.
> 
> I found out that kbtobexsrv is no more a standalone program.. but is 
> called from kbluetoothd....
> When clicking on the kbluetoothd icon, i can see my phone, but trying to 
> browse it, i get LMP response timeout.....
> Is there any way to browse my phone contents?
> 
> Best regards and thx for helping me.
> 
> Paulo Wollny
> 
> Stephen Crane wrote:
> 
>> Hi Paolo,
>> What distribution is this? (You can kludge around your problem by
>> softlinking libsdp.so.2 to libbluetooth.so but this a hack.)
>>
>> Update kbtobexsrv or rebuild it from source.
>>
>> Cheers,
>> Steve
>>
>> On Fri, 2005-06-24 at 11:26 -0300, Paulo Wollny wrote:
>>
>>> Hi Steve,
>>>
>>> i did update of all teh bluez packages, but when trying to run 
>>> ktbobexsrv, i get the following message:
>>>
>>> kbtobexsrv: error while loading shared libraries: libsdp.so.2: cannot 
>>> open shared object file
>>>
>>> Any hint?
>>>
>>> I was able to build btsco.
>>>
>>> Best regards,
>>>
>>> Paulo Wollny
>>>
>>>
>>> Stephen Crane wrote:
>>>
>>>> Hi Paolo
>>>> It looks as if your version of bluez-libs is very old. Recent versions
>>>> have the sdp library merged in.
>>>>
>>>> Cheers,
>>>> Steve
>>>>
>>>> On Fri, 2005-06-24 at 10:20 -0300, Paulo Wollny wrote:
>>>>
>>>>
>>>>> Hi,
>>>>>
>>>>> i'm trying o build the btsco and am getting the following error. 
>>>>> Does anyone knows how to solve it?
>>>>>
>>>>> Kind regards,
>>>>>
>>>>> Paulo Wollny
>>>>>
>>>>> gcc -DHAVE_CONFIG_H -I. -I. -I..     -Wall -O2 -c `test -f 
>>>>> 'sbcinfo.c' || echo './'`sbcinfo.c
>>>>> gcc  -Wall -O2   -o sbcinfo  sbcinfo.o  -lasound -lm -ldl -lpthread
>>>>> gcc -DHAVE_CONFIG_H -I. -I. -I..     -Wall -O2 -c `test -f 
>>>>> 'sbcenc.c' || echo './'`sbcenc.c
>>>>> gcc  -Wall -O2   -o sbcenc  sbcenc.o libsbc.a -lasound -lm -ldl 
>>>>> -lpthread
>>>>> gcc -DHAVE_CONFIG_H -I. -I. -I..     -Wall -O2 -c `test -f 
>>>>> 'rcplay.c' || echo './'`rcplay.c
>>>>> gcc  -Wall -O2   -o rcplay  rcplay.o -lbluetooth -lasound -lm -ldl 
>>>>> -lpthread
>>>>> rcplay.o(.text+0xd0): In function `main':
>>>>> : undefined reference to `sdp_connect'
>>>>> rcplay.o(.text+0xed): In function `main':
>>>>> : undefined reference to `sdp_uuid16_create'
>>>>> rcplay.o(.text+0xf7): In function `main':
>>>>> : undefined reference to `sdp_list_append'
>>>>> rcplay.o(.text+0x11b): In function `main':
>>>>> : undefined reference to `sdp_list_append'
>>>>> rcplay.o(.text+0x12c): In function `main':
>>>>> : undefined reference to `sdp_list_append'
>>>>> rcplay.o(.text+0x141): In function `main':
>>>>> : undefined reference to `sdp_service_search_attr_req'
>>>>> rcplay.o(.text+0x14c): In function `main':
>>>>> : undefined reference to `sdp_close'
>>>>> rcplay.o(.text+0x18f): In function `main':
>>>>> : undefined reference to `sdp_get_access_protos'
>>>>> rcplay.o(.text+0x1a6): In function `main':
>>>>> : undefined reference to `sdp_get_proto_port'
>>>>> collect2: ld returned 1 exit status
>>>>> make[2]: *** [rcplay] Fehler 1
>>>>> make[2]: Leaving directory `/home/paulo/Bluetooth-Linux/btsco-0.4/sbc'
>>>>> make[1]: *** [all-recursive] Fehler 1
>>>>> make[1]: Leaving directory `/home/paulo/Bluetooth-Linux/btsco-0.4'
>>>>> make: *** [all] Fehler 2
>>>>>
>>>>>
>>>>> -------------------------------------------------------
>>>>> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
>>>>
>>>>
>>>>> from IBM. Find simple to follow Roadmaps, straightforward articles,
>>>>
>>>>
>>>>> informative Webcasts and more! Get everything you need to get up to
>>>>> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
>>>>> _______________________________________________
>>>>> Bluez-users mailing list
>>>>> Bluez-users@lists.sourceforge.net
>>>>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>>
>>>
>>>
>>> -------------------------------------------------------
>>> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
>>> from IBM. Find simple to follow Roadmaps, straightforward articles,
>>> informative Webcasts and more! Get everything you need to get up to
>>> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
>>> _______________________________________________
>>> Bluez-users mailing list
>>> Bluez-users@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/bluez-users
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
