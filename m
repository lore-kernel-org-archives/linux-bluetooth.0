Return-Path: <cyrus@holtmann.org>
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <557319CC.1080709@lwfinger.net>
Date: Sat, 06 Jun 2015 11:03:24 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>
Subject: Re: Memory leak in btusb
References: <55638D99.5000704@lwfinger.net> <FEA49882-9F1E-463F-9253-AD9E6AF8A762@holtmann.org>
In-Reply-To: <FEA49882-9F1E-463F-9253-AD9E6AF8A762@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 06/06/2015 01:23 AM, Marcel Holtmann wrote:

> actually if this is only this device causing it, this might fix it:
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 94c6c048130f..e6815c678898 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1614,6 +1614,8 @@ static int btusb_setup_intel(struct hci_dev *hdev)
>          }
>          fw_ptr = fw->data;
>
> +       kfree_skb(skb);
> +
>          /* This Intel specific command enables the manufacturer mode of the
>           * controller.
>           *
>
> Totally untested, but it seems we forget to free that SKB and it would explain if you only see this on Intel Wilkens Peak and Stone Peak controllers.

Marcel,

Thanks. My knowledge of btusb and the hci library is too meagre for me to find 
leaks.

I have tested this patch. To me, this looks like a real leak, particularly since 
skb is overwritten a few lines down; however, the one I see is still present. My 
device does load a firmware patch file. This patch may or may not be needed, but 
it does no harm that I see.

For the record, my device loads patch file ibt-hw-37.7.10-fw-1.80.2.3.d.bseq.

Larry
