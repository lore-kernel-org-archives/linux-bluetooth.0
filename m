Return-Path: <cyrus@holtmann.org>
Date: Sat, 4 Apr 2015 08:52:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix location of TX power field in LE
 advertising data
Message-ID: <20150404055223.GB23969@t440s.P-661HNU-F1>
References: <1428092592-8588-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428092592-8588-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Apr 03, 2015, Marcel Holtmann wrote:
> The TX power field in the LE advertising data should be placed last
> since it needs to be possible to enable kernel controlled TX power,
> but still allow for userspace provided flags field.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
