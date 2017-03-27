Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1490577507-28351-2-git-send-email-hyuk0512@gmail.com>
References: <CGME20170327011834epcas1p33f7e12ea5b0032ded858aa6f611aa016@epcas1p3.samsung.com>
 <1490577507-28351-1-git-send-email-hyuk0512@gmail.com> <1490577507-28351-2-git-send-email-hyuk0512@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 27 Mar 2017 13:54:36 +0300
Message-ID: <CABBYNZJvVzP7JzHWqvF1ng3x0sb+7GpNWMAGsa5sATaX7mMBUA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] src/adapter: Add the NULL check for response
To: hyuk0512@gmail.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Lee Hyuk <hyuk0512.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Mar 27, 2017 at 4:18 AM,  <hyuk0512@gmail.com> wrote:
> From: Lee Hyuk <hyuk0512.lee@samsung.com>
>
> The response can be NULL pointer. It should be checked.
> ---
>  src/adapter.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 3dac7d6..472b817 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1227,6 +1227,9 @@ static void passive_scanning_complete(uint8_t status, uint16_t length,
>         struct btd_adapter *adapter = user_data;
>         const struct mgmt_cp_start_discovery *rp = param;
>
> +       if (!rp)
> +               return;
> +
>         DBG("status 0x%02x", status);
>
>         if (length < sizeof(*rp)) {
> --
> 1.9.1

It looks like you might have a broken kernel in this regard since
Start Discovery shall always return the parameters given and in case
it doesn't it is probably a nice thing to log an error.

-- 
Luiz Augusto von Dentz
