Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Nov 2011 12:30:29 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org,
	Andrei.Emeltchenko.news@gmail.com
Subject: Re: [PATCHv4 9/9] Bluetooth: Guarantee BR-EDR device will be
 registered as hci0
Message-ID: <20111103143028.GC23913@joana>
References: <1320275916-32103-1-git-send-email-mathewm@codeaurora.org>
 <1320275916-32103-10-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320275916-32103-10-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2011-11-02 16:18:36 -0700]:

> It's convenient to use the HCI device index the AMP controller id, but
> the spec requires that an AMP controller never has id 0.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)

Nice work, everything is now applied. Let's go to the next AMP patchsets.
Thanks. :)

	Gustavo
