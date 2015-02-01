Return-Path: <cyrus@holtmann.org>
Date: Sun, 1 Feb 2015 09:16:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Expose hardware error code as debugfs entry
Message-ID: <20150201071657.GC13640@t440s.P-661HNU-F1>
References: <1422762879-5998-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422762879-5998-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jan 31, 2015, Marcel Holtmann wrote:
> When the Hardware Error event is send by the controller, the Bluetooth
> core stores the error code. Expose it via debugfs so it can be retrieved
> later on.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_debugfs.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
