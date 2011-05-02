Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTinwg4B3dTsWtUzZ8ji5FqGPHjHPyg@mail.gmail.com>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
	<1304123252-14464-7-git-send-email-andre.guedes@openbossa.org>
	<BANLkTinwg4B3dTsWtUzZ8ji5FqGPHjHPyg@mail.gmail.com>
Date: Mon, 2 May 2011 19:37:48 -0300
Message-ID: <BANLkTi=W0+6RWZDmjWmOT8FY3Rr=9Bo_Fg@mail.gmail.com>
Subject: Re: [RFC 06/16] Change DiscoverSchedulerInterval default value
From: Andre Guedes <andre.guedes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, May 2, 2011 at 4:48 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Andre,
>
> On Sat, Apr 30, 2011 at 3:27 AM, Andre Guedes
> <andre.guedes@openbossa.org> wrote:
>> This patch changes the default value of "DiscoverSchedulerInterval"
>> from 0 to 30 seconds.
>>
>> Since Periodic Inquiry is not supported anymore, the option
>> "DiscoverSchedulerInterval" in main.conf must be updated. As
>> a first attempt, it was chosen a 30 seconds interval.
>> ---
>>  src/main.conf |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/main.conf b/src/main.conf
>> index c03f135..8cd132f 100644
>> --- a/src/main.conf
>> +++ b/src/main.conf
>> @@ -27,8 +27,8 @@ PairableTimeout = 0
>>  PageTimeout = 8192
>>
>>  # Discover scheduler interval used in Adapter.DiscoverDevices
>> -# The value is in seconds. Defaults is 0 to use controller scheduler.
>> -DiscoverSchedulerInterval = 0
>> +# The value is in seconds. Defaults is 30.
>> +DiscoverSchedulerInterval = 30
>>
>>  # What value should be assumed for the adapter Powered property when
>>  # SetProperty(Powered, ...) hasn't been called yet. Defaults to true
>
> Im not sure how you came up with 30 sec, IMO it is too long and
> doesn't specify how long we inquiry/scan/resolve names.
>

30 sec was a reasonable time we firstly thought. But as I said, it is
just a first
attempt. How long you think it is a good interval value?

Yes. It doesn't specify how long the whole discovery process takes. It specifies
how long the adapter is gonna wait in IDLE state before trigger the a new
discovery procedure. We changed this behavior because it would become very
tricky to predict how long the name resolving is gonna take since it depends on
the number of devices found during discovery.

I think this is not clear in the patch description, so I rewrite it. Thanks.

> --
> Luiz Augusto von Dentz
> Computer Engineer
>

--
Andre Guedes
