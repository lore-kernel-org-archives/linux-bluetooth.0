Return-Path: <cyrus@holtmann.org>
Message-ID: <4AAF2C28.6000204@Atheros.com>
Date: Tue, 15 Sep 2009 11:24:48 +0530
From: Sasikiran Maddula <Madula.Sasikiran@Atheros.com>
MIME-Version: 1.0
To: <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Bluez stack issue with sco after headset profile disconnect
References: <4AAA55D0.1050505@Atheros.com> <20090914121345.GA3276@jh-x301>
In-Reply-To: <20090914121345.GA3276@jh-x301>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Thanks for your suggestion. Will try with the buez version 4.42 or later.

Hi Marcel,

Could you please suggest me the kernel version that has the fix for the 
skype sco issue even after disconnection in bluetooth. I tried with the 
2.6.28. Do you want me to try with 2.6.31?

Thanks,
Sasikiran.

Johan Hedberg wrote:
> Hi Sasikiran,
>
> On Fri, Sep 11, 2009, Sasikiran Maddula wrote:
>   
>> I verified with different dongles in linux. The behavior is same in all
>> the cases. Firstly we will connect the headset using headset profile. We
>> will start skype call / some other sco connection. We will disconnect
>> the headset service from the headset profile. hcitool con says sco
>> connection is still available after disconnection successful. So, some
>> body suggest me how to stop the sco connection when we disconnect the
>> service.
>>     
>
> You haven't mentioned which bluez and kernel versions you use but there
> was a bug like this which got fixed. The fix was to call shutdown() before
> close() for the SCO socket in bluetoothd (to force a disconnection even
> though other processes, like skype, have copy of the socket), and add a
> proper shutdown handler for SCO sockets on the kernel side. So you need
> both the userspace fix (part of bluez since 4.42) as well as the kernel
> fix. I'm not sure exactly which kernel version is needed but maybe Marcel
> has an idea.
>
> bluez patch:
> http://git.kernel.org/?p=bluetooth/bluez.git;a=commitdiff;h=45873a73136b4c76353e445b8c6891b99dff89ce
> kernel patch:
> http://git.kernel.org/?p=linux/kernel/git/holtmann/bluetooth-testing.git;a=commitdiff;h=a0ed7b886953a1953d4aa6b3357c06096adb9cc7
>
> Johan
>   
