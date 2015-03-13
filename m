Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Mar 2015 12:16:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] Bluetooth: Introduce hci_dev_test_flag helper macro
Message-ID: <20150313101614.GB12175@t440s.lan>
References: <1426237866-8329-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426237866-8329-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Mar 13, 2015, Marcel Holtmann wrote:
> Instead of manually coding test_bit on hdev->dev_flags all the time,
> use hci_dev_test_flag helper macro.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  14 +--
>  net/bluetooth/hci_conn.c         |  14 +--
>  net/bluetooth/hci_core.c         | 120 ++++++++++-----------
>  net/bluetooth/hci_debugfs.c      |   4 +-
>  net/bluetooth/hci_event.c        |  92 ++++++++--------
>  net/bluetooth/hci_request.c      |  28 ++---
>  net/bluetooth/hci_sock.c         |   8 +-
>  net/bluetooth/l2cap_core.c       |   8 +-
>  net/bluetooth/mgmt.c             | 224 +++++++++++++++++++--------------------
>  net/bluetooth/smp.c              |  44 ++++----
>  10 files changed, 278 insertions(+), 278 deletions(-)

All seven patches in this set have been applied to bluetooth-next.
Thanks.

Johan
