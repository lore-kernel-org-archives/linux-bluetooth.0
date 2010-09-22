Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4C997F8C.5070104@Atheros.com>
References: <1285075981-8941-1-git-send-email-suraj@atheros.com>
	<1285075981-8941-2-git-send-email-suraj@atheros.com>
	<AANLkTinS9YnKBUnv-RhV8ZZ185FtN_VDOWTQa3gTr6FC@mail.gmail.com>
	<4C997F8C.5070104@Atheros.com>
Date: Wed, 22 Sep 2010 16:22:32 -0500
Message-ID: <AANLkTikKLi1m8xTjzU_aOs+XNstenjTAUSmgbQxOGnkC@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: support to send power management enable
 during hci open
From: Pavan Savoy <pavan_savoy@sify.com>
To: Suraj Sumangala <suraj@atheros.com>
Cc: Suraj Sumangala <Suraj.Sumangala@atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@atheros.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Suraj,

On Tue, Sep 21, 2010 at 11:01 PM, Suraj Sumangala <suraj@atheros.com> wrote:
> Hi Pavan,
>
> On 9/22/2010 1:22 AM, Pavan Savoy wrote:
>>
>> On Tue, Sep 21, 2010 at 8:33 AM, Suraj Sumangala<suraj@atheros.com>
>>  wrote:
>>>
>>> This patch enables HCI_UART_ATH3K transport driver to support
>>> sending Vendor specific hci commands during hci open
>>> to enable or disable power management feature.
>>
>> Why? shouldn't this be done from the hciattach? like for the other
>> manufacturers?
>> If you want it to be sent before hci0 interface is exposed, send it
>> over ttyXX, you have your _init function and if you require it to be
>> sent after the hci0 is exposed - do it in the _post function.
>>
> We are already using the _init and _post of hciattach.
>
> The mentioned feature will get disabled in the controller on receiving a HCI
> RESET command.
>
> If the user does an HCI close, this feature will be disabled and we need to
> enable it again when the user opens the HCI device again.
>
> I guess the "hdev->driver_init" queue is provided for that reason.
>
> An hciattach is called only once but hci open/close can be done multiple
> times.

Well this is debatable, I guess we had this discussion when our
manufacturer came up with PM feature like this - As to what is the
right BT on procedure?
Should hciattach be terminated when BT is Off or is it just a
hciconfig hci0 down - So we decided to get rid of hciattach way of
doing things.

Also HCI_QUIRK_NO_RESET allows you to not to have reset .. in certain
cases, I guess with this your chip's firmware is able to remember the
PM settings previously sent across?

> Regards
> Suraj
>
