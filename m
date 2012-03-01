Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Mar 2012 14:36:24 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Update L2CAP timeout constants to use
 msecs_to_jiffies
Message-ID: <20120301223624.GA7306@x220.amr.corp.intel.com>
References: <1330640733-29448-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330640733-29448-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Mar 01, 2012, Marcel Holtmann wrote:
> The L2CAP timeout constants are always used in form of jiffies. So just
> include the conversion from msecs in the define itself. This has the
> advantage of making the code where the timeout is used more readable.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/l2cap.h |   10 +++++-----
>  net/bluetooth/l2cap_core.c    |   18 ++++++------------
>  net/bluetooth/l2cap_sock.c    |    2 +-
>  3 files changed, 12 insertions(+), 18 deletions(-)

Applied. Thanks.

Johan
