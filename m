Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH] Bluetooth: Convert timers to use timer_setup()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171005005429.GA23965@beast>
Date: Fri, 6 Oct 2017 20:38:45 +0200
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "bluez mailin list (linux-bluetooth@vger.kernel.org)"
        <linux-bluetooth@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Message-Id: <9F279691-3402-48A2-8E5A-982E65ABCBAF@holtmann.org>
References: <20171005005429.GA23965@beast>
To: Kees Cook <keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kees,

> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly. As already done in hci_qca, add
> struct hci_uart pointer to priv structure.
> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This requires commit 686fef928bba ("timer: Prepare to change timer
> callback argument type") in v4.14-rc3, but should be otherwise
> stand-alone.
> ---
> drivers/bluetooth/bluecard_cs.c |  7 +++----
> drivers/bluetooth/hci_bcsp.c    | 10 ++++++----
> drivers/bluetooth/hci_h5.c      | 10 ++++++----
> drivers/bluetooth/hci_qca.c     | 17 ++++++++---------
> 4 files changed, 23 insertions(+), 21 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
