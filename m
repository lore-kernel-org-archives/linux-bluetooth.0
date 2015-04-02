Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Apr 2015 08:41:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Expose current Device ID information via
 debugfs
Message-ID: <20150402054111.GA14214@t440s.P-661HNU-F1>
References: <1427919697-11385-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427919697-11385-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Apr 01, 2015, Marcel Holtmann wrote:
> For debugging purposes it is good to be able to read the current
> configured Device ID details.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_debugfs.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
