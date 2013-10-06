Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Oct 2013 15:13:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Make it clear that disabling LE disables
 advertising
Message-ID: <20131006131324.GB32754@x220.p-661hnu-f1>
References: <1381052443-61915-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381052443-61915-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 06, 2013, Marcel Holtmann wrote:
> This is not a functional change, just change the code to make it easy
> to understand that advertising gets disabled before LE support will
> be turned off.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
