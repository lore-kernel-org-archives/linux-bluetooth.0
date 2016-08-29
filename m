Return-Path: <johan.hedberg@gmail.com>
Date: Mon, 29 Aug 2016 10:04:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Use individual flags for certain
 management events
Message-ID: <20160829070448.GA7349@t440s.lan>
References: <1472444387-129975-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472444387-129975-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Aug 29, 2016, Marcel Holtmann wrote:
> Instead of hiding everything behind a general managment events flag,
> introduce indivdual flags that allow fine control over which events are
> send to a given management channel.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h |  5 ++++-
>  net/bluetooth/hci_sock.c    |  5 ++++-
>  net/bluetooth/mgmt.c        | 32 +++++++++++++-------------------
>  3 files changed, 21 insertions(+), 21 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
