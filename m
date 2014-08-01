Return-Path: <cyrus@holtmann.org>
Message-ID: <53DBB8C7.8030800@xsilon.com>
Date: Fri, 01 Aug 2014 16:56:55 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-zigbee-devel@lists.sourceforge.net,
 linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
CC: Marcel Holtmann <marcel@holtmann.org>,
 Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] Simplify lowpan receive path so skb is
 freed in lowpan_rcv when dropped.
References: <53DBB278.7090106@xsilon.com> <53DBB610.6020503@pengutronix.de>
In-Reply-To: <53DBB610.6020503@pengutronix.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Later on in lowpan_process_data and in a another function IIRC the skb could potentially be copy expanded as we are uncompressing which results in a new skb.

- Martin.


On 01/08/14 16:45, Marc Kleine-Budde wrote:
> On 08/01/2014 05:30 PM, Martin Townsend wrote:
>> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
>> ---
>>  include/net/6lowpan.h         |  2 +-
>>  net/6lowpan/iphc.c            | 22 +++++++++++++---------
>>  net/bluetooth/6lowpan.c       | 12 ++++++++----
>>  net/ieee802154/6lowpan_rtnl.c | 12 ++++++------
>>  4 files changed, 28 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
>> index d7e9169..aa0381e 100644
>> --- a/include/net/6lowpan.h
>> +++ b/include/net/6lowpan.h
>> @@ -374,7 +374,7 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
>>  
>>  typedef int (*skb_delivery_cb)(struct sk_buff *skb);
>>  
>> -int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>> +int lowpan_process_data(struct sk_buff **skb_inout, struct net_device *dev,
> Why do you make the first parameter a double pointer?
>
> Marc
>
