Return-Path: <cyrus@holtmann.org>
Message-ID: <512CFB38.8070701@mentor.com>
Date: Tue, 26 Feb 2013 18:13:12 +0000
From: Dean Jenkins <Dean_Jenkins@mentor.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Subject: Re: [PATCH 0/6] Bluetooth: Rework the RFCOMM session refcnt
References: <1361810317-4005-1-git-send-email-dean_jenkins@mentor.com> <1361817164.3902.25.camel@aeonflux>
In-Reply-To: <1361817164.3902.25.camel@aeonflux>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 25/02/13 18:32, Marcel Holtmann wrote:
> Hi Dean,
>
>> This patchset consists of the following 6 patches that reworks the RFCOMM
>> session refcnt by adding handling for a NULL RFCOMM session pointer when the
>> session has been deleted followed by removing the now redundant refcnt
>> mechanism:
>>
>> ----------------------------------------------------------------
>> Dean Jenkins (6):
>>        Bluetooth: Avoid rfcomm_session_timeout using freed session
>>        Bluetooth: Check rfcomm session and DLC exists on socket close
>>        Bluetooth: Return RFCOMM session ptrs to avoid freed session
>>        Bluetooth: Remove RFCOMM session refcnt
>>        Bluetooth: Remove redundant call to rfcomm_send_disc
>>        Bluetooth: Remove redundant RFCOMM BT_CLOSED settings
>>
>>   include/net/bluetooth/rfcomm.h |    6 ----
>>   net/bluetooth/rfcomm/core.c    |  163 ++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------
>>   2 files changed, 76 insertions(+), 93 deletions(-)
>>
>> The motivation for the change was RFCOMM kernel crashes in a 2.6.34 based ARM
>> SMP kernel. It is noted that RFCOMM in kernel 3.7 still contains the RFCOMM
>> session refcnt so the patches have been forward ported. Crashes were due to
>> malfunctions of the RFCOMM session refcnt such as premature deletion of the
>> session and double deletion of the session. Some crashes were caused by
>> the interaction of 2 kernel threads under very high processor loading.
>>
>> Note that the refcnt is incorrectly initialised, it should be set to 1 before
>> allowing the session structure to be used, the old code used a value of 0 and
>> this contributes to a weak implementation of the refcnt.
>>
>> In kernels later than 2.6.34, the threading model for RFCOMM was modified to
>> use work queues and this reduced the probability of a RFCOMM crash. This
>> helps to explain why the reports of RFCOMM crashes went away. However, the
>> implementation of the RFCOMM session refcnt is weak and is in fact logically
>> incorrect by using the RFCOMM data channel "initiator" flag. The control
>> channel disconnection procedures do not care about how the control channel
>> was established eg. by host or remote device request.
>>
>> The patches also make it clear when the RFCOMM session has been deleted by
>> using a NULL pointer. The old code has a possibility to access freed RFCOMM
>> session structures because there are multiple local copies of the pointer. The
>> patches ensure that local copies of the pointer are set to NULL when the
>> session has been deleted so avoiding any possibility of accessing freed memory.
>>
>> Therefore, the patchset cleans up the disconnection of the RFCOMM session
>> control channel and now the code is deterministic and is understandable by
>> code review.
>>
>> These patches were lightly tested against kernel 3.7.3 on a x86 PC. The design
>> of the patches were proven on a commercial project using a modified embedded ARM
>> SMP kernel 2.6.34.13. All previously observed RFCOMM control channel
>> disconnection kernel crashes on ARM 2.6.34.13 went away with the patches
>> applied.
> I looked through the patch set and could not spot anything obvious
> wrong. Thanks for looking into this. The RFCOMM reference counting has
> been always giving me a headache.
>
> Great job on the cover page and the commit messages. It was a pleasure
> to read them and then go through the code. Makes review a lot easier.
>
> On my account, lets get these patches in and see how they are doing.
> Once they are in bluetooth-next they get a bit wider expose on upstream
> kernels.
>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
>
> Regards
>
> Marcel
>
>
Many thanks for the encouraging feedback.

I wait with eager anticipation to see my patches in kernel.org and to 
see what feedback comes from upstream.

Thanks,

Regards,
Dean
