Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Oct 2013 14:53:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Read supported features and commands on AMP
 controllers
Message-ID: <20131007125300.GA7950@x220.p-661hnu-f1>
References: <1381138299-49639-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381138299-49639-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Oct 07, 2013, Marcel Holtmann wrote:
> The commands for reading supported features and commands are both
> supported by AMP controllers. Issue them during controller init
> phase so their values are known.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
