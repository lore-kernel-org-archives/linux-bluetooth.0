Return-Path: <cyrus@holtmann.org>
Message-ID: <4ECBE029.7060406@codeaurora.org>
Date: Tue, 22 Nov 2011 09:47:21 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH-v4 6/9] Bluetooth: Cleanup blkcipher on SMP termination
References: <1321480400-17397-1-git-send-email-bgix@codeaurora.org> <1321480400-17397-7-git-send-email-bgix@codeaurora.org> <20111121154829.GC2552@joana>
In-Reply-To: <20111121154829.GC2552@joana>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo

On 11/21/2011 7:48 AM, Gustavo Padovan wrote:
[...]
>>   void smp_chan_destroy(struct l2cap_conn *conn)
>>   {
>> -	kfree(conn->smp_chan);
>> +	struct smp_chan *smp = conn->smp_chan;
>> +
>> +	if (smp&&  !IS_ERR(smp->tfm))
>> +		crypto_free_blkcipher(smp->tfm);
>
> smp->tfm doesn't say what you want, if its allocation failed its value is
> still 0. And I don't think we need to check for smp == NULL. It can't be null
> at this point.
>
> 	Gustavo

OK, so I see that smp_>tfm will never equal an Error, so that check is 
meaningless.

However, there are conditions where it can in fact be NULL, 
particularily if the user aborts the paring process, and looking at the 
blkcipher's FREE code, I am not confident that it couldn't get past the 
"unlikely" NULL checks with all compilation parameters, so we should 
keep at least a NULL check here.

As far as NULL checking "smp", I think we can avoid it, but only if we 
make sure that we clear the HCI_CONN_LE_SMP_PEND bit within the destroy 
function itself.  A cursory look at the usage doesn't fill me with 
confidence that the flag bit, and the allocation are rigorously kept in 
sync.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
