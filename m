Return-Path: <cyrus@holtmann.org>
Message-ID: <527CAF36.3050709@linux.intel.com>
Date: Fri, 08 Nov 2013 11:30:30 +0200
From: Ravi Kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH_v2 06/11] android/hid: Fill send data structure variables
 in hal-hidhost
References: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1383862220-29968-7-git-send-email-ravikumar.veeramally@linux.intel.com> <20131108091715.GA24795@x220.p-661hnu-f1>
In-Reply-To: <20131108091715.GA24795@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11/08/2013 11:17 AM, Johan Hedberg wrote:
> Hi Ravi,
>
> On Fri, Nov 08, 2013, Ravi kumar Veeramally wrote:
>> ---
>>   android/hal-hidhost.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
> This doesn't compile:
>
>    CC       android/android_libhal_internal_la-hal-hidhost.lo
> android/hal-hidhost.c: In function 'send_data':
> android/hal-hidhost.c:356:2: error: implicit declaration of function 'free' [-Werror=implicit-function-declaration]
>    free(cmd);
>    ^
> android/hal-hidhost.c:356:2: error: incompatible implicit declaration of built-in function 'free' [-Werror]
> cc1: all warnings being treated as errors
> make[1]: *** [android/android_libhal_internal_la-hal-hidhost.lo] Error 1
>
  Ok, I will send _v3 of this and rest.

Thanks,
Ravi.
