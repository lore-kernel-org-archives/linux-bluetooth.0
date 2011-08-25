Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Aug 2011 22:19:29 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/7] Bluetooth: Add a flag to indicate that SMP is going
 on
Message-ID: <20110825011929.GD5462@joana>
References: <1313798816-8647-1-git-send-email-vinicius.gomes@openbossa.org>
 <1313798816-8647-3-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313798816-8647-3-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-08-19 21:06:51 -0300]:

> Add HCI_CONN_LE_SMP_PEND flag to indicate that SMP is pending
> for that connection. This allows to have information that an SMP
> procedure is going on for that connection.
> 
> We use the HCI_CONN_ENCRYPT_PEND to indicate that encryption
> (HCI_LE_Start_Encryption) is pending for that connection.
> 
> While a SMP procedure is going on we hold an reference to the
> connection, to avoid disconnections.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/l2cap_core.c       |    4 ++-
>  net/bluetooth/smp.c              |   44 +++++++++++++++++++++++++++++--------
>  3 files changed, 38 insertions(+), 11 deletions(-)

Applied, thanks.

	Gustavo
