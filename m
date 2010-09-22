Return-Path: <cyrus@holtmann.org>
Message-ID: <4C997F8C.5070104@Atheros.com>
Date: Wed, 22 Sep 2010 09:31:16 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: Pavan Savoy <pavan_savoy@sify.com>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [PATCH 2/2] Bluetooth: support to send power management enable
 during hci open
References: <1285075981-8941-1-git-send-email-suraj@atheros.com>	<1285075981-8941-2-git-send-email-suraj@atheros.com> <AANLkTinS9YnKBUnv-RhV8ZZ185FtN_VDOWTQa3gTr6FC@mail.gmail.com>
In-Reply-To: <AANLkTinS9YnKBUnv-RhV8ZZ185FtN_VDOWTQa3gTr6FC@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

On 9/22/2010 1:22 AM, Pavan Savoy wrote:
> On Tue, Sep 21, 2010 at 8:33 AM, Suraj Sumangala<suraj@atheros.com>  wrote:
>> This patch enables HCI_UART_ATH3K transport driver to support
>> sending Vendor specific hci commands during hci open
>> to enable or disable power management feature.
>
> Why? shouldn't this be done from the hciattach? like for the other
> manufacturers?
> If you want it to be sent before hci0 interface is exposed, send it
> over ttyXX, you have your _init function and if you require it to be
> sent after the hci0 is exposed - do it in the _post function.
>
We are already using the _init and _post of hciattach.

The mentioned feature will get disabled in the controller on receiving a 
HCI RESET command.

If the user does an HCI close, this feature will be disabled and we need 
to enable it again when the user opens the HCI device again.

I guess the "hdev->driver_init" queue is provided for that reason.

An hciattach is called only once but hci open/close can be done multiple 
times.

Regards
Suraj
