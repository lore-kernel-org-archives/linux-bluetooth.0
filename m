Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Apr 2015 09:24:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: Make data pointer of
 hci_recv_stream_fragment const
Message-ID: <20150405062400.GE11977@t440s.P-661HNU-F1>
References: <1428206381-6111-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428206381-6111-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Apr 04, 2015, Marcel Holtmann wrote:
> The data pointer provided to hci_recv_stream_fragment function should
> have been marked const. The function has no business in modifying the
> original data. So fix this now.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 2 +-
>  net/bluetooth/hci_core.c         | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
