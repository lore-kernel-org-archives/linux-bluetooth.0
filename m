Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1398792330-23636-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1398792330-23636-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Wed, 30 Apr 2014 15:54:09 +0300
Message-ID: <CABBYNZK9VBAdqc+G+DTjb6tOLRDs0Jjw06taCLSNXfKyG_k9ug@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hog: Fix checking for Report ID item presence
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tue, Apr 29, 2014 at 8:25 PM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> Report ID item in Report Descriptor is now detected by simply looking
> for applicable item prefixes anywhere in data and does not take items
> structure into consideration. This could lead to false-positive
> detections in case value we look for is just part of item data, not an
> actual item prefix.
>
> As defined in Device Class Definition for HID (6.2.2.7), Report ID is
> a short item with prefix 100001nn (binary) thus we do not need to do
> complete parsing of Report Descriptor but only need to check items
> prefixes in order to find Report ID items reliably.
>
> This patch checks Report Descriptor item by item looking for item
> prefix which matches Report ID, as defined in spec above.
> ---
> v2:
> - more verbose commit description
> - changed parse_descriptor_item() to get_descriptor_item_info()
> - reformatted get_descriptor_item_info() a bit
>
>  profiles/input/hog.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 62 insertions(+), 5 deletions(-)
>
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index a11e04e..767bcfa 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -345,6 +345,46 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
>                                         external_service_char_cb, hogdev);
>  }
>
> +static bool get_descriptor_item_info(uint8_t *buf, ssize_t blen, ssize_t *len,
> +                                                               bool *is_long)
> +{
> +       if (!blen)
> +               return false;
> +
> +       *is_long = (buf[0] == 0xfe);
> +
> +       if (*is_long) {
> +               if (blen < 3)
> +                       return false;
> +
> +               /*
> +                * long item:
> +                * byte 0 -> 0xFE
> +                * byte 1 -> data size
> +                * byte 2 -> tag
> +                * + data
> +                */
> +
> +               *len = buf[1] + 3;
> +       } else {
> +               uint8_t b_size;
> +
> +               /*
> +                * short item:
> +                * byte 0[1..0] -> data size (=0, 1, 2, 4)
> +                * byte 0[3..2] -> type
> +                * byte 0[7..4] -> tag
> +                * + data
> +                */
> +
> +               b_size = buf[0] & 0x03;
> +               *len = (b_size ? 1 << (b_size - 1) : 0) + 1;
> +       }
> +
> +       /* item length should be no more than input buffer length */
> +       return *len <= blen;
> +}
> +
>  static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>                                                         gpointer user_data)
>  {
> @@ -355,6 +395,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>         uint16_t vendor_src, vendor, product, version;
>         ssize_t vlen;
>         int i;
> +       int next_item = 0;
>
>         if (status != 0) {
>                 error("Report Map read failed: %s", att_ecode2str(status));
> @@ -369,11 +410,27 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>
>         DBG("Report MAP:");
>         for (i = 0; i < vlen; i++) {
> -               switch (value[i]) {
> -               case 0x85:
> -               case 0x86:
> -               case 0x87:
> -                       hogdev->has_report_id = TRUE;
> +               ssize_t ilen = 0;
> +               bool long_item = false;
> +
> +               if (i == next_item) {
> +                       if (get_descriptor_item_info(&value[i], vlen - i,
> +                                                       &ilen, &long_item)) {
> +                               /*
> +                                * Report ID is short item with prefix 100001xx
> +                                */
> +                               if (!long_item && (value[i] & 0xfc) == 0x84)
> +                                       hogdev->has_report_id = TRUE;
> +
> +                               next_item += ilen;
> +                       } else {
> +                               error("Report Map parsing failed at %d", i);
> +
> +                               /*
> +                                * We do not increase next_item here so we won't
> +                                * parse subsequent data - this is what we want.
> +                                */
> +                       }
>                 }
>
>                 if (i % 2 == 0) {
> --
> 1.9.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
