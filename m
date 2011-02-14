Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1297891081-27976-3-git-send-email-bgix@codeaurora.org>
References: <1297891081-27976-1-git-send-email-bgix@codeaurora.org>
	<1297891081-27976-3-git-send-email-bgix@codeaurora.org>
Date: Mon, 14 Feb 2011 18:53:01 -0300
Message-ID: <AANLkTikCnorqDid1cRYmCm=-Jq04K67wJOHpOdWE8Pn+@mail.gmail.com>
Subject: Re: [PATCH 2/3] Add SDP registration of Primary GATT services
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com,
	padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Feb 16, 2011 at 6:18 PM, Brian Gix <bgix@codeaurora.org> wrote:
> SDP registration can be supressed by passing Zero as the end
> handle argument to attrib_db_add().
> ---
>  attrib/example.c    |  119 +++++++++++++++++++++++++++++++------------
>  src/attrib-server.c |  139 +++++++++++++++++++++++++++++++++++----------------
>  src/attrib-server.h |    6 ++-
>  3 files changed, 184 insertions(+), 80 deletions(-)
>
> diff --git a/attrib/example.c b/attrib/example.c
> index 1911912..eab3c0f 100644
> --- a/attrib/example.c
> +++ b/attrib/example.c
> @@ -31,6 +31,7 @@
>
>  #include <bluetooth/sdp.h>
>  #include <bluetooth/sdp_lib.h>
> +#include <src/sdpd.h>
>
>  #include <glib.h>
>
> @@ -59,6 +60,9 @@
>  #define FMT_KILOGRAM_UUID              0xA010
>  #define FMT_HANGING_UUID               0xA011
>
> +#define SDP_RECORD_COUNT 10
> +sdp_record_t *sdp_records[SDP_RECORD_COUNT];
> +
>  static int register_attributes(void)
>  {
>        const char *desc_out_temp = "Outside Temperature";
> @@ -77,59 +81,73 @@ static int register_attributes(void)
>        uint8_t atval[256];
>        uuid_t uuid;
>        int len;
> +       int i = 0;
>
>        /* Battery state service: primary service definition */
>        sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
>        att_put_u16(BATTERY_STATE_SVC_UUID, &atval[0]);
> -       attrib_db_add(0x0100, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
> +       sdp_records[i++] = attrib_db_add(0x0100, 0x0111, &uuid,
> +                                               "Battery State Service",
> +                                               ATT_NONE, ATT_NOT_PERMITTED,
> +                                               atval, 2);

What if instead of changing attrib_db_add() signature to return a SDP
record, you create a "sdp_record_from_attrib()" for this purpose? This
function could get the struct attribute * pointers for start/end.

There are plans for attrib_db_add() to return the created struct
attribute *a (as shown in a patch I sent sometime ago which I still
need to resend), I can send an updated version of that patch if you
agree to this approach.

> @@ -609,7 +603,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
>  static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
>                uint8_t *pdu, int len)
>  {
> -       channel->mtu = MIN(mtu, ATT_MAX_MTU);
> +       channel->mtu = MIN(mtu, channel->mtu);
>
>        return enc_mtu_resp(channel->mtu, pdu, len);
>  }

This change looks unrelated to the patch.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
