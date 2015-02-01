Return-Path: <cyrus@holtmann.org>
Date: Sun, 1 Feb 2015 09:17:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Expose remote OOB information as debugfs entry
Message-ID: <20150201071711.GD13640@t440s.P-661HNU-F1>
References: <1422766867-29086-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422766867-29086-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jan 31, 2015, Marcel Holtmann wrote:
> For debugging purposes it is good to know which OOB data is actually
> currently loaded for each controller. So expose that list via debugfs.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_debugfs.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
