Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1408703129-12414-1-git-send-email-luiz.dentz@gmail.com>
References: <1408703129-12414-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 25 Aug 2014 11:49:33 +0300
Message-ID: <CABBYNZLkK1X-e+p_xfMmduXeY9GjFB+Tx1YP6H5psFba_iFaYQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor: Add helper functions to get data from
 L2CAP frames
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Aug 22, 2014 at 1:25 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  monitor/l2cap.h | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 109 insertions(+), 9 deletions(-)
>
> diff --git a/monitor/l2cap.h b/monitor/l2cap.h
> index a0f844b..645e3ef 100644
> --- a/monitor/l2cap.h
> +++ b/monitor/l2cap.h
> @@ -40,15 +40,115 @@ struct l2cap_frame {
>  static inline void l2cap_frame_pull(struct l2cap_frame *frame,
>                                 const struct l2cap_frame *source, uint16_t len)
>  {
> -       frame->index   = source->index;
> -       frame->in      = source->in;
> -       frame->handle  = source->handle;
> -       frame->cid     = source->cid;
> -       frame->psm     = source->psm;
> -       frame->chan    = source->chan;
> -       frame->mode    = source->mode;
> -       frame->data    = source->data + len;
> -       frame->size    = source->size - len;
> +       if (frame != source) {
> +               frame->index   = source->index;
> +               frame->in      = source->in;
> +               frame->handle  = source->handle;
> +               frame->cid     = source->cid;
> +               frame->psm     = source->psm;
> +               frame->chan    = source->chan;
> +               frame->mode    = source->mode;
> +       }
> +
> +       frame->data = source->data + len;
> +       frame->size = source->size - len;
> +}
> +
> +static inline int l2cap_frame_get_u8(struct l2cap_frame *frame, uint8_t *value)
> +{
> +       if (frame->size < sizeof(*value))
> +               return -1;
> +
> +       if (value)
> +               *value = *((uint8_t *) frame->data);
> +
> +       l2cap_frame_pull(frame, frame, sizeof(*value));
> +
> +       return 0;
> +}
> +
> +static inline int l2cap_frame_get_be16(struct l2cap_frame *frame,
> +                                                               uint16_t *value)
> +{
> +       if (frame->size < sizeof(*value))
> +               return -1;
> +
> +       if (value)
> +               *value = get_be16(frame->data);
> +
> +       l2cap_frame_pull(frame, frame, sizeof(*value));
> +
> +       return 0;
> +}
> +
> +static inline int l2cap_frame_get_le16(struct l2cap_frame *frame,
> +                                                               uint16_t *value)
> +{
> +       if (frame->size < sizeof(*value))
> +               return -1;
> +
> +       if (value)
> +               *value = get_le16(frame->data);
> +
> +       l2cap_frame_pull(frame, frame, sizeof(*value));
> +
> +       return 0;
> +}
> +
> +static inline int l2cap_frame_get_be32(struct l2cap_frame *frame,
> +                                                               uint32_t *value)
> +{
> +       if (frame->size < sizeof(*value))
> +               return -1;
> +
> +       if (value)
> +               *value = get_be32(frame->data);
> +
> +       l2cap_frame_pull(frame, frame, sizeof(*value));
> +
> +       return 0;
> +}
> +
> +static inline int l2cap_frame_get_le32(struct l2cap_frame *frame,
> +                                                               uint32_t *value)
> +{
> +       if (frame->size < sizeof(*value))
> +               return -1;
> +
> +       if (value)
> +               *value = get_le32(frame->data);
> +
> +       l2cap_frame_pull(frame, frame, sizeof(*value));
> +
> +       return 0;
> +}
> +
> +static inline int l2cap_frame_get_be64(struct l2cap_frame *frame,
> +                                                               uint64_t *value)
> +{
> +       if (frame->size < sizeof(*value))
> +               return -1;
> +
> +       if (value)
> +               *value = get_be64(frame->data);
> +
> +       l2cap_frame_pull(frame, frame, sizeof(*value));
> +
> +       return 0;
> +}
> +
> +static inline int l2cap_frame_get_le64(struct l2cap_frame *frame,
> +                                                               uint64_t *value)
> +{
> +       if (frame->size < sizeof(*value))
> +               return -1;
> +
> +       if (value)
> +               *value = get_le64(frame->data);
> +
> +       l2cap_frame_pull(frame, frame, sizeof(*value));
> +
> +       return 0;
>  }
>
>  void l2cap_packet(uint16_t index, bool in, uint16_t handle, uint8_t flags,
> --
> 1.9.3

Pushed.


-- 
Luiz Augusto von Dentz
