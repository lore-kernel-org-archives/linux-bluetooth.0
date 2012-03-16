Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Mar 2012 12:31:54 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add management command for setting Device ID
Message-ID: <20120316153154.GB21196@x220>
References: <1331521229-497-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331521229-497-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Mar 11, 2012, Marcel Holtmann wrote:
> The Device ID details need to be programmed into the kernel for every
> controller at least once. So provide management command for this.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/mgmt.h |    9 +++++++++
>  net/bluetooth/mgmt.c         |   26 ++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 0 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
