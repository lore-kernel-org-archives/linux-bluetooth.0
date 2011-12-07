Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Dec 2011 09:49:29 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/8] Bluetooth: Change SMP procedures to use the new key
 structures
Message-ID: <20111207074927.GA15379@aemeltch-MOBL1>
References: <1323218892-15785-1-git-send-email-vinicius.gomes@openbossa.org>
 <1323218892-15785-5-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323218892-15785-5-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, Dec 06, 2011 at 09:48:08PM -0300, Vinicius Costa Gomes wrote:
> Using separated messages and list for Long Term Keys allow simplification
> of the code.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |   31 +++++------
>  net/bluetooth/hci_core.c         |  105 ++++++++++++++++++++++---------------
>  net/bluetooth/hci_event.c        |    5 ++-
>  net/bluetooth/mgmt.c             |    6 ++
>  net/bluetooth/smp.c              |   29 +++++-----
>  5 files changed, 102 insertions(+), 74 deletions(-)

...
> -struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
> -					bdaddr_t *bdaddr, u8 type)
> +struct smp_ltk *hci_find_ltk_addr(struct hci_dev *hdev, bdaddr_t *bdaddr)
>  {
> -	struct link_key *k;
> +	struct smp_ltk *k;
>  
> -	list_for_each_entry(k, &hdev->link_keys, list)
> -		if (k->type == type && bacmp(bdaddr, &k->bdaddr) == 0)
> +	list_for_each_entry(k, &hdev->ltks, list)
> +		if (bacmp(bdaddr, &k->bdaddr) == 0)

shall we use kernel-style here? (!bacmp())

...

Best regards 
Andrei Emeltchenko 

