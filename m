Return-Path: <cyrus@holtmann.org>
Date: Sat, 8 Sep 2012 17:34:43 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/6] Bluetooth: trivial: Remove empty line
Message-ID: <20120908203443.GG5788@joana>
References: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1346933147-11789-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346933147-11789-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-09-06 15:05:44 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8dbbc01..f305e44 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -268,7 +268,6 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
>  		BT_ERR("Unknown device type %d", hdev->dev_type);
>  		break;
>  	}
> -
>  }
>  
>  static void hci_le_init_req(struct hci_dev *hdev, unsigned long opt)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
