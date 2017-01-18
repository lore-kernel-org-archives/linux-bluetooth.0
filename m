Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] bluetooth: hci_uart: remove unused hci_uart_init_tty
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170118172901.20546-1-robh@kernel.org>
Date: Wed, 18 Jan 2017 18:38:48 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <CFDC29A5-3ABE-432F-9E22-0EEE88A9A917@holtmann.org>
References: <20170118172901.20546-1-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rob,

> There are no users of hci_uart_init_tty, so remove it.

really? Hmmm, it was suppose to be used by the Broadcom UART drivers. Maybe it would be actually prudent if drivers call it instead of relying on what btattach uses to set before activation the line discipline.

Regards

Marcel

