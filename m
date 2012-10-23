Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1351011241-32515-4-git-send-email-johan.hedberg@gmail.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
	<1351011241-32515-4-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 23 Oct 2012 14:42:26 -0400
Message-ID: <CAJdJm_PXwxZ1cyCd=2g170AYx7yjx24cHmksJCTbkxtxyOV4-g@mail.gmail.com>
Subject: Re: [PATCH 3/7] Bluetooth: Disallow LE scanning and connecting in
 peripheral mode
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Oct 23, 2012 at 12:53 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
>
> When an adapter is in the LE peripheral mode scanning for other devices
> or initiating connections to them is not allowed. This patch makes sure
> that such attempts will result in appropriate error returns.

This will conflict with an Observer role running on the same device.
Multiple roles are allowed to run concurrently if supported by the
controller. From Core spec page 1639:

A device may operate in multiple GAP roles concurrently if supported by the
Controller. The Host should read the supported Link Layer States and State
combinations from the Controller before any procedures or modes are used.

Do you propose SET_LE to become a bitfield to support concurrent
roles?  I.e. Broadcaster/Observer.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
