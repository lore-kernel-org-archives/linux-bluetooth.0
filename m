Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinUQozBxDAUH4yKW93h6bEKy=WtWWwkJumYYYHA@mail.gmail.com>
References: <1296254017-3381-1-git-send-email-claudio.takahasi@openbossa.org>
	<1296254017-3381-2-git-send-email-claudio.takahasi@openbossa.org>
	<20110131084038.GB10034@jh-x301>
	<AANLkTinUQozBxDAUH4yKW93h6bEKy=WtWWwkJumYYYHA@mail.gmail.com>
Date: Mon, 31 Jan 2011 17:46:58 +0200
Message-ID: <AANLkTimic7tgjGbsnzunHZN=KOu5kKoDzh45FfusKh=e@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add option to enable privacy during scanning to hcitool
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Jan 31, 2011 at 3:50 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Hi Johan,
>
> On Mon, Jan 31, 2011 at 6:40 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Hi Claudio,
>>
>> On Fri, Jan 28, 2011, Claudio Takahasi wrote:
>>> When privacy is enabled, random address is used during active scanning.
>>> The non-resolvable private address shall be set using hciconfig.
>>> ---
>>>  tools/hcitool.c |   13 +++++++++----
>>>  1 files changed, 9 insertions(+), 4 deletions(-)
>>
>> Both patches have been pushed upstream. Thanks.
>>
>> Any plans how to represent this feature in the official APIs? I suppose
>> the random address can be generated automatically using some appropriate
>> source such as the HCI_LE_Rand command but how do we represent the
>> public vs random address selection using the D-Bus API? Or do we even
>> need to do that?
>>
>> Johan
>>
>
> I added these changes to investigate the PTS  test result, it is not
> mandatory. I am was planning to focus on Register Application API
> first instead of privacy for central. The implementation is simple, if
> someone in the community wants to help us, here are some guidelines:
>
> My idea is add a new property in the adapter interface called:
> Privacy. The changes will be:
> 1. Add Privacy property with persistent storage =>
> adapter.SetProperty("Privacy", True/False)

Can this be unset, I mean can a device really use a random/private and
than latter switch to public? For what I understand if anyone pair
using the random/private address they don't store the actual address
but a key to resolve the address, so switching on runtime is IMO not a
good idea, perhaps a parameter on main.conf is enough?

Actually the spec say that there could be at least 3 types of random address:

- Static
- Private Non-resolvable
- Private Resolvable

> 2. Generate a non-resolvable private address. My suggestion is to read
> the data directly from "/dev/random" instead of use HCI_LE_Rand
> command(needs to wait for command complete).

I remember someone saying that the controller should be able to
generate a more random number because it uses the RF signal
interference for that, but Im not sure if this is actually true or
not, or if enough to give up the idea of using /dev/random.

> 3. Trigger the LE scanning based on this property.
>
> PS: For LE Create Connection command the own address type must be set
> based on privacy value, however this change requires changes in the
> kernel. Currently, Own_Address_Type is hard-coded in the kernel(public
> address only).

Yep, we probably need to start by fixing this, it seems some device
will already come with random addresses so it will be nice to have
this fixed asap.


-- 
Luiz Augusto von Dentz
Computer Engineer
