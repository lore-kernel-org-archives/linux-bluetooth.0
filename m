Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Jun 2011 16:49:07 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: Re: [PATCH] Bluetooth: fix missing parameter for HCI_OP_DISCONNECT
Message-ID: <20110613194906.GB7372@joana>
References: <1307994123-10830-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307994123-10830-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

* Anderson Lizardo <anderson.lizardo@openbossa.org> [2011-06-13 15:42:03 -0400]:

> The "dc" variable is initialized but not passed to hci_send_cmd().
> 
> Signed-off-by: Anderson Lizardo <anderson.lizardo@openbossa.org>
> Signed-off-by: Bruna Moreira <bruna.moreira@openbossa.org>
> ---
> Note: Only compile tested.
> 
>  net/bluetooth/mgmt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied, thanks.

	Gustavo
