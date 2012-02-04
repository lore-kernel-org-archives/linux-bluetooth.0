Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120203231712.GA4095@x220.globalsuite.net>
References: <1328310405-16329-1-git-send-email-vinicius.gomes@openbossa.org>
	<20120203231712.GA4095@x220.globalsuite.net>
Date: Sat, 4 Feb 2012 08:14:05 -0400
Message-ID: <CAJdJm_OFcUNiF9CO2++rjsiMUpR4h0m7UYxECycT4P-R4uEHDQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] device: Fix doing sdp discovery for LE devices
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan/Vinicius,

On Fri, Feb 3, 2012 at 7:17 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Vinicius,
>
> On Fri, Feb 03, 2012, Vinicius Costa Gomes wrote:
>> If ReverseServiceDiscovery is enabled and we are connected to a LE
>> device, we should do a Primary Service Discovery, not a SDP discovery
>> (which doesn't even make sense).
>> ---
>>
>> This patch assumes that it makes sense to reuse the ReverseServiceDiscovery
>> functionality for LE devices.
>>
>>
>>  src/device.c |    9 +++++++--
>>  1 files changed, 7 insertions(+), 2 deletions(-)
>
> Applied. Thanks. (and yes, I do think it should be fine to "reverse
> discover" LE services).

I'm fine as well, but due to the current Core spec restrictions, It is
unlikely BlueZ will act as slave/acceptor to this to be triggered on
valid scenarios. Unless we add support for single mode LE adapters, or
by "infringing" current Core spec's restriction and allow LE
connection between dual mode devices for testing purposes.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
