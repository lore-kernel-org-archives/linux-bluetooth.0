Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BE676041-D159-4AE7-A4D4-D0BA4D983A70@holtmann.org>
References: <1399472233-19056-1-git-send-email-lukasz.rymanowski@tieto.com>
	<CAHZ1yC=3GQJLcuKV4FwRKcHLY2C5xFsQJh1FVpvabBWTpfWsTg@mail.gmail.com>
	<E4F0A858-85C9-4D2C-B716-4C58469A0465@holtmann.org>
	<CAHZ1yC=FOajpzi3GwrHU=Jqb5KFMCTPp7RPw8G+8KLDGR9DxyA@mail.gmail.com>
	<BE676041-D159-4AE7-A4D4-D0BA4D983A70@holtmann.org>
Date: Wed, 7 May 2014 22:48:13 +0200
Message-ID: <CAN_7+YZi9q4qhhCBU9Xs1xnhdKGu5wycNsoWHsSR9mp1KuyQtg@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: Update RSSI property description.
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Scott James Remnant <keybuk@google.com>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Szymon Janc <szymon.janc@tieto.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Wed, May 7, 2014 at 10:30 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Scott,
>
>>>>> RSSI property is inquiry RSSI and this should be stated here especially
>>>>> that we plan to add connection RSSI property soon.
>>>>
>>>> Does connection RSSI really need to be a separate property? Why can't
>>>> the same property be used for both? It's the same device after all.
>>>
>>> the problem is that they are different. They get measured differently. One is essentially tight to the Inquiry TX power and the other to the TX power of the connection. Results will be different. This has always been the problem with Bluetooth’s RSSI. Mapping the RSSI you got Extended Inquiry Result to Read RSSI is not possible.
>>>
>>
>> LE Devices aren't ever in a situation where they are Advertising
>> during a Connection though, right?
>
> they can be. Bluetooth 4.1 introduces link layer topology. As long as your controller supports this state, you can advertise again.
>

There is fancy table of supported states in BT core ver 4.1, Vol 2
Part E, Chapter 7.8.27.  You can indeed find there a combination where
device is connected and still can advertise.

>> So either the RSSI + TX Power are relevant to Inquiry (when Connected
>> = false) or relevant to Connection (when Connected = true)
>
> We can do that, but it is also semantic wise a bit of a nasty thing to do. The meaning of a property changes depending on if another property is true or false. Sounds like a hack to me.
>
>> Since the Connection RSSI on a Classic device is always just deviation
>> from the golden range, the RSSI field isn't even that interesting in
>> those cases.
>
> For BR/EDR this is mostly irrelevant. However in combination with TX power you can calculate the path loss and that makes it interesting again.
>
> Regards
>
> Marcel
>

BR
Lukasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
