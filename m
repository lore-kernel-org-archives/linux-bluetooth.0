Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [RFC 1/4] addrconf: Create EUI48 IPv6 addresses for BTLE 6LoWPAN
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <1466408993-3808-1-git-send-email-patrik.flykt@linux.intel.com>
 <1466408993-3808-2-git-send-email-patrik.flykt@linux.intel.com>
 <CABBYNZKFnwzgR7mp5qOqibvqZjF3tfTcDB-+LsNkPwcYVPvrKw@mail.gmail.com>
Cc: Patrik Flykt <patrik.flykt@linux.intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <08dd8181-1854-5d9c-cf6f-9f3edc10d316@pengutronix.de>
Date: Tue, 22 Nov 2016 16:28:52 +0100
MIME-Version: 1.0
In-Reply-To: <CABBYNZKFnwzgR7mp5qOqibvqZjF3tfTcDB-+LsNkPwcYVPvrKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,

On 11/22/2016 01:26 PM, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Mon, Jun 20, 2016 at 10:49 AM, Patrik Flykt
> <patrik.flykt@linux.intel.com> wrote:
>> Create EUI48 IPv6 addresses for 6LoWPAN over Bluetooth Low Energy.
>> Both IEEE802.15.4 and Bluetooth Low Energy use a netdevice type of
>> ARPHRD_6LOWPAN, therefore generate the IPv6 address based on the
>> MAC address length.
>>
>> Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
>> ---
>>  net/ipv6/addrconf.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>> index 6c8fc3f..6697fe6 100644
>> --- a/net/ipv6/addrconf.c
>> +++ b/net/ipv6/addrconf.c
>> @@ -2055,6 +2055,10 @@ static int ipv6_generate_eui64(u8 *eui, struct net_device *dev)
>>         case ARPHRD_IPGRE:
>>                 return addrconf_ifid_gre(eui, dev);
>>         case ARPHRD_6LOWPAN:
>> +               /* 6LoWPAN over BTLE */
>> +               if (dev->addr_len == ETH_ALEN)
>> +                       return addrconf_ifid_eui48(eui, dev);
>> +
>>                 return addrconf_ifid_eui64(eui, dev);
>>         case ARPHRD_IEEE1394:
>>                 return addrconf_ifid_ieee1394(eui, dev);
>> --
>> 2.8.1
> 
> This still seems to be broken.
> 

I know. RFC-Series [0] fix that and more...

I think I need to rework the patch series but I think I didn't get much
review from bluetooth side yet.

E.g. what address type to use, etc.

I currently write my thesis so I have time for that maybe beginning of
april. Sorry, but Jukka can take the patches and send them I can
review/test it. So far I know Jukka is very busy with zephyr... so it
will be broken until april.

Or will somebody else catch the patches?

- Alex

[0] http://www.spinics.net/lists/linux-wpan/msg04124.html
