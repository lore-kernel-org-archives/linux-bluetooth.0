Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1398763780-16592-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1398763780-16592-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Tue, 29 Apr 2014 15:37:46 +0300
Message-ID: <CABBYNZL=gidP7m89NACUPBnL87+JDO3kG8zHLHCbz7_+3-WCXw@mail.gmail.com>
Subject: Re: [PATCH 1/2] hog: Fix checking for Report ID item
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tue, Apr 29, 2014 at 12:29 PM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> Report ID item is detected by just looking for possible item prefixes
> anywhere in report map. This could lead to false-positive detection if
> value we look for is inside item data.
>
> This patch adds simple parser which can split report map into proper
> items and check for Report ID item in reliable way.

Well it looks like the format of each descriptor can be different so I
would add this to the patch description and probably quote from spec
what is those formats.

> ---
>  profiles/input/hog.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 55 insertions(+), 5 deletions(-)
>
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index a11e04e..ab88414 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -345,6 +345,39 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
>                                         external_service_char_cb, hogdev);
>  }
>
> +static bool parse_descriptor_item(uint8_t *buf, ssize_t blen, ssize_t *len,
> +                                                               bool *is_long)
> +{
> +       if (!blen)
> +               return false;
> +
> +       if (buf[0] == 0xFE) {
> +               if (blen < 3)
> +                       return false;
> +               /* long item:
> +                * byte 0 -> 0xFE
> +                * byte 1 -> data size
> +                * byte 2 -> tag
> +                * + data
> +                */
> +               *len = buf[1] + 3;
> +               *is_long = true;
> +       } else {
> +               uint8_t b_size;
> +               /* short item:
> +                * byte 0[1..0] -> data size (=0, 1, 2, 4)
> +                * byte 0[3..2] -> type
> +                * byte 0[7..4] -> tag
> +                * + data
> +                */
> +               b_size = buf[0] & 0x03;
> +               *len = (b_size ? 1 << (b_size - 1) : 0) + 1;
> +               *is_long = false;
> +       }

Perhaps split this into 2 functions one to parse sort descriptors and
one for long descriptors, also you can probably drop the item suffix
e.g.: parse_short_descriptor, parse_long_descriptor.

> +       return *len <= blen;
> +}
> +
>  static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>                                                         gpointer user_data)
>  {
> @@ -355,6 +388,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>         uint16_t vendor_src, vendor, product, version;
>         ssize_t vlen;
>         int i;
> +       int next_item = 0;
>
>         if (status != 0) {
>                 error("Report Map read failed: %s", att_ecode2str(status));
> @@ -369,11 +403,27 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>
>         DBG("Report MAP:");
>         for (i = 0; i < vlen; i++) {
> -               switch (value[i]) {
> -               case 0x85:
> -               case 0x86:
> -               case 0x87:
> -                       hogdev->has_report_id = TRUE;
> +               ssize_t item_len = 0;
> +               bool is_long_item = false;
> +
> +               if (i == next_item) {
> +                       if (parse_descriptor_item(&value[i], vlen - i,
> +                                                       &item_len,
> +                                                       &is_long_item)) {
> +                               /* Report ID is short item with prefix
> +                                * 100001xx (binary)
> +                                */
> +                               if (!is_long_item && (value[i] & 0xfc) == 0x84)

Hmm, so long descriptors are ignored? Is that really what we want?

> +                                       hogdev->has_report_id = TRUE;
> +
> +                               next_item += item_len;
> +                       } else {
> +                               error("Report Map parsing failed at %d", i);
> +
> +                               /* We do not increase next_item here so we won't
> +                                * parse subsequent data - this is what we want.
> +                                */
> +                       }
>                 }
>
>                 if (i % 2 == 0) {
> --
> 1.9.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
