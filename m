Return-Path: <christophe.ricard@gmail.com>
Subject: Re: Bluetooth pairing using NFC
To: Szymon Janc <ext.szymon.janc@tieto.com>
References: <CALD+uuz7Xoc6k0DXbuwOzc7zj0z2cN70A4j-VafcWqeTM1VYTQ@mail.gmail.com>
 <577136F7.4090505@gmail.com> <10190122.Hd9JXv7fO7@leonov>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
From: Christophe Ricard <christophe.ricard@gmail.com>
Message-ID: <57714295.9060809@gmail.com>
Date: Mon, 27 Jun 2016 17:13:25 +0200
MIME-Version: 1.0
In-Reply-To: <10190122.Hd9JXv7fO7@leonov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

Thanks a lot for your feedback.

I will try that :).

Best Regards
Christophe

On 27/06/2016 16:56, Szymon Janc wrote:
> Hi Christophe,
>
> On Monday 27 of June 2016 16:23:51 Christophe Ricard wrote:
>> Hi,
>>
>> I have been trying to get bluetooth pairing working using NFC (bluez
>> together with neard).
>> I am using a NFC enabled bluetooth headset (Mototorola Elite Silver).
>>
>> I have been trying with bluez 5.23 up to 5.40 as well as with neard 0.9
>> up to neard 0.15 but without success so far.
>> Bluez shows a message push_oob() but no pairing is happening. When
>> looking at the code, i have suspected an agent issue
>> but this is out of my knowledge scope.
>>
>> Can anybody suggest what would be the best bluez/neard combination to
>> get nfc/bluetooth pairing to work or to track down this to get
>> it working ?
>>
>> I can provide traces if you need.
> I didn't look at that code for quite some time but I think to get it work
> you need to have adapter powered up and have bluetooth agent registered.
>
> So doing: 'power up', 'agent on' 'default-agent' from bluetoothctl should do.
>
> PS
> Mailing list is linux-bluetooth@vger.kernel.org :)
>
