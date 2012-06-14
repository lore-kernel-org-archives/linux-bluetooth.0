Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1339659945-28094-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1339659945-28094-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 14 Jun 2012 08:07:40 -0400
Message-ID: <CAJdJm_MtZYC9=nFzchcCR+yZiyGVNCMpXnmPf7D-dKut1UT8BA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Use AUTO_OFF constant in jiffies
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Jun 14, 2012 at 3:45 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Move AUTO_OFF_TIMEOUT to other constants changing name to
> HCI_AUTO_OFF_TIMEOUT and convert to jiffies.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h |    3 ++-
>  net/bluetooth/hci_core.c    |    5 +----
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 3d1ad2c..a7b334e 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -153,8 +153,9 @@ enum {
>  #define HCI_DISCONN_TIMEOUT    msecs_to_jiffies(4000)  /* 2 seconds */

There is a typo in the comment above. It should be "4 seconds". Maybe
you can fix it in a separate patch together with the "seconds" ->
"second" fix you did below?

>  #define HCI_PAIRING_TIMEOUT    msecs_to_jiffies(60000) /* 60 seconds */
>  #define HCI_INIT_TIMEOUT       msecs_to_jiffies(10000) /* 10 seconds */
> -#define HCI_CMD_TIMEOUT                msecs_to_jiffies(1000)  /* 1 seconds */
> +#define HCI_CMD_TIMEOUT                msecs_to_jiffies(1000)  /* 1 second */
>  #define HCI_ACL_TX_TIMEOUT     msecs_to_jiffies(45000) /* 45 seconds */
> +#define HCI_AUTO_OFF_TIMEOUT   msecs_to_jiffies(2000)  /* 2 seconds */
>
>  /* HCI data types */
>  #define HCI_COMMAND_PKT                0x01

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
