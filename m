Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Defer connection-parameter removal when unpairing without disconnecting
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHF=Y4oTZjk6k0YeBA6xEpksZRWU1TTtkZfB+YESWmmRxNs0GA@mail.gmail.com>
Date: Fri, 10 Oct 2014 17:57:59 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <872F1D49-E810-4D33-9B05-ED3DDBA64336@holtmann.org>
References: <1412859828-6224-1-git-send-email-fons@spotify.com> <CAHF=Y4oTZjk6k0YeBA6xEpksZRWU1TTtkZfB+YESWmmRxNs0GA@mail.gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

> As an alternative to this patch, I am thinking that it may be worth
> considering two other options:
> 
> 1. Adding an additional repairing operation: MGMT_OP_REPAIR_DEVICE.
> Making the repairing semantics explicit  would allow us to keep the connection
> parameters even if we choose to disconnect when unpairing.  On the
> other hand, one could argue that it clutters the API with an extra
> operation which is the composite of two already existing operations.
> 
> 2. Make MGMT_OP_PAIR_DEVICE behave like the repairing operation in (1)
> if the device was already paired. If I recall properly, Johan suggested
> this on IRC.

I am not in favor of making Pair Device just do re-pairing. I think that is a dangerous behavior since want bondings in the kernel only in two ways. Either they are loaded via Load Long Term Keys or via Pair Device. Doing something magic is something that I consider dangerous and can lead into some flaws. If we come with a clear error than we at least know that something went wrong.

Repairing command is possible, but I am not 100% convinced that it is a good idea. The normal workflow is that you pair and unpair a device. If you get stuck in a weird state, you unpair first which ensures that everything is cleaned out and then pair again. For the connection parameters we can just be smarter.

I bet there is still a lot of improvement for our connection parameter handling. For example we could just keep all connection parameters around in cache and just expire them after 1 day or so. That would improve general handling with devices with do not pair in the first. So I would focus on being smart when dropping connection parameters and not trying to bind it too much to mgmt API visible states.

Regards

Marcel

