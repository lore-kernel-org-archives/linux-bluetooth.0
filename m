Return-Path: <cyrus@holtmann.org>
Message-ID: <50A4C2BF.3050807@linux.intel.com>
Date: Thu, 15 Nov 2012 11:23:59 +0100
From: =?UTF-8?B?RnLDqWTDqXJpYyBEYWxsZWF1?=
	<frederic.dalleau@linux.intel.com>
Reply-To: frederic.dalleau@linux.intel.com
MIME-Version: 1.0
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 09/16] sbc: Use simd primitive if doing msbc on neon
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com> <1351589975-22640-10-git-send-email-frederic.dalleau@linux.intel.com> <20121114212703.0d8bf8cd@i7>
In-Reply-To: <20121114212703.0d8bf8cd@i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
On 11/14/2012 08:27 PM, Siarhei Siamashka wrote:
> On Tue, 30 Oct 2012 10:39:28 +0100
>> +	if (state->increment == 1)
>> +		state->sbc_analyze_8s = sbc_analyze_1b_8s_simd;
>>   #endif
>>   }
>
> This is not enough. As I commented earlier in
>      http://permalink.gmane.org/gmane.linux.bluez.kernel/31567
>
> "neon code also provides optimized "sbc_enc_process_input_*" functions,
> which are not going to work correctly for mSBC:
>
> 	state->sbc_enc_process_input_8s_le = sbc_enc_process_input_8s_le_neon;
> 	state->sbc_enc_process_input_8s_be = sbc_enc_process_input_8s_be_neon;"

Indeed, this is a mistake :
I wanted to use the neon analysis in conjonction with simd input processing.

Instead, the patch would look like this :
+ if (state->increment == 1) {
+ 	state->sbc_enc_process_input_8s_be = 	
+					sbc_enc_process_input_8s_be;
+	state->sbc_enc_process_input_8s_le =
+					sbc_enc_process_input_8s_le;
+ }
Damned it is 82 chars long!

Unfortunately I can't test this one. I can't even build it. I could but 
that's gonna take a lot of time.

Regards,
Frédéric
