Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH 09/13] Bluetooth: hci_serdev: Fix HCI_UART_INIT_PENDING
 not working
To: Rob Herring <robh@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jeremy Cline <jeremy@jcline.org>,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
References: <20180527190457.2632-1-hdegoede@redhat.com>
 <20180527190457.2632-10-hdegoede@redhat.com>
 <CAL_JsqKBc4_bsaqNd3t5=LPBYgv32Jw3pzUq-=25V7JBbRhF7A@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <c15c697b-150e-20fe-7e17-c04d4b853c35@redhat.com>
Date: Wed, 30 May 2018 19:31:31 +0200
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKBc4_bsaqNd3t5=LPBYgv32Jw3pzUq-=25V7JBbRhF7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 30-05-18 15:25, Rob Herring wrote:
> On Sun, May 27, 2018 at 2:04 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Init hci_uart->init_ready so that hci_uart_init_ready() works properly.
> 
> Why do you need to init in a wq? For serdev devices, probe is async
> already. So my thought was this wouldn't be needed.

The H5 protocol needs to exchange a number of messages to
sync the 2 sides before it can accept any HCI commands, so
it uses the delayed-registration feature of the hci_ldisc code by
setting the HCI_UART_INIT_PENDING. When doing serdev based enumeration
we could do something different but that would require significant
changes to the hci_h5.c code.

Regards,

Hans
