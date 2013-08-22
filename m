Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1376756714-25479-25-git-send-email-ming.lei@canonical.com>
References: <1376756714-25479-1-git-send-email-ming.lei@canonical.com>
	<1376756714-25479-25-git-send-email-ming.lei@canonical.com>
Date: Thu, 22 Aug 2013 20:23:41 +0800
Message-ID: <CACVXFVOV8g-LzO8qHvHpHu+2CudvDyh2SHmZs==dNewdVnFZMQ@mail.gmail.com>
Subject: Re: [PATCH v1 24/49] BT: btusb: prepare for enabling irq in complete()
From: Ming Lei <ming.lei@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb <linux-usb@vger.kernel.org>, Oliver Neukum <oliver@neukum.org>,
	Alan Stern <stern@rowland.harvard.edu>, Ming Lei <ming.lei@canonical.com>,
	Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Aug 18, 2013 at 12:24 AM, Ming Lei <ming.lei@canonical.com> wrote:
> Complete() will be run with interrupt enabled, so change to
> spin_lock_irqsave().
>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@canonical.com>

Marcel, Gustavo and Johan, could you review and give an Ack if
this one and 25/49 are OK so they can be merged via Greg's USB
tree?


Thanks,
--
Ming Lei
