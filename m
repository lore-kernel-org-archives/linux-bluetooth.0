Return-Path: <cyrus@holtmann.org>
Date: Sat, 1 Feb 2014 18:30:30 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Track if link is using P-256 authenticated
 combination key
Message-ID: <20140202023030.GG5133@x220.p-661hnu-f1>
References: <1391284322-29778-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391284322-29778-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Feb 01, 2014, Marcel Holtmann wrote:
> When the ACL link is using P-256 authenticated combination key, mark
> the link mode as HCI_LM_FIPS.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
