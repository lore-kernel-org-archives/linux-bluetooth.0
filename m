Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313627852.10336.10.camel@THOR>
References: <1313627852.10336.10.camel@THOR>
Date: Thu, 18 Aug 2011 10:49:48 +0300
Message-ID: <CABBYNZLRMK7ADwFQUQj6FS7RfQqDR8o-SjAJsqHUeFxXVYhXWg@mail.gmail.com>
Subject: Re: [RFC v2 2/5] Bluetooth: Minor optimization for multiple tx connections
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Thu, Aug 18, 2011 at 3:37 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> When assigning tx quotas for multiple connections, bump fractional
> amounts to the next higher integer. This can reduce the number of
> iterations through the tx scheduler. For example, if 5 avail acl
> buffers are to be used by 3 transmitting connections, the current
> scheduler will produce quotas of 1, 1, 1, 1, 1. This
> optimization will instead produce quotas of 2, 2, 1 (ie., 2 less
> iterations of the tx scheduler).
>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  net/bluetooth/hci_core.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 47a31fa..0defa83 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1826,7 +1826,7 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int
>        }
>
>        if (conn) {
> -               int cnt, q;
> +               int cnt;
>
>                switch (conn->type) {
>                case ACL_LINK:
> @@ -1844,8 +1844,7 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int
>                        BT_ERR("Unknown link type");
>                }
>
> -               q = cnt / num;
> -               *quote = q ? q : 1;
> +               *quote = (cnt + (num - 1)) / num;
>        } else
>                *quote = 0;
>
> --
> 1.7.4.1
>

Nice catch, actually after seeing your patch I realize one of my
patches is wrong in assuming an HCI Channel can only be scheduled once
per tx_task, but I guess with your changes we can probably assume so,
right?


-- 
Luiz Augusto von Dentz
