Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1511938373-22396-3-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1511938373-22396-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1511938373-22396-3-git-send-email-jaganathx.kanakkassery@intel.com>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Fri, 16 Feb 2018 09:10:54 +0530
Message-ID: <CAJzH+bpA-QXMCZLdDABDDZA6R1F4R+nTttKFx41JFAGnrOfaFw@mail.gmail.com>
Subject: Re: [PATCH 2/4 v4] doc/mgmt-api: Add support for Set Phy
 Configuration command
To: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


On Wed, Nov 29, 2017 at 12:22 PM, Jaganath Kanakkassery
<jaganath.k.os@gmail.com> wrote:
> This also adds PHY Configuration Changed Event.
> ---
>  doc/mgmt-api.txt | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index c07c48c..628ff18 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2940,9 +2940,46 @@ Get PHY Configuration Command
>         LE 1M TX and LE 1M RX would be supported by default.
>
>         This command is only available for LE capable controllers.
> +        It will return Not Supported otherwise.
> +
> +        Possible errors:        Not Supported
> +                               Invalid Index
> +
> +Set PHY Configuration Command
> +=============================
> +
> +       Command Code:           0x0044
> +       Controller Index:       <controller id>
> +       Command Parameters:     Default_phys (2 Octet)
> +       Return Parameters:
> +
> +       This command is used to set the default phy to the controller.
> +
> +       This will be stored and used for all the subsequent scanning
> +       and connection initiation.
> +
> +       The list of supported PHYs can be retrieved via the
> +       Get PHY Configuration command. Selecting unsupported PHYs will
> +       result in an Invalid Parameters error.
> +
> +       This can be called at any point to change the preferred PHYs.
> +
> +       Default_phy is a bitmask with the following bits.
> +               0       LE 1M TX
> +               1       LE 1M RX
> +               2       LE 2M TX
> +               3       LE 2M RX
> +               4       LE CODED TX
> +               5       LE CODED RX
> +
> +       This command generates a Command Complete event on success
> +       or a Command Status event on failure.
> +
> +       This command is only available for LE capable controllers.
>         It will return Not Supported otherwise.
>
>         Possible errors:        Not Supported
> +                               Invalid Parameters
>                                 Invalid Index
>

I think there is a limitation with current API proposal, user cannot do extended
scanning in only 1M (to scan secondary channel in 1M) since with 1M we will
switch to legacy scanning.

I think we need two more flags eg: 1MTX-SEC & 1MRX-SEC, if set we will
use extended scanning in !M.

Plz let me know your opinion.

Thanks,
Jaganath
