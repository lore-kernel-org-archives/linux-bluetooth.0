Return-Path: <cyrus@holtmann.org>
Date: Sun, 1 Feb 2015 09:16:43 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Expose debug keys usage setting via debugfs
Message-ID: <20150201071643.GB13640@t440s.P-661HNU-F1>
References: <1422745926-30299-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422745926-30299-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jan 31, 2015, Marcel Holtmann wrote:
> To allow easier debugging when debug keys are generated, provide debugfs
> entry for checking the setting of debug keys usage.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_debugfs.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
