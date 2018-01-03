Return-Path: <martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLB9aem0TXZyUvFpsfXP4p++oukPmQzGEYxkVwZt+bdvw@mail.gmail.com>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
 <20180101204217.26165-9-martin.blumenstingl@googlemail.com> <CAL_JsqLB9aem0TXZyUvFpsfXP4p++oukPmQzGEYxkVwZt+bdvw@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 3 Jan 2018 21:38:57 +0100
Message-ID: <CAFBinCBerT_Yayyss53LCEdsUe30CY4T-fp-YgOW3VOrNtJodA@mail.gmail.com>
Subject: Re: [RFC v2 8/9] Bluetooth: drop HCI_UART_INIT_PENDING support
To: Rob Herring <robh+dt@kernel.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>, Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	Johan Hovold <johan@kernel.org>, linux-amlogic@lists.infradead.org,
	Larry.Finger@lwfinger.net, Carlo Caione <carlo@endlessm.com>,
	Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rob,

On Wed, Jan 3, 2018 at 7:38 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Mon, Jan 1, 2018 at 2:42 PM, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>> The three-wire (H5) protocol is the only protocol which uses
>> HCI_UART_INIT_PENDING.
>
> I think I'd also found that this flag wasn't really needed.
do you remember how you tested this? did you test it with you new
serdev code or with the old hci_ldisc code (with some userspace tool)?

>> Unfortunately the benefits of using this flag are currently unknown. It
>> was added in commit 9f2aee848fe6 ("Bluetooth: Add delayed init sequence
>> support for UART controllers"). In my experiments (with the
>> "rtk_hciattach" tool - a customized version of hciattach for Realtek
>> chipsets) I started the tool before and after this patch while the
>> Bluetooth chipset was disabled (by pulling it's enable GPIO LOW). In
>> both cases hci0 was not created - thus HCI_UART_INIT_PENDING is not
>> required in that case.
>>
>> Removing this code also has another benefit: hci_serdev.c does not
>> support the delayed initialization / registration.
>
> This statement is misleading. serdev *always* supports async init as
> it forces async probe of drivers. It doesn't need to support the
> private workq init mechanism. At least that was my intent.
thank you for having a look at this patch!
I will update the description in the next version

>> Thus the protocol
>> implementation (hci_h5) never receives any data with this check still
>> in place. For the H5 protocol this means that the initialization never
>> completes (because the sync response never arrives). Even if the
>> initialization would succeed later on the drivers would call
>> hci_uart_init_ready() which schedules the registration which is
>> currently not implemented by hci_serdev.c.
>>
>> Removing the HCI_UART_INIT_PENDING check makes the code easier to read
>> and also fixes the initalization of devices (implemented with the serdev
>> library) which use the H5 protocol.
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>  drivers/bluetooth/hci_h5.c     |  3 ---
>>  drivers/bluetooth/hci_ldisc.c  | 38 --------------------------------------
>>  drivers/bluetooth/hci_serdev.c |  3 ---
>>  drivers/bluetooth/hci_uart.h   |  4 +---
>>  4 files changed, 1 insertion(+), 47 deletions(-)


Regards
Martin
