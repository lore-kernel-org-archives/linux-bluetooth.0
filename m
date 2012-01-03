Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Jan 2012 23:17:00 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Correct packet len calculation
Message-ID: <20120103011700.GF1472@joana>
References: <1325239667-9198-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325239667-9198-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-12-30 12:07:47 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Remove unneeded skb_pull and correct packet length calculation
> removing magic number. Move BT_DBG after len check otherwise
> it could possibly access wrong memory.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)

Applied, thanks.

	Gustavo
