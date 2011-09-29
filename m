Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 29 Sep 2011 15:48:10 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Fix possible NULL pointer dereference
Message-ID: <20110929184810.GB2605@joana>
References: <1316764890-11806-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316764890-11806-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

* Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> [2011-09-23 10:01:30 +0200]:

> Checking conn->pending_sec_level if there is no connection leads to potential
> null pointer dereference. Don't process pin_code_request_event at all if no
> connection exists.
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
> ---
>  net/bluetooth/hci_event.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

Applied, thanks.

	Gustavo
