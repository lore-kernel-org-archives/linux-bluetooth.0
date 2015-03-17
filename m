Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Mar 2015 08:20:55 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix length for Read Local OOB Extended Data
 respone packet
Message-ID: <20150317062055.GB21460@t440s.P-661HNU-F1>
References: <1426547144-1935-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426547144-1935-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Mar 16, 2015, Marcel Holtmann wrote:
> The length of the respone packet for Read Local OOB Extended Data
> command has a calculation error. In case LE Secure Connections support
> is not enabled, the actual response is shorter. Keep this in mind and
> update the value accordingly.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
