Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Problem with two dongle simultaneously
To: Nazmul Alam <fadedreamz@gmail.com>,
        Barry Byford <31baz66@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <CACjvaw=rr-MDiBZH6rM1BORBH372ZXLkSrxpPsKjP6dMGo4TZg@mail.gmail.com>
 <CABBYNZLTfTLUavm6uELEx-Xvei__+7qv-zb+=ih9ckHUvPmOMw@mail.gmail.com>
 <CAAu3APYPjb58hDZJ2imnp1Hrxi8JVsun_HnJfuQHFXNdfuZ1Qg@mail.gmail.com>
 <CACjvawnYg3kBnrDhMdbDo++y-nN0wX1CqCYFRNFrgVn4a0Ethg@mail.gmail.com>
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Message-ID: <90b2db65-6412-3523-b693-cea71da10d0a@invoxia.com>
Date: Thu, 20 Sep 2018 19:52:57 +0200
MIME-Version: 1.0
In-Reply-To: <CACjvawnYg3kBnrDhMdbDo++y-nN0wX1CqCYFRNFrgVn4a0Ethg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nazmul,

Just to share my experience....
For a project using BLE for firmware upgrade transfer and configuration 
of some IoT devices, I gather up to 10 USB dongles with BLE support. 1 
dongle used to scan for new devices, others for performing device 
upgrade and configuration in parallel pour every "device" discovered by 
the scan. The whole stuff was connected to a PC.

I was only using the bluez DBUS API directly using python scripts, 
standard dbus python extension (ie. import dbus) and glib mainloop for 
event handling which integrates fine with python dbus (ie. dbus signals 
handler).

The whole stuff works pretty well and was used in production line.

Bluez version 5.47 with experimental features enabled (which are now 
integrated in most recent bluez version)
Cheap CSR USB dongle (v4.0) are working fine in BLE (which was not the 
case of my integrated laptop bluetooth module...)

Regards,
Arnaud

On 20/09/2018 18:09, Nazmul Alam wrote:
> Hi Luiz and Barry,
> Thank you for the suggestions. I will try the latest bluez out.
>
> Regarding pygatt, I can double confirm they are using gatttool on the
> binary distribution provided by python package manager.
>
> Given that I used pygatt to get the data, I was evaluating the dbus
> c-api for data capture. But I don't wanted to jump into premature
> decision as I didn't know it this is an issue on the bluez side (if
> that was the case, no point using dbus api).
>
> Thank you again and I will get back once I do the testing.
> On Thu, Sep 20, 2018 at 10:06 AM Barry Byford <31baz66@gmail.com> wrote:
>> Hi Luiz,
>>
>> On Thu, 20 Sep 2018 at 10:16, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>
>>> Btw, pygatt appears to be using gatttool which is deprecated, not idea
>>> why people keep using that.
>> It seems they are aware of the situation:
>> https://github.com/peplin/pygatt/issues/112
>>
>> I suspect part of the problem is that the "wrong" answers are easier
>> to find with your favorite search engine....
