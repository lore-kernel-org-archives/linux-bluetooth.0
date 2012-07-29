Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343420976-19921-1-git-send-email-eder.ruiz@openbossa.org>
References: <1343420976-19921-1-git-send-email-eder.ruiz@openbossa.org>
From: Sergio Correia <lists@uece.net>
Date: Sat, 28 Jul 2012 21:47:45 -0400
Message-ID: <CAJyhjX1tPq0WCvZACf=sp6sCHoqwvOE2WZ3F8FwndJ5vmCRTQA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] att: Add prepare write support
To: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eder,

On Fri, Jul 27, 2012 at 4:29 PM, Eder Ruiz Maria
<eder.ruiz@openbossa.org> wrote:
> Add functions for encoding/decoding Prepare Write Request and
> Response PDUs.
> ---
>  attrib/att.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  attrib/att.h |    5 +++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/attrib/att.c b/attrib/att.c
> index 0550ac1..acfb4e0 100644
> --- a/attrib/att.c
> +++ b/attrib/att.c
> @@ -974,3 +974,58 @@ uint16_t dec_mtu_resp(const uint8_t *pdu, int len, uint16_t *mtu)
>
>         return min_len;
>  }
> +
> +uint16_t enc_prep_write_req(uint16_t handle, uint16_t offset,
> +                       const uint8_t *value, int vlen, uint8_t *pdu, int len)
> +{
> +       const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle) +
> +                                                               sizeof(offset);
> +
> +       if (pdu == NULL)
> +               return 0;
> +
> +       if (len < min_len)
> +               return 0;

maybe it would be better to check the above conditions in a single if statement?

[...]

> +uint16_t dec_prep_write_resp(const uint8_t *pdu, int len, uint16_t *handle,
> +                               uint16_t *offset, uint8_t *value, int *vlen)
> +{
> +       const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle) +
> +                                                               sizeof(*offset);
> +
> +       if (pdu == NULL)
> +               return 0;
> +
> +       if (handle == NULL || offset == NULL || value == NULL || vlen == NULL)
> +               return 0;
> +
> +       if (len < min_len)
> +               return 0;
> +
> +       if (pdu[0] != ATT_OP_PREP_WRITE_REQ)
> +               return 0;

same with the above sanity checking.
The other patches in this series could also do the same, assuming it's
the preferred way.

> +
> +       *handle = att_get_u16(&pdu[1]);
> +       *offset = att_get_u16(&pdu[3]);
> +       *vlen = len - min_len;
> +       if (*vlen > 0)
> +               memcpy(value, pdu + min_len, *vlen);
> +
> +       return len;
> +}
> +
> diff --git a/attrib/att.h b/attrib/att.h
> index 1c1102a..ec03be9 100644
> --- a/attrib/att.h
> +++ b/attrib/att.h
> @@ -256,3 +256,8 @@ uint16_t enc_mtu_req(uint16_t mtu, uint8_t *pdu, int len);
>  uint16_t dec_mtu_req(const uint8_t *pdu, int len, uint16_t *mtu);
>  uint16_t enc_mtu_resp(uint16_t mtu, uint8_t *pdu, int len);
>  uint16_t dec_mtu_resp(const uint8_t *pdu, int len, uint16_t *mtu);
> +
> +uint16_t enc_prep_write_req(uint16_t handle, uint16_t offset,
> +                       const uint8_t *value, int vlen, uint8_t *pdu, int len);
> +uint16_t dec_prep_write_resp(const uint8_t *pdu, int len, uint16_t *handle,
> +                               uint16_t *offset, uint8_t *value, int *vlen);
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
