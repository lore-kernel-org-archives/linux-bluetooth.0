Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Oct 2014 15:44:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v6] Bluetooth: Defer connection-parameter removal when
 unpairing
Message-ID: <20141015134450.GA21584@t440s.fdxtended.com>
References: <1413063887-25870-1-git-send-email-fons@spotify.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413063887-25870-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

On Sat, Oct 11, 2014, Alfonso Acosta wrote:
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

This patch has now been applied to the bluetooth-next tree. Thanks.

Johan
