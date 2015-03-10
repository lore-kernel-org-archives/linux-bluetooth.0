Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1425331850-31906-1-git-send-email-jpawlowski@google.com>
References: <1425331850-31906-1-git-send-email-jpawlowski@google.com>
Date: Tue, 10 Mar 2015 10:31:31 -0700
Message-ID: <CAD0=r8w1dqQZNZ+0cPTAsA-0D0MeA2wRjM=HEHi4yYEQjJhrNA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] Bluetooth: Introduce HCI_QUIRK_SIMULTAENOUS_DISCOVERY
From: Jakub Pawlowski <jpawlowski@google.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Jakub Pawlowski <jpawlowski@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 2, 2015 at 1:30 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>
> Some controllers allow both le and classic scan to run at the same
> time, while others allow only one, le or classic at given time.
>
> Since this is specific to each controller, add a new quirk setting
> that allows drivers to tell the core wether given controller can
> do both le and classic discovery at same time.
>
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  include/net/bluetooth/hci.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 8e54f82..d64851a 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -160,6 +160,15 @@ enum {
>          * during the hdev->setup vendor callback.
>          */
>         HCI_QUIRK_STRICT_DUPLICATE_FILTER,
> +
> +       /* When this quirk is set, scanning for both le and classic devices
> +        * is done simoultaenously. If it's not set, the scan is
> +        * interleaved.
> +        *
> +        * This quirk can be set before hci_register_dev is called or
> +        * during the hdev->setup vendor callback.
> +        */
> +       HCI_QUIRK_SIMULTAENOUS_DISCOVERY,
>  };
>
>  /* HCI device flags */
> --
> 2.2.0.rc0.207.ga3a616c
>

Ping?
