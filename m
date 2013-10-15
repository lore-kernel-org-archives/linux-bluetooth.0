Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Oct 2013 21:38:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Move eir_append_data() function into mgmt.c
Message-ID: <20131015183828.GC31747@x220.p-661hnu-f1>
References: <1381857999-47886-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381857999-47886-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 15, 2013, Marcel Holtmann wrote:
> The eir_append_data() function is only used from mgmt.c and so
> instead of having a public function move it to the location where
> it is used.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 11 -----------
>  net/bluetooth/mgmt.c             | 11 +++++++++++
>  2 files changed, 11 insertions(+), 11 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
