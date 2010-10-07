Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 7 Oct 2010 17:35:46 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Karl Beldan <karl.beldan@gmail.com>
Cc: Jiri Kosina <trivial@kernel.org>, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: hci_uart: Fix typo in stats for sco tx
Message-ID: <20101007203546.GH4893@vigoh>
References: <1286481430-6761-1-git-send-email-karl.beldan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286481430-6761-1-git-send-email-karl.beldan@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Karl,

* Karl Beldan <karl.beldan@gmail.com> [2010-10-07 21:57:10 +0200]:

> s/stat.cmd_tx++/stat.sco_tx++ for HCI_SCODATA_PKT
> 
> Signed-off-by: Karl Beldan <karl.beldan@gmail.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_ldisc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Good catch! Applied, Thanks.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
