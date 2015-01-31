Return-Path: <cyrus@holtmann.org>
Date: Sat, 31 Jan 2015 09:59:33 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Bluetooth: Store OOB data present value for each
 set of remote OOB data
Message-ID: <20150131075933.GA22454@t440s.P-661HNU-F1>
References: <1422688856-28619-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422688856-28619-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jan 30, 2015, Marcel Holtmann wrote:
> Instead of doing complex calculation every time the OOB data is used,
> just calculate the OOB data present value and store it with the OOB
> data raw values.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 1 +
>  net/bluetooth/hci_core.c         | 8 ++++++++
>  2 files changed, 9 insertions(+)

Both patches have been applied to bluetooth-next. Thanks.

Johan
