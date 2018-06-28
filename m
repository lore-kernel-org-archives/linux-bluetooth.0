Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1530164990-2148-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1530164990-2148-1-git-send-email-jaganathx.kanakkassery@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 28 Jun 2018 12:58:27 +0300
Message-ID: <CABBYNZJvBg+HFzpYLRfSk1_OAX29gC=SZhTxaAaF4OZ3+_Zkjw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] doc/mgmt-api: Add BREDR PHYs in PHY Configuration Commands
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Jun 28, 2018 at 8:49 AM, Jaganath Kanakkassery
<jaganath.k.os@gmail.com> wrote:
> ---
>  doc/mgmt-api.txt | 74 ++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 40 insertions(+), 34 deletions(-)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 87982e0..3ef367d 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2948,34 +2948,49 @@ Get PHY Configuration Command
>         Command Code:           0x0043
>         Controller Index:       <controller id>
>         Command Parameters:
> -       Return Parameters:      Supported_phys (2 Octet)
> -                               Selected_phys (2 Octet)
> +       Return Parameters:      Supported_phys (4 Octet)
> +                               Configurable_PHYs (4 Octets)
> +                               Selected_phys (4 Octet)
> +
> +       The PHYs parameters are a bitmask with currently the
> +       following available bits:
> +
> +               0       BR 1M 1-Slot
> +               1       BR 1M 3-Slot
> +               2       BR 1M 5-Slot
> +               3       EDR 2M 1-Slot
> +               4       EDR 2M 3-Slot
> +               5       EDR 2M 5-Slot
> +               6       EDR 3M 1-Slot
> +               7       EDR 3M 3-Slot
> +               8       EDR 3M 5-Slot
> +               9       LE 1M TX
> +               10      LE 1M RX
> +               11      LE 2M TX
> +               12      LE 2M RX
> +               13      LE Coded TX
> +               14      LE Coded RX

I wonder if there were any discussions regarding the BR/EDR PHYs?
Usually we just let the controller auto select the best so we this we
want to allow userspace to tell which PHYs to enable? Is there any use
case where this actually makes sense? Well I guess the same is valid
for LE as well so at least with bluetoothd I don't think we would be
exposing these settings to applications so I guess it would be more of
a test command.

> +       If BR/EDR is supported, then BR 1M 1-Slot is supported by
> +       default and can also not be deselected. If LE is supported,
> +       then LE 1M TX and LE 1M RX are supported by default.
> +
> +       Disabling BR/EDR completely or respectively LE has no impact
> +       on the PHY configuration. It is remembered over power cycles.
>
> -       This command is used to retrieve the supported PHYs and currently
> -       selected PHYs.
> -
> -       Supported_phys and Selected_phys is a bitmask with the following bits.
> -               0       LE 1M TX
> -               1       LE 1M RX
> -               2       LE 2M TX
> -               3       LE 2M RX
> -               4       LE CODED TX
> -               5       LE CODED RX
> -
> -       LE 1M TX and LE 1M RX would be supported by default.
> -
> -       This command is only available for LE capable controllers.
> -        It will return Not Supported otherwise.
> +       This command generates a Command Complete event on success
> +       or a Command Status event on failure.
>
> -        Possible errors:       Not Supported
> +        Possible errors:       Invalid Parameters
>                                 Invalid Index
>
> +
>  Set PHY Configuration Command
>  =============================
>
>         Command Code:           0x0044
>         Controller Index:       <controller id>
> -       Command Parameters:     Default_phys (2 Octet)
> +       Command Parameters:     Selected_PHYs (4 Octet)
>         Return Parameters:
>
>         This command is used to set the default phy to the controller.
> @@ -2984,27 +2999,18 @@ Set PHY Configuration Command
>         and connection initiation.
>
>         The list of supported PHYs can be retrieved via the
> -       Get PHY Configuration command. Selecting unsupported PHYs will
> -       result in an Invalid Parameters error.
> +       Get PHY Configuration command. Selecting unsupported or
> +       deselecting default PHYs will result in an Invalid Parameter
> +       error.
>
> -       This can be called at any point to change the preferred PHYs.
> +       This can be called at any point to change the Selected PHYs.
>
> -       Default_phys is a bitmask with the following bits.
> -               0       LE 1M TX
> -               1       LE 1M RX
> -               2       LE 2M TX
> -               3       LE 2M RX
> -               4       LE CODED TX
> -               5       LE CODED RX
> +       Refer Get PHY Configuration command for PHYs parameter.
>
>         This command generates a Command Complete event on success
>         or a Command Status event on failure.
>
> -       This command is only available for LE capable controllers.
> -       It will return Not Supported otherwise.
> -
> -       Possible errors:        Not Supported
> -                               Invalid Parameters
> +       Possible errors:        Invalid Parameters
>                                 Invalid Index
>
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
