Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Mar 2012 12:32:26 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Fix broken usage of put_unaligned_le16
Message-ID: <20120316153226.GC21196@x220>
References: <1331573625-3916-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331573625-3916-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Mar 12, 2012, Marcel Holtmann wrote:
> In case the struct is already __packed, there is no need to use unaligned
> access to the data. So just use cpu_to_le16 or __constant_cpu_to_le16 in
> these cases.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c |   33 ++++++++++++++++-----------------
>  1 files changed, 16 insertions(+), 17 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
