Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1424304754-11874-2-git-send-email-armansito@chromium.org>
References: <1424304754-11874-1-git-send-email-armansito@chromium.org>
	<1424304754-11874-2-git-send-email-armansito@chromium.org>
Date: Thu, 19 Feb 2015 14:41:19 +0200
Message-ID: <CABBYNZK-JCCwrw+PLoLEiD-WMGWPi+_FoRBvTnM-iM9h=AL9XA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] core: gatt: Fix incorrect response on CCC read
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Thu, Feb 19, 2015 at 2:12 AM, Arman Uguray <armansito@chromium.org> wrote:
> This patch fixes a bug where a CCC read on the local GATT server always
> returned a 0-length value.
> ---
>  src/gatt-database.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 5e83ce1..e876141 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -495,7 +495,7 @@ static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
>                 goto done;
>         }
>
> -       len -= offset;
> +       len = 2 - offset;
>         value = len ? &ccc->value[offset] : NULL;
>
>  done:
> @@ -517,7 +517,7 @@ static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
>
>         handle = gatt_db_attribute_get_handle(attrib);
>
> -       DBG("CCC read called for handle: 0x%04x", handle);
> +       DBG("CCC write called for handle: 0x%04x", handle);
>
>         if (!value || len != 2) {
>                 ecode = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
> --
> 2.2.0.rc0.207.ga3a616c

Applied, thanks.


-- 
Luiz Augusto von Dentz
