Return-Path: <cyrus@holtmann.org>
Message-ID: <5267C3DC.6070004@linux.intel.com>
Date: Wed, 23 Oct 2013 15:41:00 +0300
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 3/5] route: Exporting ip6_route_add() so that BLE 6LoWPAN
 can use it
References: <1382511164-1989-1-git-send-email-jukka.rissanen@linux.intel.com> <1382511164-1989-4-git-send-email-jukka.rissanen@linux.intel.com> <30925AE8-AE7B-43D9-9E5D-4898C0CF8390@holtmann.org>
In-Reply-To: <30925AE8-AE7B-43D9-9E5D-4898C0CF8390@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 23.10.2013 15:00, Marcel Holtmann wrote:
> Hi Jukka,
>
>> net/ipv6/route.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
>> index c979dd9..d7c200f 100644
>> --- a/net/ipv6/route.c
>> +++ b/net/ipv6/route.c
>> @@ -1662,6 +1662,7 @@ out:
>> 		dst_free(&rt->dst);
>> 	return err;
>> }
>> +EXPORT_SYMBOL_GPL(ip6_route_add);
>
> check with netdev is this is something that would be accepted upstream.

We could also tell userspace (bluez or connman) to create the route if 
needed.

>
> For the time being, can we work around this internally for testing? I like to just build and load a new Bluetooth module for testing and not have to replace IPv6 as well.

Sure, just do

ip -6 route add <peer>

after connecting the devices.

The peer link local address is perhaps easiest to get by using online 
calculator like http://ben.akrin.com/?p=1347



-- 
Cheers,
Jukka
