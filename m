Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110131084038.GB10034@jh-x301>
References: <1296254017-3381-1-git-send-email-claudio.takahasi@openbossa.org>
	<1296254017-3381-2-git-send-email-claudio.takahasi@openbossa.org>
	<20110131084038.GB10034@jh-x301>
Date: Mon, 31 Jan 2011 11:50:30 -0200
Message-ID: <AANLkTinUQozBxDAUH4yKW93h6bEKy=WtWWwkJumYYYHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add option to enable privacy during scanning to hcitool
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Jan 31, 2011 at 6:40 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Fri, Jan 28, 2011, Claudio Takahasi wrote:
>> When privacy is enabled, random address is used during active scanning.
>> The non-resolvable private address shall be set using hciconfig.
>> ---
>>  tools/hcitool.c |   13 +++++++++----
>>  1 files changed, 9 insertions(+), 4 deletions(-)
>
> Both patches have been pushed upstream. Thanks.
>
> Any plans how to represent this feature in the official APIs? I suppose
> the random address can be generated automatically using some appropriate
> source such as the HCI_LE_Rand command but how do we represent the
> public vs random address selection using the D-Bus API? Or do we even
> need to do that?
>
> Johan
>

I added these changes to investigate the PTS  test result, it is not
mandatory. I am was planning to focus on Register Application API
first instead of privacy for central. The implementation is simple, if
someone in the community wants to help us, here are some guidelines:

My idea is add a new property in the adapter interface called:
Privacy. The changes will be:
1. Add Privacy property with persistent storage =>
adapter.SetProperty("Privacy", True/False)
2. Generate a non-resolvable private address. My suggestion is to read
the data directly from "/dev/random" instead of use HCI_LE_Rand
command(needs to wait for command complete).
3. Trigger the LE scanning based on this property.

PS: For LE Create Connection command the own address type must be set
based on privacy value, however this change requires changes in the
kernel. Currently, Own_Address_Type is hard-coded in the kernel(public
address only).

Regards,
Claudio.
