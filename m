Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 Oct 2013 16:27:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Expose white list size information in debugfs
Message-ID: <20131019132740.GC11607@x220.p-661hnu-f1>
References: <1382135026-48008-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382135026-48008-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 18, 2013, Marcel Holtmann wrote:
> Knowing the white list size information is important for
> debugging. So export it via debugfs.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
