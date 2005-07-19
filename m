Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42DD1710.7030006@cefriel.it>
From: Luca Pizzamiglio <pizzamiglio@cefriel.it>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] At commands not available
References: <20b987f505071611066dd13083@mail.gmail.com>	 <Pine.LNX.4.33.0507162023200.4834-100000@redbean.intranet.gw-instruments.de> <20b987f5050716121359298b52@mail.gmail.com>
In-Reply-To: <20b987f5050716121359298b52@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 19 Jul 2005 17:06:56 +0200

Hi Dirk. I've tried your code on my system (bt dongle with i-mate SP3
phone), but my phone close the connection during receive.
I'm subsantially sure that the channel is right. When I try DUN channel
I obtain ERROR response, but when I use HF profile, the phone close the
connection. I obtain the same behaviour with HS channel.

Someone could help me to solve this problem?

thx in advance.

Cheers,
Pizza

Dirk Vanden Boer wrote:
> I believe DUN is channel 1, to be sure I tried every channel, nothing
> seems to work
> 
> Dirk
> 
> On 7/16/05, Peter Wippich <pewi@gw-instruments.de> wrote:
> 
>>Try DUN. But maybe the CBC command is only available on the physical port.
>>
>>Ciao,
>>
>>Peter
>>
>>
>>On Sat, 16 Jul 2005, Dirk Vanden Boer wrote:
>>
>>
>>>Thanks for pointing me to that. I was connecting to channel 4 (heaset
>>>service) which was wrong, I think I should be connecting to the serial
>>>port service (channel 1). But the CBC command is still not available.
>>>In fact the available commands listed with AT* are the same for
>>>channel 1 and 4.
>>>
>>>Dirk
>>>
>>>
>>>On 7/16/05, Peter Wippich <pewi@gw-instruments.de> wrote:
>>>
>>>>Hi Dirk,
>>>>
>>>>which service you are connecting to ??? If you connect to the wrong
>>>>service (channel) the phone may (shall !) only make available the AT
>>>>commands belonging to this service.
>>>>
>>>>Ciao,
>>>>
>>>>Peter
>>>>
>>>>
>>>>On Sat, 16 Jul 2005, Dirk Vanden Boer wrote:
>>>>
>>>>
>>>>>On 7/16/05, Fred Schaettgen <bluez-devel@schaettgen.de> wrote:
>>>>>
>>>>>>On Saturday, 16. July 2005 18:32, Dirk Vanden Boer wrote:
>>>>>>
>>>>>>>Hi,
>>>>>>>I'm trying to send AT commands to my mobile phone using an rfcomm
>>>>>>>connection. The connection seems to work because I can exectute some
>>>>>>>commands (like manufacturer name). But a whole bunch of commands are
>>>>>>>not available (eg. battery charge: "AT+CBC\r" returns ERROR). I can
>>>>>>>run the AT* command which lists the available commands but a lot of
>>>>>>>common commands are not in the list. Could it be that there is
>>>>>>>something wrong with my connection?
>>>>>>
>>>>>>Are you sure that this command should be supported at all? If you are
>>>>>>connecting to the handsfree service, then the phone probably does not have to
>>>>>>support it. At least I can't find +CBC in the handsfree spec. Phones are free
>>>>>>to support additional commands though, or at least they do support more in
>>>>>>practice. It works with a Nokia 6230 for instance, without any special
>>>>>>initialization.
>>>>>>
>>>>>>Fred
>>>>>
>>>>>The CBC command is listed in the developers guidelines document of the
>>>>>ericsson t68 phone, so I guess it should be available.
>>>>>
>>>>>Dirk

-------------------------------------------
Luca Pizzamiglio
CEFRIEL - Embedded Systems Design Unit
Via Fucini, 2 - 20133 MILANO (ITALY)
Phone:		+39 02 23954 343
e-mail:		pizzamiglio@cefriel.it
ICQ:		5046978
-------------------------------------------


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
