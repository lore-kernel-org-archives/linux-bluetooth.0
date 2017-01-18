Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CFDC29A5-3ABE-432F-9E22-0EEE88A9A917@holtmann.org>
References: <20170118172901.20546-1-robh@kernel.org> <CFDC29A5-3ABE-432F-9E22-0EEE88A9A917@holtmann.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 18 Jan 2017 12:10:57 -0600
Message-ID: <CAL_Jsq+KfwUSVvpK=CFfVY6oYuWrzhTgxkt16Scwgu8F67YUKA@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: hci_uart: remove unused hci_uart_init_tty
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 18, 2017 at 11:38 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Rob,
>
>> There are no users of hci_uart_init_tty, so remove it.
>
> really? Hmmm, it was suppose to be used by the Broadcom UART drivers. Maybe it would be actually prudent if drivers call it instead of relying on what btattach uses to set before activation the line discipline.

I stole the code for serdev if that makes you feel better. :)

Rob
