Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1305656720-9622-1-git-send-email-claudio.takahasi@openbossa.org>
References: <20110517161326.GA20885@dell.ice.intel.com>
	<1305656720-9622-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Wed, 18 May 2011 16:18:54 -0300
Message-ID: <BANLkTi=VZH-H4m8Aynn47nPYSs-fKFYRBA@mail.gmail.com>
Subject: Re: [PATCH v4 03/12] Move legacy verification to a new function
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, May 17, 2011 at 3:25 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> ---
>  src/adapter.c |   35 ++++++++++++++++++++++-------------
>  1 files changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 3188974..d4e1121 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -3002,6 +3002,26 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
>        adapter_emit_device_found(adapter, dev);
>  }
>
> +static gboolean pairing_is_legacy(bdaddr_t *local, bdaddr_t *peer,
> +                                       gboolean eir, gboolean name)

Based on the discussion in the IRC, a new patch series will be sent
replacing the booleans("name" and "data") by pointers.

Claudio.

> +{
> +       unsigned char features[8];
> +
> +       if (eir)
> +               return FALSE;
> +
> +       if (name == FALSE)
> +               return TRUE;
> +
> +       if (read_remote_features(local, peer, NULL, features) < 0)
> +               return TRUE;
> +
> +       if (features[0] & 0x01)
> +               return FALSE;
> +       else
> +               return TRUE;
> +}
> +
>  void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
>                                uint32_t class, int8_t rssi, uint8_t *data)
>  {
> @@ -3011,7 +3031,6 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
>        char *alias, *name;
>        gboolean new_dev, legacy;
>        name_status_t name_status;
> -       unsigned char features[8];
>        const char *dev_name;
>        int err;
>
> @@ -3037,18 +3056,8 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
>        create_name(filename, PATH_MAX, STORAGEDIR, local_addr, "names");
>        name = textfile_get(filename, peer_addr);
>
> -       if (data)
> -               legacy = FALSE;
> -       else if (name == NULL)
> -               legacy = TRUE;
> -       else if (read_remote_features(&adapter->bdaddr, bdaddr, NULL,
> -                                                       features) == 0) {
> -               if (features[0] & 0x01)
> -                       legacy = FALSE;
> -               else
> -                       legacy = TRUE;
> -       } else
> -               legacy = TRUE;
> +       legacy = pairing_is_legacy(&adapter->bdaddr, bdaddr,
> +                               data ? TRUE : FALSE, name ? TRUE : FALSE);
>
>        /* Complete EIR names are always used. Shortened EIR names are only
>         * used if there is no name already in storage. */
> --
> 1.7.5.rc3
>
>
