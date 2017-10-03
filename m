Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171002114740.9474-1-luiz.dentz@gmail.com>
References: <20171002114740.9474-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Oct 2017 17:50:50 +0300
Message-ID: <CABBYNZJw+R35a3g+s2qNEXYg7eoKZU_EAMDgXo-EGVgqW_-cNA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Fix not replying to Write request
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 2, 2017 at 2:47 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> When using AcquireWrite the first write would not call
> gatt_db_attribute_write_result so no reply would be generated.
> ---
>  src/gatt-database.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 4932568dd..e84c19198 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -1892,6 +1892,8 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
>                                 op->data.iov_len) < 0)
>                 goto retry;
>
> +       gatt_db_attribute_write_result(op->attrib, op->id, 0);
> +
>         return;
>
>  retry:
> --
> 2.13.5
>
Applied.


-- 
Luiz Augusto von Dentz
