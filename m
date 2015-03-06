Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Mar 2015 20:44:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Introduce controller setting information for
 static address
Message-ID: <20150306184451.GA17082@t440s.P-661HNU-F1>
References: <1425665481-5898-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425665481-5898-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Mar 06, 2015, Marcel Holtmann wrote:
> Currently it is not possible to determine if the static address is used
> by the controller. It is also not possible to determine if using a
> static on a dual-mode controller with disabled BR/EDR is possible or
> not.
> 
> To address this issue, introduce a new setting called static-address. If
> support for this setting is signaled that means that the kernel supports
> using static addresses. And if used on dual-mode controllers with BR/EDR
> disabled it means that a configured static address can be used.
> 
> In addition utilize the same setting for the list of current active
> settings that indicates if a static address is configured and if that
> address will be actually used.
> 
> With this in mind the existing Set Static Address management command
> has been extended to return the current settings. That way the caller
> of that command can easily determine if the programmed address will
> be used or if extra steps are required.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/mgmt.h |  1 +
>  net/bluetooth/mgmt.c         | 28 ++++++++++++++++++++++++++--
>  2 files changed, 27 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
