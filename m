Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Feb 2012 13:52:14 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 2/2] Bluetooth: Helper removes duplicated code
Message-ID: <20120203165213.GA29936@samus>
References: <1328279275-10303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328279275-10303-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328279275-10303-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On 16:27 Fri 03 Feb, Emeltchenko Andrei wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Use __check_timout helper to remove duplicated code

Typo here: __check_timeout

> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c |   31 +++++++++++++------------------
>  1 files changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 9a56a40..95eeae5 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2390,22 +2390,25 @@ static inline int __get_blocks(struct hci_dev *hdev, struct sk_buff *skb)
>  	return DIV_ROUND_UP(skb->len - HCI_ACL_HDR_SIZE, hdev->block_len);


[ snip ]


Cheers,
-- 
Vinicius
