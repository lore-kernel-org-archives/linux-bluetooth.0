Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Apr 2015 08:49:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Export ECDH selftest result in debugfs
Message-ID: <20150402054936.GA20866@t440s.P-661HNU-F1>
References: <1427917933-32183-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427917933-32183-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Apr 01, 2015, Marcel Holtmann wrote:
> When ECDH selftest is enabled, then besides printing the result into the
> kernel message buffer, also create a debugfs file that allows retrieving
> the same information.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/selftest.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)

Both patches have been applied to blueotooth-next. Thanks.

Johan
