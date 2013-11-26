Return-Path: <cyrus@holtmann.org>
Message-ID: <52949EAF.2010806@linux.intel.com>
Date: Tue, 26 Nov 2013 15:14:23 +0200
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Subject: Re: [PATCH 1/4] android: Add CAP_NET_RAW capability
References: <1385387369-3015-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1385387369-3015-2-git-send-email-ravikumar.veeramally@linux.intel.com> <20131125140154.GA24659@x220.p-661hnu-f1> <52935B51.403@linux.intel.com> <20131125142532.GA26309@x220.p-661hnu-f1>
In-Reply-To: <20131125142532.GA26309@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 25.11.2013 16:25, Johan Hedberg wrote:
> Hi Ravi,
>
> On Mon, Nov 25, 2013, Ravi kumar Veeramally wrote:
>> On 25.11.2013 16:01, Johan Hedberg wrote:
>>> Hi Ravi,
>>>
>>> On Mon, Nov 25, 2013, Ravi kumar Veeramally wrote:
>>>> CAP_NET_RAW capability is required to up the bnep interfaces
>>>> in android environment.
>>>> ---
>>>>   android/main.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/android/main.c b/android/main.c
>>>> index c9733f3..bfd2a87 100644
>>>> --- a/android/main.c
>>>> +++ b/android/main.c
>>>> @@ -506,6 +506,7 @@ static bool set_capabilities(void)
>>>>   	header.pid = 0;
>>>>   	cap.effective = cap.permitted =
>>>> +		CAP_TO_MASK(CAP_NET_RAW) |
>>>>   		CAP_TO_MASK(CAP_NET_ADMIN) |
>>>>   		CAP_TO_MASK(CAP_NET_BIND_SERVICE);
>>>>   	cap.inheritable = 0;
>>> Would you then say that commit 9bda7e8c2130de9a3340ebd0e6cc1dedc2eae338
>>> is incorrect? A quick grep doesn't show any instances of checking this
>>> capability in the BNEP code of the kernel. Exactly which system call is
>>> it that needs it?
>>     bnep_if_up from profiles/network/common.c
>>   ---
>>          ifr.ifr_flags |= IFF_UP;
>>          ifr.ifr_flags |= IFF_MULTICAST;
>>
>>          err = ioctl(sk, SIOCSIFFLAGS, (caddr_t) &ifr);
>> ---
>>   requires this capability in android environment only.
>>   this code is under android macro.
> So you've verified that under "normal" Linux this ioctl does not require
> the NET_RAW capability?
>
>>> If you answered positively to my first question, please send a patch for
>>> that as well.
>>   I didn't understand this, sorry.
> My first question was: "Would you then say that
> commit 9bda7e8c2130de9a3340ebd0e6cc1dedc2eae338 is incorrect?". Do you
> not understand that question or what I asked you to do in case the
> answer is "yes"?

   I tried on host with systemd configure options and limiting 
capabilities to
  only CAP_NET_ADMIN and CAP_NET_BIND_SERVICE. ioctl call for 
interface(bnepX)
  up works well. Android throws an error("Permission denied"). 
CAP_NET_RAW is required
for android.

Thanks,
Ravi.
