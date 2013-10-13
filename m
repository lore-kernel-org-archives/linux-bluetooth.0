Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Oct 2013 23:15:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Add support for per socket msg_name
 callback
Message-ID: <20131013201534.GA31870@x220.p-661hnu-f1>
References: <1381694129-51112-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381694129-51112-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 13, 2013, Marcel Holtmann wrote:
> This allows to add a per socket msg_name callback that can be used
> for updating the msg_name information for recvmsg() system calls.
> 
> This feature is used by another patch to support address information
> on L2CAP connectionless channels.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/bluetooth.h |  1 +
>  net/bluetooth/af_bluetooth.c      | 15 +++++++++++----
>  2 files changed, 12 insertions(+), 4 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
