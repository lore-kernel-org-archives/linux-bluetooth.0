Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Jun 2011 14:23:36 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Simplify hci_conn_accept_secure check
Message-ID: <20110606172336.GA28364@joana>
References: <1307017492-5684-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307017492-5684-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

* Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> [2011-06-02 14:24:52 +0200]:

> If the link key is secure (authenticated or combination 16 digit)
> the sec_level will be always BT_SECURITY_HIGH. Therefore, instead
> of checking the link key type simply check the sec_level on the link.
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
> ---
>  net/bluetooth/hci_conn.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)

Applied, thanks.

	Gustavo
