Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimUJoUmYorKNdNJPke_GJbAr6AK-ercNGr1uRRA@mail.gmail.com>
References: <AANLkTinQdwaAQk6LU_uLJ60YFOthhuwu5rL2gzZUXZ-k@mail.gmail.com>
	<AANLkTimUJoUmYorKNdNJPke_GJbAr6AK-ercNGr1uRRA@mail.gmail.com>
Date: Tue, 25 Jan 2011 21:28:45 +0530
Message-ID: <AANLkTimxHnqd9hp_Uu9DCXokq2Zj0bBb-3aJqRXE_AdE@mail.gmail.com>
Subject: Re: why scan_disable during hciops_power_off
From: Pavan Savoy <pavan_savoy@sify.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jan 25, 2011 at 8:57 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Tue, Jan 25, 2011 at 3:12 PM, Pavan Savoy <pavan_savoy@sify.com> wrote:
>> when hciops gets a set_powered with powered=0, then hciops_power_off is called.
>> However in here we write the SCAN_ENABLE (=0) to the device and then
>> do the HCIDEVDOWN...
>>
>> so couple of questions,
>> 1. are there controllers there which even after doing hci0 down,
>> allows other devices to be scanned?
>> for those what do hci0 down mean ? radio not switched off ?
>
> Good point, perhaps this is driver dependent, so we do it just be safe guard.

I hope all devices and drivers out there consider the hci0 down as the
radio OFF,
I don't think there is a reason for it to be otherwise....
so why the safe-guard ?

>> 2. what happens to the response? in case hci0 down is considered as
>> say close of UART?
>> There is a case I have a combo chip, and I need to keep UART opened,
>> because someone else is using the UART, and then
>> I do this power_off, the hci0 interface is down, and bluetooth just
>> dumps down the scan_disable and quits, but the response
>> which comes from the device has no takers....
>>
>> so shouldn't hciops use a hci_send_req before HCIDEVDOWN ?
>
> It should and Im almost sure we do send it before, if we do sent it
> latter than it is probably a bug.

we do send it before, but don't really care about the response.
I was mentioning here use of hci_send_req instead of hci_send_cmd
before HCIDEVDOWN, so
that the function waits for response and finishes up work before the DEVDOWN....

>
> --
> Luiz Augusto von Dentz
> Computer Engineer
>
