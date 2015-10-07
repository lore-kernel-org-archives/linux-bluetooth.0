Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Oct 2015 07:45:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: btbcm: Read the local name in setup stage
Message-ID: <20151007044554.GA22169@t440s.P-661HNU-F1>
References: <20151006185705.GA9369@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151006185705.GA9369@mwanda>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

On Tue, Oct 06, 2015, Dan Carpenter wrote:
> The patch 8af9da1ab784: "Bluetooth: btbcm: Read the local name in
> setup stage" from Oct 5, 2015, leads to the following static checker
> warning:
> 
> 	drivers/bluetooth/btbcm.c:533 btbcm_setup_apple()
> 	error: 'skb' dereferencing possible ERR_PTR()
> 
> drivers/bluetooth/btbcm.c
>    522          /* Read Verbose Config Version Info */
>    523          skb = btbcm_read_verbose_config(hdev);
>    524          if (!IS_ERR(skb)) {
>    525                  BT_INFO("%s: BCM: chip id %u build %4.4u", hdev->name,
>    526                          skb->data[1], get_unaligned_le16(skb->data + 5));
>    527                  kfree_skb(skb);
>    528          }
>    529  
>    530          /* Read Local Name */
>    531          skb = btbcm_read_local_name(hdev);
>    532          if (IS_ERR(skb)) {
> 
> This test is reversed?
> 
>    533                  BT_INFO("%s: %s", hdev->name, (char *)(skb->data + 1));
>    534                  kfree_skb(skb);
>    535          }

That's indeed a bug. Thanks for the report. I went ahead and fixed this
up myself since the commit was still on the top of the bluetooth-next
tree.

Johan
