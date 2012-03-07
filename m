Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Mar 2012 15:02:38 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: Use the updated key structures for handling LTKs
Message-ID: <20120307180237.GA5107@samus>
References: <20120307114437.GA13172@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120307114437.GA13172@elgon.mountain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

On 14:44 Wed 07 Mar, Dan Carpenter wrote:
> Hello Vinicius Costa Gomes,
> 
> The patch c9839a11c0e4: "Bluetooth: Use the updated key structures 
> for handling LTKs" from Feb 2, 2012, leads to the following Sparse
> warning: net/bluetooth/mgmt.c:2590:59: warning: incorrect type in
> argument 9 (different base types)
> 
> +int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
> +                               int new_key, u8 authenticated, u8 tk[16],
> +                               u8 enc_size, u16 ediv, u8 rand[8]);
>                                              ^^^^^^^^
> +struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
> +                                                               u8 addr_type);
>  int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr);
> -int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
> -                       u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16]);
>                                      ^^^^^^^^^^^
>  int hci_smp_ltks_clear(struct hci_dev *hdev);

Thanks for the heads up, will fix it.

> 
> We removed the endian notation from ediv, but it seems from a quick read
> that the __le16 was correct.  Btw, here is an article on how to use
> Sparse to find endian bugs:  http://lwn.net/Articles/205624/
> 
> regards,
> dan carpenter
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
-- 
Vinicius
