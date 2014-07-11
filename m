Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Jul 2014 13:58:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Update the list of L2CAP fixed channels
Message-ID: <20140711105843.GE14378@t440s.P-661HNU-F1>
References: <1405051388-56471-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405051388-56471-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jul 11, 2014, Marcel Holtmann wrote:
> The list of L2CAP fixed channels increased with newer versions of the
> specification. This just updates the constants for it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/l2cap.h | 5 ++++-
>  net/bluetooth/l2cap_core.c    | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
