Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1534436174-12419-1-git-send-email-anupam.r@samsung.com>
References: <CGME20180816161626epcas2p19b94fa1df67344b01a4aa301323580c2@epcas2p1.samsung.com>
 <1534436174-12419-1-git-send-email-anupam.r@samsung.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Aug 2018 09:03:54 +0300
Message-ID: <CABBYNZL7Z7QdukS3ESKu_Ask6t6zi=8vVmx5gFcrpbwK_Qf1tA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] btmgmt: Add support to accept multiple PHY options
To: Anupam Roy <anupam.r@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        SACHIN DEV SHARMA <sachin.dev@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anupam,

On Thu, Aug 16, 2018 at 7:16 PM, Anupam Roy <anupam.r@samsung.com> wrote:
> Before fix -
>  [hci1]# phy 1MTX 1MRX 2MTX
>  Too many arguments: 3 > 1
>
> After Fix -
>  [hci1]# phy 1MRX 1MTX 2MTX
>  PHY Configuration successfully set
>
> btmon output after fix -
> @ MGMT Command: Set PHY Configuration (0x0045) plen 4
>         Selected PHYs: 0x0e00
>           LE 1M TX
>           LE 1M RX
>           LE 2M TX
> < HCI Command: LE Set Default PHY (0x08|0x0031) plen 3
>         All PHYs preference: 0x00
>         TX PHYs preference: 0x03
>           LE 1M
>           LE 2M
>         RX PHYs preference: 0x01
>           LE 1M
>> HCI Event: Command Complete (0x0e) plen 4
>       LE Set Default PHY (0x08|0x0031) ncmd 1
>         Status: Success (0x00)
> @ MGMT Event: Command Complete (0x0001) plen 3
>       Set PHY Configuration (0x0045) plen 0
>         Status: Success (0x00)
> @ MGMT Event: PHY Configuration Changed (0x0026) plen 4
>         Selected PHYs: 0x0e00
>           LE 1M TX
>           LE 1M RX
>           LE 2M TX
> ---
>  tools/btmgmt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
> index 9101882..62b86f4 100644
> --- a/tools/btmgmt.c
> +++ b/tools/btmgmt.c
> @@ -4539,7 +4539,10 @@ static const struct bt_shell_menu main_menu = {
>                 cmd_clr_adv,            "Clear advertising instances"   },
>         { "appearance",         "<appearance>",
>                 cmd_appearance,         "Set appearance"                },
> -       { "phy",                "[phys]",
> +       { "phy",                "[1MTX] [1MRX] [2MTX] [2MRX] [CODEDTX] [CODEDRX] \
> +                                [BR1M1SLOT] [BR1M3SLOT] [BR1M5SLOT] \
> +                                [EDR2M1SLOT] [EDR2M3SLOT] [EDR2M5SLOT] \
> +                                [EDR3M1SLOT] [EDR3M3SLOT] [EDR3M5SLOT]",

Usually we format multi-line strings by ending it on each like and
continue on the following, the \ is only used in macros.

>                 cmd_phy,                "Get/Set PHY Configuration"     },
>         {} },
>  };
> --
> 1.9.1
>



-- 
Luiz Augusto von Dentz
