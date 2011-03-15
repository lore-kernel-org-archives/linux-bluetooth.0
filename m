Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110315075742.GD4369@null>
References: <1299850377-3734-1-git-send-email-andre.guedes@openbossa.org>
	<20110315075742.GD4369@null>
Date: Tue, 15 Mar 2011 10:41:55 -0400
Message-ID: <AANLkTikK4vjMgpuBHMLP4-6J2JMMnWqbaDo1-rwFsjEY@mail.gmail.com>
Subject: Re: [RFC v2 0/6] LE advertising cache
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: ext Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

On Tue, Mar 15, 2011 at 3:57 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
> Hi,
>
> On Fri, Mar 11, 2011 at 10:32:51AM -0300, ext Andre Guedes wrote:
>> During a LE connection establishment, the host should be able to infer the
>> bdaddr type from a given bdaddr.
>>
>> To achieve that, during the LE scanning, the host stores the bdaddr and the
>> bdaddr type gathered from advertising reports. The host keeps a list of
>> advertising entry (bdaddr and bdaddr_type) for later lookup. This list will
>> be called Advertising Cache.
>>
>> Since the penality to connect to an unreachable device is relatively high,
>> we must keep only fresh advertising entries on the advertising cache. So,
>> before each LE scanning the advertising cache is cleared. Also, after the LE
>> scanning, a timer is set to clear the cache.
>
> I tested these pathes with a device which had random address. Connection works
> which is good.
>
> How ever I'm not yet sure if mandatory scanning before every connect is
> acceptable.

IIRC the connection procedure defined on the spec requires this scan.
See for instance the general connection establishment procedure at
page 1715

>
> I have been playing with idea to derive address type from msb bits of the
> address. Any ideaѕ what would lose in that way?

How can you differ public address type from a random one in this case?
I think the MSB bit checking is only for detecting the type of random
address (static, non-resolvable private, resolvable private)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
