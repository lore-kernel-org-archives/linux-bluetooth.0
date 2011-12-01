Return-Path: <cyrus@holtmann.org>
Message-ID: <4ED7C8F2.20600@codeaurora.org>
Date: Thu, 01 Dec 2011 10:35:30 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH-v5 5/6] Bluetooth: Add MITM mechanism to LE-SMP
References: <1322065718-11570-1-git-send-email-bgix@codeaurora.org> <1322065718-11570-6-git-send-email-bgix@codeaurora.org> <20111201141135.GE2894@joana>
In-Reply-To: <20111201141135.GE2894@joana>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 12/1/2011 6:11 AM, Gustavo Padovan wrote:
> Hi Brian,

>> diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
>> index 15b97d5..43b6c49 100644
>> --- a/include/net/bluetooth/smp.h
>> +++ b/include/net/bluetooth/smp.h
>> @@ -124,6 +124,8 @@ struct smp_chan {
>>   	u8		pcnf[16]; /* SMP Pairing Confirm */
>>   	u8		tk[16]; /* SMP Temporary Key */
>>   	u8		smp_key_size;
>> +	u8		smp_tk_valid;
>> +	u8		smp_cfm_pending;
>
> Those two could be converted in a bitfield, you are using them as boolean.
>

Is there a mandate that bitfields must be manipulated/checked with the 
clear_bit/set_bit/test_bit prototypes?  Or can I just use a single u8 to 
represent both boolean values (as opposed to an unsigned long), and use 
standard &=, |= and & to set/clear/check?


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
