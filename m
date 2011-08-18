Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v6YJJ64DCD9pnPyZGYDOQep3qWhuiWC+qaR=_+3ichQBA@mail.gmail.com>
References: <CA+GuLwdbSoT-iZg9EjTbxidr+fEE-KU8qgOZAyr_h05Gq9Xrgg@mail.gmail.com>
	<CAMOw1v6YJJ64DCD9pnPyZGYDOQep3qWhuiWC+qaR=_+3ichQBA@mail.gmail.com>
Date: Thu, 18 Aug 2011 13:45:44 -0700
Message-ID: <CA+GuLwfL0mK-VFimk=B64nqMDrQNReOoe0bMSLGwEKh7TRm=OA@mail.gmail.com>
Subject: Re: need help with bluez pairing/connecting device
From: Ram Bhamidipaty <rambham@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 18, 2011 at 1:12 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> On Thu, Aug 18, 2011 at 2:53 PM, Ram Bhamidipaty <rambham@gmail.com> wrote:
>> I am writing some new software that talks to bluez-4.96.
>>
>> I have some how gotten a device into a weird state. When I make
>> a dbus call to org.bluez.Adapter.GetProperties
>> I see my target device in the list:
>>
>>       dict entry(
>>         string "Devices"
>>         variant             array [
>>               object path "/org/bluez/8090/hci0/dev_00_22_48_85_50_1D"
>>            ]
>>      )
>>
>>
>> When a device is listed here - what does it mean? I am guessing that
>> at this point the pairing process is over. Or does it mean something else?
>
> It's the list of devices already paired. So, if you paired anytime
> before, the device will appear in this list.


Thank you. This helps me understand this.




>
>
>>
>> However the device is not yet connected. So I next try to connect:
>>
>> dbus-send --system --type=method_call --print-reply --dest=org.bluez
>> /org/bluez/8090/hci0/dev_00_22_48_85_50_1D org.bluez.Input.Connect
>>
>> This fails with a cryptic:
>>
>> Error org.bluez.Error.Failed: Host is down (112)
>
> It's because the other host is down (sic.). The fact that this path
> exists doesn't means the device is around, it just means that some
> time ago you paired it with this adapter. Turn the devices on and try
> again.
>

Thanks! In this case the device was in fact on. But it might be that the
pairing information was somehow stale. Removing the device and
re-pairing seemed to help.

-Ram
