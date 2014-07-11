Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Jul 2014 13:56:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Move struct hci_pinfo into
 net/bluetooth/hci_sock.c
Message-ID: <20140711105632.GC14378@t440s.P-661HNU-F1>
References: <1405050060-43569-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405050060-43569-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jul 11, 2014, Marcel Holtmann wrote:
> There exists no external user of struct hci_pinfo and hci_pi and thus
> move it into the one place that is actually using it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 11 -----------
>  net/bluetooth/hci_sock.c         | 11 +++++++++++
>  2 files changed, 11 insertions(+), 11 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
