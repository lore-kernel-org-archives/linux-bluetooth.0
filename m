Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTinL=-ODxZa9CGboD0o9443cG-uFkQ@mail.gmail.com>
References: <BANLkTimHaJaCjawT2JuW0kH18ihkyVr5Yg@mail.gmail.com>
	<20110511164736.GA22065@joana>
	<BANLkTimFMZ+ohvJsmD9NV7WqFqtX1W4yXw@mail.gmail.com>
	<BANLkTi=t-0QPSV4ZOqCA=OMZaGRhcga+FA@mail.gmail.com>
	<44EE5C37ADC36343B0625A05DD408C48517CE84134@CHEXMB-01.global.atheros.com>
	<4DCCEB4E.7040600@nokia.com>
	<BANLkTikJMKed11aRghia+7as9XGHokOH7w@mail.gmail.com>
	<BANLkTi=H-iEn_oAMb1bwJk6KEAueHRMVtQ@mail.gmail.com>
	<BANLkTi=KK0zUyeBUxWJxUW+EyFvJ_SuALA@mail.gmail.com>
	<BANLkTi=nUb=CxPYMgJQk7HKUF0OCsc7jUw@mail.gmail.com>
	<BANLkTinL=-ODxZa9CGboD0o9443cG-uFkQ@mail.gmail.com>
Date: Tue, 17 May 2011 08:13:25 +0100
Message-ID: <BANLkTi=xgHcwU-2XeKoVweoLGRYQJNUvvg@mail.gmail.com>
Subject: Re: HCI data payload not getting through when using BlueZ
From: Eponymous - <the.epon@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The chips are CSR Bluecores. In order to get upperlayers access rather
 than HCI over USB you have to configure a key in the firmware.

As soon as I enable upperlayers access the devices disappear from hciconfig.

On Mon, May 16, 2011 at 1:17 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi,
>
> On Mon, May 16, 2011 at 6:36 AM, Eponymous - <the.epon@gmail.com> wrote:
>> OK guys,
>>
>> I had a theory that my l2test test was not working due to the fact
>> that the chip wasn't configured to work with upperlayers. After
>> enabling this however, the  devices disappear (in hciconfig) so I
>> can't really test any L2CAP stuff (which I assume is what l2test is
>> doing).
>>
>> Are there any other things I can try to help debug this issue I've seen?
>
> What is the chipset of your USB dongles ? A "lsusb -d <vid>:<pid>" and
> relevant output from dmesg might help here.
>
> What do you mean by "the chip wasn't configured to work with
> upperlayers" ? Was the chipset in a mode which was not HCI compliant?
>
> Keep in mind that there are development/prototype USB dongles which
> are in fact serial/FTDI devices, and thus require using hciattach to
> be able to use them in BlueZ.
>
> Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
>
