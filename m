Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC v2 7/9] bluetooth: btrtl: load the config blob from
 devicetree when available
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAL9uMOH0N-4jgQncmPjK-KyU0vY9Q0ZnHYSAGgz3z3ywzc8Avw@mail.gmail.com>
Date: Tue, 2 Jan 2018 12:38:23 +0100
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-serial@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com, johan@kernel.org,
        linux-amlogic@lists.infradead.org, Larry.Finger@lwfinger.net,
        Daniel Drake <drake@endlessm.com>
Message-Id: <F38429FB-2D20-4EF7-8547-E5A5D67D1618@holtmann.org>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
 <20180101204217.26165-8-martin.blumenstingl@googlemail.com>
 <563D6F9F-8495-40D4-BE56-5338ED2B9B99@holtmann.org>
 <CAL9uMOEMDup4hRkxD-tM8R0YirGs5uQi31AjJUnFCPNMKUdRHg@mail.gmail.com>
 <E8E39477-CF1A-4A3E-84C5-830E182C2266@holtmann.org>
 <CAL9uMOH0N-4jgQncmPjK-KyU0vY9Q0ZnHYSAGgz3z3ywzc8Avw@mail.gmail.com>
To: Carlo Caione <carlo@endlessm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Carlo,

>>>>> Some Realtek bluetooth devices need a "config" blob. The btrtl driver
>>>>> currently only allows loading this config blob via the request_firmware
>>>>> mechanism.
>>>>> 
>>>>> The UART Bluetooth chips use this config blob to specify the baudrate,
>>>>> whether flow control is used and some other unknown bits. This means
>>>>> that the config blob is board-specific - thus loading it via
>>>>> request_firmware means that the rootfs is tied to a specific board.
>>>>> 
>>>>> The UART Bluetooth chips are implemented through serdev. This means
>>>>> there is also a devicetree node which describes the Bluetooth chip.
>>>>> Thus we can also load the blob from the devicetree node to keep the
>>>>> filesystem independent of any board configuration data. In the future
>>>>> this could be extended to support ACPI as well (in case that's needed).
>>>>> 
>>>>> Parse the devicetree node if it exists and obtain the config blob from
>>>>> there. Otherwise fall back to using the "old" request_firmware
>>>>> mechanism.
>>>> 
>>>> where are these config blobs coming from? I think we also need to give people a helping hand on how to add them to DT. I still wonder if the only pieces we are using are the UART config, then maybe skipping the config blob and allowing for clear named values in DT might be better.
>>> 
>>> What about x86 platforms where we do not have DT (I didn't check but I
>>> don't think that the UART config in that case is shipped in the ACPI
>>> tables)?
>> 
>> if we have this hardware in x86 systems, then I would really like to see ACPI table dumps. Some pieces might need hardcoding based on ACPI ID.
> 
> Yes, we have, especially on cherry-trail SoCs. In [0] the DSDT of a
> cherry-trail laptop shipping the rtl8723bs (device OBDA8723).
> 
> [0] https://gist.github.com/carlocaione/82bff95ababb67dd33f52a86e94ce3ff

so the BTHx entries normally come at least with the UART configuration. It would be useful check if it is actually correct. And then I think similar handling like what is done in hci_bcm.c and hci_intel.c needs to happen here.

I think that we extended serdev to ACPI as well. Don’t recall of the top of my head if these patches were merged or not. But if they are then it is as simple as a serdev DT based driver. Just add the appropriate _HID and got from there.

However now I think that moving towards making hci_h5.c more like generic abstraction like hci_h4.c and having a hci_rtl.c be specific for Realtek chips seems a bit cleaner direction. Frankly only H:4 and H:5 plain protocols should be used by btattach. And all others should go via serdev.

Regards

Marcel

