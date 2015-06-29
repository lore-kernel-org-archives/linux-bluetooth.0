Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1435319940-13943-1-git-send-email-luiz.dentz@gmail.com>
References: <1435319940-13943-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 29 Jun 2015 10:59:20 +0300
Message-ID: <CABBYNZK30mjyMmbcCsjGVrAeiFK8unfb4wdHCz8bcx3QBja5GA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] core: Print store_hint in new_link_key_callback
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jun 26, 2015 at 2:58 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This is useful information when debugging because that indicates
> no-bonding was used so device will remain temporary even though it is
> paired.
> ---
>  src/adapter.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 95b5349..531f276 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -6696,8 +6696,9 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
>
>         ba2str(&addr->bdaddr, dst);
>
> -       DBG("hci%u new key for %s type %u pin_len %u", adapter->dev_id,
> -                                       dst, ev->key.type, ev->key.pin_len);
> +       DBG("hci%u new key for %s type %u pin_len %u store_hint %u",
> +               adapter->dev_id, dst, ev->key.type, ev->key.pin_len,
> +               ev->store_hint);
>
>         if (ev->key.pin_len > 16) {
>                 error("Invalid PIN length (%u) in new_key event",
> --
> 2.1.0

Applied.


-- 
Luiz Augusto von Dentz
