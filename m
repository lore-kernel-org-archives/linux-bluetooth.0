Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Jan 2015 10:16:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Clear P-192 values for OOB when in Secure
 Connections Only mode
Message-ID: <20150128081638.GA23114@t440s.lan>
References: <1422403473-3542-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422403473-3542-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jan 27, 2015, Marcel Holtmann wrote:
> When Secure Connections Only mode has been enabled and remote OOB data
> is requested, then only provide P-256 hash and randomizer vaulues. The
> fields for P-192 hash and randomizer should be set to zero.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c | 46 ++++++++++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 20 deletions(-)


All three patches in this set have been applied to bluetooth-next.
Thanks.

Johan
