Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180527190457.2632-10-hdegoede@redhat.com>
References: <20180527190457.2632-1-hdegoede@redhat.com> <20180527190457.2632-10-hdegoede@redhat.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 30 May 2018 08:25:44 -0500
Message-ID: <CAL_JsqKBc4_bsaqNd3t5=LPBYgv32Jw3pzUq-=25V7JBbRhF7A@mail.gmail.com>
Subject: Re: [PATCH 09/13] Bluetooth: hci_serdev: Fix HCI_UART_INIT_PENDING
 not working
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Jeremy Cline <jeremy@jcline.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, May 27, 2018 at 2:04 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Init hci_uart->init_ready so that hci_uart_init_ready() works properly.

Why do you need to init in a wq? For serdev devices, probe is async
already. So my thought was this wouldn't be needed.

Rob
