Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Mar 2015 12:15:44 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support connectable advertising setting
Message-ID: <20150313101544.GA12175@t440s.lan>
References: <1426224658-25141-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426224658-25141-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Mar 12, 2015, Marcel Holtmann wrote:
> The patch adds a second advertising setting that allows switching of the
> controller into connectable mode independent of the global connectable
> setting.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h |  1 +
>  net/bluetooth/mgmt.c        | 39 ++++++++++++++++++++++++++++++---------
>  2 files changed, 31 insertions(+), 9 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
