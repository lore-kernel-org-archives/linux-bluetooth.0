Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b2bd7735f166b59b11369eb37d0b4d75@nleyten.com>
References: <e40dc0a21f7080547028dfb7dad6eb65@nleyten.com> <b2bd7735f166b59b11369eb37d0b4d75@nleyten.com>
From: Petri Gynther <pgynther@google.com>
Date: Fri, 13 Jan 2017 11:21:10 -0800
Message-ID: <CAGXr9JE85t=__QUuxLO3fH_=9A=4kyN4KC2wXCALjFy8DOqerQ@mail.gmail.com>
Subject: Re: LEAdvertisement interface on older kernels
To: Dario Teixeira <dario.teixeira@nleyten.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-bluetooth-owner@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dario,

On Fri, Jan 13, 2017 at 9:19 AM, Dario Teixeira
<dario.teixeira@nleyten.com> wrote:
> Hi,
>
>> I've manually compiled the latest Bluez (5.43) on both Raspberry Pi 2
>> and Artik 5 systems, as I need the experimental features for BLE enabled.
>> While on the Pi things work as expected, on the Artik 5 the
>> "LEAdvertisement"
>> interface is not enabled.  Upon closer inspection, the bluetoothd daemon
>> on the Artik 5 complains on startup with the following error:
>>
>>   "Failed to read advertising features: Unknown Command (0x01)"
>>
>> I suspect the problem may be related to the old kernel (3.10.93)
>> that ships with the Artik 5, because these features may require
>> a more recent kernel.  Is this suspicion correct?  And if so,
>> is there any other solution besides attempting to compile a
>> newer kernel for the Artik 5?
>
>
> In the meantime I've found some information which confirms my
> initial suspicion: BLE advertising features require kernel >= 4.1,
> and therefore it's hopeless to use the Artik 5 for this purpose,
> because its heavily patched vendor kernel is stuck at 3.10.93,
> possibly forever...

If you have access to Artik 5 kernel 3.10.93 source, you could:
1. recompile that kernel with all Bluetooth components disabled
2. use Linux backports to pick up the latest Bluetooth kernel core and
drivers as a loadable module
    http://drvbp1.linux-foundation.org/~mcgrof/rel-html/backports/

>
>
> Best regards,
> Dario Teixeira
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
