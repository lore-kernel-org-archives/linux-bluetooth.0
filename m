Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTi=xgHcwU-2XeKoVweoLGRYQJNUvvg@mail.gmail.com>
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
	<BANLkTi=xgHcwU-2XeKoVweoLGRYQJNUvvg@mail.gmail.com>
Date: Tue, 17 May 2011 07:50:07 -0400
Message-ID: <BANLkTin1wGOa2=_9qHhYmmTbLs_E2xUHXw@mail.gmail.com>
Subject: Re: HCI data payload not getting through when using BlueZ
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Eponymous - <the.epon@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, May 17, 2011 at 3:13 AM, Eponymous - <the.epon@gmail.com> wrote:
> The chips are CSR Bluecores. In order to get upperlayers access rather
>  than HCI over USB you have to configure a key in the firmware.
>
> As soon as I enable upperlayers access the devices disappear from hciconfig.

As I said, there are various development/prototype devices out there
that use UART (usually CDC ACM or FTDI over USB) transport instead of
"plain" USB. If you post the relevant lines from "dmesg" and "lsusb"
somewhere (after you configure the firmware key), we might be able to
identify the transport.

For UART, you need to use hciattach on a e.g. /dev/ttyUSBX device
created when plugging the device.

HTH,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
