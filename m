Return-Path: <cyrus@holtmann.org>
Date: Sun, 15 Feb 2015 18:55:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Provide option to enable/disable debugfs
 information
Message-ID: <20150215165552.GA18244@t440s.P-661HNU-F1>
References: <1423950006-9119-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423950006-9119-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Feb 14, 2015, Marcel Holtmann wrote:
> The Bluetooth controllers can export extensive information about
> internal states via debugfs. This patch provides an option to
> choose if these information are provided or not.
> 
> For backwards compatibility with existing kernel configuration,
> this option defaults to yes.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/Kconfig       |  8 ++++++++
>  net/bluetooth/Makefile      |  3 ++-
>  net/bluetooth/hci_debugfs.h | 22 ++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
