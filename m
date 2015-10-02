Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1443701921-24460-1-git-send-email-kubax.t.pawlak@intel.com>
References: <1443701921-24460-1-git-send-email-kubax.t.pawlak@intel.com>
Date: Fri, 2 Oct 2015 10:36:44 +0300
Message-ID: <CABBYNZ+hd6sr8B+kXnwFQ47+BwOPkRBMpzeBm19qTCcR6=Oxgw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Handle HCI emulator setup errors
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Kuba Pawlak <kubax.t.pawlak@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kuba,

On Thu, Oct 1, 2015 at 3:18 PM, Kuba Pawlak <kubax.t.pawlak@intel.com> wrote:
> Missing return is causing confusing output from sco-tester:
>
>   Read Index List callback
>     Status: 0x00
>   Failed to setup HCI emulation
> eSCO CVSD - Success - pre setup failed
>   New hciemu instance created
> eSCO CVSD - Success - done
> ---
>  tools/sco-tester.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/sco-tester.c b/tools/sco-tester.c
> index d55d51a3155faacb43742271c2e7ea6754b9f42c..651fbe01d14e59b4580704b3319196620d9d54e5 100644
> --- a/tools/sco-tester.c
> +++ b/tools/sco-tester.c
> @@ -160,6 +160,7 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
>         if (!data->hciemu) {
>                 tester_warn("Failed to setup HCI emulation");
>                 tester_pre_setup_failed();
> +               return;
>         }
>
>         tester_print("New hciemu instance created");
> --
> 1.9.3

Applied, thanks.


-- 
Luiz Augusto von Dentz
