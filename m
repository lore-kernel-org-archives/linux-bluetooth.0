Return-Path: <cyrus@holtmann.org>
Message-ID: <4C9AD3D7.60207@Atheros.com>
Date: Thu, 23 Sep 2010 09:43:11 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: Pavan Savoy <pavan_savoy@sify.com>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [PATCH 2/2] Bluetooth: support to send power management enable
 during hci open
References: <1285075981-8941-1-git-send-email-suraj@atheros.com>	<1285075981-8941-2-git-send-email-suraj@atheros.com>	<AANLkTinS9YnKBUnv-RhV8ZZ185FtN_VDOWTQa3gTr6FC@mail.gmail.com>	<4C997F8C.5070104@Atheros.com> <AANLkTikKLi1m8xTjzU_aOs+XNstenjTAUSmgbQxOGnkC@mail.gmail.com>
In-Reply-To: <AANLkTikKLi1m8xTjzU_aOs+XNstenjTAUSmgbQxOGnkC@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

On 9/23/2010 2:52 AM, Pavan Savoy wrote:
> Suraj,
>
> On Tue, Sep 21, 2010 at 11:01 PM, Suraj Sumangala<suraj@atheros.com>  wrote:
>> Hi Pavan,
>>
>> On 9/22/2010 1:22 AM, Pavan Savoy wrote:
>>>
>>> On Tue, Sep 21, 2010 at 8:33 AM, Suraj Sumangala<suraj@atheros.com>
>>>   wrote:
>>>>
>>>> This patch enables HCI_UART_ATH3K transport driver to support
>>>> sending Vendor specific hci commands during hci open
>>>> to enable or disable power management feature.
>>>
>>> Why? shouldn't this be done from the hciattach? like for the other
>>> manufacturers?
>>> If you want it to be sent before hci0 interface is exposed, send it
>>> over ttyXX, you have your _init function and if you require it to be
>>> sent after the hci0 is exposed - do it in the _post function.
>>>
>> We are already using the _init and _post of hciattach.
>>
>> The mentioned feature will get disabled in the controller on receiving a HCI
>> RESET command.
>>
>> If the user does an HCI close, this feature will be disabled and we need to
>> enable it again when the user opens the HCI device again.
>>
>> I guess the "hdev->driver_init" queue is provided for that reason.
>>
>> An hciattach is called only once but hci open/close can be done multiple
>> times.
>
> Well this is debatable, I guess we had this discussion when our
> manufacturer came up with PM feature like this - As to what is the
> right BT on procedure?
> Should hciattach be terminated when BT is Off or is it just a
> hciconfig hci0 down - So we decided to get rid of hciattach way of
> doing things.

Yes, it would work fine for me too on a customer platform. but my idea 
was to get it working on a generic x86 system running a normal distribution.

Moreover, if you looks at the "hdev->driver_init" queue, it looks like 
it is meant for exactly this requirement. Bluez already have code in 
hci_init_req() to take care of this scenario.


>
> Also HCI_QUIRK_NO_RESET allows you to not to have reset .. in certain
> cases, I guess with this your chip's firmware is able to remember the
> PM settings previously sent across?

HCI_QUIRK_NO_RESET only lets you not send a HCI reset during 
initialization. I have no issues there, I am using the _post callback in 
hciattach to configure PM.

I am doing the testing in Ubuntu 10.04 using the Blueman as my Bluetooth 
agent.

 From the UI if the user does a BT off. It sends an HCI reset command 
followed by ah HCI close. This is causing the firmware forget the PM 
parameters.
>
>> Regards
>> Suraj
>>

Regards
Suraj

