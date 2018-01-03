Return-Path: <loic.poulain@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CAFBinCAxUmxivp_PWkoydha84LbJi-GGv6Uhs6cKR+D_8c8QCw@mail.gmail.com>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
 <20180101204217.26165-9-martin.blumenstingl@googlemail.com>
 <5F8922BB-5A97-43B1-88D5-591EB76FF787@holtmann.org> <CAFBinCAxUmxivp_PWkoydha84LbJi-GGv6Uhs6cKR+D_8c8QCw@mail.gmail.com>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Wed, 3 Jan 2018 18:14:04 +0100
Message-ID: <CAMZdPi9KkPZvuvrNgfGmRksJnR0cFti8P5XC-HTFeUfkFbCZ_g@mail.gmail.com>
Subject: Re: [RFC v2 8/9] Bluetooth: drop HCI_UART_INIT_PENDING support
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	Johan Hovold <johan@kernel.org>, linux-amlogic@lists.infradead.org,
	Larry Finger <Larry.Finger@lwfinger.net>, Carlo Caione <carlo@endlessm.com>,
	Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On 2 January 2018 at 22:06, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> Hi Marcel,
>
> thank you for looking into this latest version!
>
> On Tue, Jan 2, 2018 at 12:04 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Martin,
>>
>>> The three-wire (H5) protocol is the only protocol which uses
>>> HCI_UART_INIT_PENDING.
>>> Unfortunately the benefits of using this flag are currently unknown. It
>>> was added in commit 9f2aee848fe6 ("Bluetooth: Add delayed init sequence
>>> support for UART controllers"). In my experiments (with the
>>> "rtk_hciattach" tool - a customized version of hciattach for Realtek
>>> chipsets) I started the tool before and after this patch while the
>>> Bluetooth chipset was disabled (by pulling it's enable GPIO LOW). In
>>> both cases hci0 was not created - thus HCI_UART_INIT_PENDING is not
>>> required in that case.
>>>
>>> Removing this code also has another benefit: hci_serdev.c does not
>>> support the delayed initialization / registration. Thus the protocol
>>> implementation (hci_h5) never receives any data with this check still
>>> in place. For the H5 protocol this means that the initialization never
>>> completes (because the sync response never arrives). Even if the
>>> initialization would succeed later on the drivers would call
>>> hci_uart_init_ready() which schedules the registration which is
>>> currently not implemented by hci_serdev.c.
>>>
>>> Removing the HCI_UART_INIT_PENDING check makes the code easier to read
>>> and also fixes the initalization of devices (implemented with the serdev
>>> library) which use the H5 protocol.
>>>
>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I think the original goal is to perform H5 init peacefully.
The H5 protocol needs to be open in order to send/receive H5 link
packets during the H5 initialization/synchronization step.
During this stage, driver prevents upper stack to send any HCI packet
by delaying the HCI device registration.

Regards,
Loic
