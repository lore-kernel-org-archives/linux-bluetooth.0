Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1323436248-3736-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323436248-3736-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Sat, 10 Dec 2011 08:47:38 -0400
Message-ID: <CAJdJm_NwrcB8VmK7BZjAmBYL6Md=Ksq9ONcisu0UApwPTbz-qQ@mail.gmail.com>
Subject: Re: [RFCv0] Bluetooth: General HCI callback implementation
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Dec 9, 2011 at 9:10 AM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Add general HCI callback implementation. Can be used for executing
> HCI commands from A2MP protocol.
> ---
>  include/net/bluetooth/hci_core.h |   14 +++++++++++
>  net/bluetooth/hci_core.c         |   47 ++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_event.c        |    4 +++
>  3 files changed, 65 insertions(+), 0 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index cc5481d..e473cd2 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -121,6 +121,15 @@ struct adv_entry {
>        u8 bdaddr_type;
>  };
>
> +struct hci_dev;
> +
> +struct cb_cmd {
> +       struct list_head list;
> +       u16 opcode;
> +       void *opt;
> +       void (*cb)(struct hci_dev *hdev, void *opt);
> +};
> +

Isn't this a too generic name for an exported struct, which may cause clashes?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
