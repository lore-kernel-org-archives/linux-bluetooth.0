Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Jun 2011 16:10:12 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: Re: [bluetooth-next v4 16/16] Bluetooth: Add key size checks for SMP
Message-ID: <20110613191012.GA7372@joana>
References: <1307656255-8659-1-git-send-email-vinicius.gomes@openbossa.org>
 <1307656255-8659-17-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307656255-8659-17-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-06-09 18:50:55 -0300]:

> This patch implements a check in smp cmd pairing request and pairing
> response to verify if encryption key maximum size is compatible in both
> slave and master when SMP Pairing is requested. Keys are also masked to
> the correct negotiated size.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  include/net/bluetooth/smp.h   |    3 ++
>  net/bluetooth/smp.c           |   54 +++++++++++++++++++++++++++++++----------
>  3 files changed, 45 insertions(+), 13 deletions(-)

First 14 patches are aplied, 15 and 16 need rebase.

	Gustavo
