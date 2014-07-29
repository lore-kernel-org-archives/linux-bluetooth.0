Return-Path: <cyrus@holtmann.org>
Message-ID: <53D75517.5080702@mentor.com>
Date: Tue, 29 Jul 2014 09:02:31 +0100
From: Dean Jenkins <Dean_Jenkins@mentor.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>
Subject: Re: [RFC] Bluetooth: Make rfcomm_dlc_clear_timer() SMP safe
References: <1406293092-3000-1-git-send-email-Dean_Jenkins@mentor.com> <F0748C5B-79D6-4B34-BA55-7E1715AC43BA@holtmann.org>
In-Reply-To: <F0748C5B-79D6-4B34-BA55-7E1715AC43BA@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 28/07/14 23:36, Marcel Holtmann wrote:
> Hi Dean,
>
>> rfcomm_dlc_clear_timer() is used to cancel the timer
>> expiry callback rfcomm_dlc_timeout(). However, del_timer()
>> was used to cancel the timer which is not always SMP safe.
>>
>> If del_timer() returns a non-zero result then
>> rfcomm_dlc_clear_timer() calls rfcomm_dlc_put(d) which decrements
>> d->refcnt and if the refcnt becomes zero it frees the structure
>> rfcomm_dlc pointed to by d.
>>
>> If rfcomm_dlc_timeout() runs then it also calls rfcomm_dlc_put(d)
>> which decrements d->refcnt and if the refcnt becomes zero it frees
>> the structure rfcomm_dlc pointed to by d.
>>
>> del_timer() may not prevent rfcomm_dlc_timeout() running on
>> another CPU when del_timer() returns a non-zero value. This race
>> condition allows rfcomm_dlc_put(d) to be called twice which
>> results in a malfunction of the refcnt value as the refcnt is
>> decremented 1 time too many. This potentially leads to an early
>> freeing of the rfcomm_dlc structure. Consequently, further decrements
>> of d->refcnt may be performed on freed memory which will cause memory
>> corruption.
>>
>> The solution is to use del_timer_sync() instead of del_timer()
>> because del_timer_sync() will wait for rfcomm_dlc_timeout() to
>> complete execution (assumes rfcomm_dlc_timeout() was scheduled
>> to run at the point del_timer_sync() was called).
>>
>> Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
>> ---
>> net/bluetooth/rfcomm/core.c |    2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
>> index af73bc3..f9de2ee 100644
>> --- a/net/bluetooth/rfcomm/core.c
>> +++ b/net/bluetooth/rfcomm/core.c
>> @@ -279,7 +279,7 @@ static void rfcomm_dlc_clear_timer(struct rfcomm_dlc *d)
>> {
>> 	BT_DBG("dlc %p state %ld", d, d->state);
>>
>> -	if (del_timer(&d->timer))
>> +	if (del_timer_sync(&d->timer))
>> 		rfcomm_dlc_put(d);
> I have no objections here and the explanation looks good. Any reason why you are posting this as RFC and not as patch. I assume you have tested this and verified that it fixes the described race condition.
Thanks for your feedback. Thanks for agreeing with my explanation.

I posted it as RFC because it has not yet been tested.

On our multi-core ARM based embedded system, we observe use-after-free 
memory corruption which potentially could be due to a rogue reference 
counter decrement. Consequently, we started looking for reference 
counters in the kernel which used del_timer() before decrementing the 
reference counter.

Therefore, the proposed change is theoretical and is based on the known 
weakness of del_timer() in SMP systems.

It is a challenge to test it due to the small probability of the race 
occurring. However, we will endeavour to run some tests and get back to you.

Thanks,

Regards,
Dean Jenkins
Mentor Graphics
