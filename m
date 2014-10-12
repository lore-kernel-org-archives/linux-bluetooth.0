Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v6] Bluetooth: Defer connection-parameter removal when unpairing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1413063887-25870-1-git-send-email-fons@spotify.com>
Date: Mon, 13 Oct 2014 00:45:51 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EDC21CD6-FBF6-43DA-A8E4-40BF710EA50E@holtmann.org>
References: <1413063887-25870-1-git-send-email-fons@spotify.com>
To: Alfonso Acosta <fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

> Systematically removing the LE connection parameters and autoconnect
> action is inconvenient for rebonding without disconnecting from
> userland (i.e. unpairing followed by repairing without
> disconnecting). The parameters will be lost after unparing and
> userland needs to take care of book-keeping them and re-adding them.
> 
> This patch allows userland to forget about parameter management when
> rebonding without disconnecting. It defers clearing the connection
> parameters when unparing without disconnecting, giving a chance of
> keeping the parameters if a repairing happens before the connection is
> closed.
> 
> Signed-off-by: Alfonso Acosta <fons@spotify.com>

patch looks good, but I wonder why we do not have a diffstat here. Are you not using git format-patch and git send-email to send patches? If not, then you might want to start with that.

Anyhow, since we are in the middle of the merge window for 3.18, I am not yet applying the patch to bluetooth-next, but just for reference here, ack from my side.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

