Return-Path: <cyrus@holtmann.org>
Message-ID: <4C86BBC1.3020903@linux.intel.com>
Date: Wed, 08 Sep 2010 00:25:05 +0200
From: Sebastien Cayetanot <sebastien.cayetanot@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
Subject: Re: BD address changed but pairing failed
References: <4C80CE3E.8020004@linux.intel.com>	 <AANLkTi=9HR+iTm=baVdefQcd-Nb8Gchx3LN6q-CycMcq@mail.gmail.com>	 <4C84BFB2.3000802@linux.intel.com> <1283889495.6640.27.camel@localhost.localdomain>
In-Reply-To: <1283889495.6640.27.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

  Le 9/7/2010 9:58 PM, Marcel Holtmann a écrit :
> Hi Sebastien,
>
>>>> I'm currently facing an issue regarding the pairing of BT devices after
>>>> having change the BD_Addr.
>>>>
>>>>
>>>> I use a TI chip and also use hci command or bdaddr script to modify the
>>>> bd_addr
>>>>
>>>> I'm also using the bluez-4.69
>>>>
>>>> I change the BD_Addr using the bdaddr scripts provided into the bluez src.
>>>>
>>>> When other devices scan me, the new address is seen but hciconfig still show
>>>> the old BD address.
>>>>
>>>> I have sent the hcitool cmd to read the bd_addr and after the hciconfig
>>>> return the one.
>>>>
>>>> I'm discoverable with the new BD address.
>>>>
>>>> But When I try to pair an A2DP headset or BT Keyboard/Mouse it failed since
>>>> BD_Addr change.
>>>>
>>>> I have try to use directly the hcitool cmd using the vendor specific command
>>>> but I got the same result.
>>>>
>>>> I have tried to kill bluetooth daemon and restart it after having change the
>>>> bd_addr. Still failing.
>>>>
>>>> I have tried to kill bluetooth daemon before changing the BD adress and
>>>> start it after the change it still fail.
>>>>
>>>> I have also tried to power on/off interface. still the issue
>>>>
>>>> I think that something is "broken" is bluez when the BD_Addr is changed.
>>>>
>>>> Is someone already seen this issue ?
>>> I don't think you are suppose to change the address like that, it is
>>> supposed to be done once in the chip initialization and then keep it
>>> like that forever, so I guess there is something wrong if the chip is
>>> already initialize with the wrong address. What are you trying achieve
>>> with this?
>>>
>> Surely not but regarding some tests scripts I have seen on bluez, I
>> suppose that's possible. Perhaps, some chips support and other don't.
>>
>> I have tried to change the BD_Address during the BT initialization and
>> prior any HCI command sent to the chip and it works.
> all of them needed a special warm reset. The HCI_Reset was never enough.
> I might work on some Broadcom chips this way, but all others do need
> special reset magic.
>
>> I expected the same behavior than observed on WLAN :  I have changed the
>> WLAN MAC address after and everything works fine.
> The WiFi MAC address is different than a BD_ADDR. You can NOT expect any
> similar behavior. That they happen to be both IEEE addresses means
> nothing at all.
>
> Regards
>
> Marcel
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
We succeed to change the BD address and have a working system if you 
change the BD address prior to send any hci command during the BT driver 
boot.

Regards
