Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Oct 2013 10:51:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Move idle_timeout and
 sniff_{min,max}_interval to hci_core.c
Message-ID: <20131018075152.GB4148@x220.p-661hnu-f1>
References: <1382062562-20113-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382062562-20113-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 17, 2013, Marcel Holtmann wrote:
> Move the debugfs configuration directly into hci_core.c and only expose
> it when the controller actually support BR/EDR sniff power saving mode.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c  | 93 +++++++++++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_sysfs.c | 91 ----------------------------------------------
>  2 files changed, 93 insertions(+), 91 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
