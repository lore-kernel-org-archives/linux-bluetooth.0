Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Oct 2013 21:38:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Move eir_get_length() function into
 hci_event.c
Message-ID: <20131015183841.GD31747@x220.p-661hnu-f1>
References: <1381858272-50639-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381858272-50639-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 15, 2013, Marcel Holtmann wrote:
> The eir_get_length() function is only used from hci_event.c and so
> instead of having a public function move it to the location where
> it is used.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 17 -----------------
>  net/bluetooth/hci_event.c        | 17 +++++++++++++++++
>  2 files changed, 17 insertions(+), 17 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
