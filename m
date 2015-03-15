Return-Path: <cyrus@holtmann.org>
Date: Sun, 15 Mar 2015 10:03:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 01/14] Bluetooth: Add flags field and setting function
 for HCI sockets
Message-ID: <20150315080330.GA27545@t440s.P-661HNU-F1>
References: <1426386486-15962-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426386486-15962-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Mar 14, 2015, Marcel Holtmann wrote:
> To filter out certain actions for certain HCI sockets introcuce a flags
> field that allows to configure specific settings on individual sockets.
> 
> Since the hci_pinfo structure is private in hci_sock.c, provide helper
> functions for setting and clearing a given flag.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/bluetooth.h |  3 +++
>  net/bluetooth/hci_sock.c          | 11 +++++++++++
>  2 files changed, 14 insertions(+)

All patches in this set have been applied to bluetooth-next. Thanks.

Johan
