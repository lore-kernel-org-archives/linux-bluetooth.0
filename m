Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1307827296-21363-1-git-send-email-cmdkhh@gmail.com>
References: <1307827296-21363-1-git-send-email-cmdkhh@gmail.com>
Date: Sat, 11 Jun 2011 14:26:01 -0700
Message-ID: <BANLkTimfBO3hGTMcvO7EspqqU5NdV8XKNQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/bluetooth/bpa10x.c: missing kfrees
From: Connor Hansen <cmdkhh@gmail.com>
To: marcel@holtmann.org
Cc: padovan@profusion.mobi, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, Connor Hansen <cmdkhh@gmail.com>
Content-Type: multipart/alternative; boundary=90e6ba6e8ed63a76af04a576559b
List-ID: <linux-bluetooth.vger.kernel.org>

--90e6ba6e8ed63a76af04a576559b
Content-Type: text/plain; charset=ISO-8859-1

sorry this contains an error, I will redo the patch

On Sat, Jun 11, 2011 at 2:21 PM, Connor Hansen <cmdkhh@gmail.com> wrote:
> both bpa10x_submit_initr_urb() and bpa10x_submit_bulk_urb()
> malloc a char buffer(buf) for usb_fill_init_usb() but fail to
> free it after freeing the urb.
>
> Likewise, bpa10x_send_frame() allocates a usb_ctrlrequest(dr)
> for sending packets but does not free it after the
> usb_fill_control_urb() call.
>
> Signed-off-by: Connor Hansen <cmdkhh@gmail.com>
> ---
>  drivers/bluetooth/bpa10x.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
> index 751b338..7dfd9ca 100644
> --- a/drivers/bluetooth/bpa10x.c
> +++ b/drivers/bluetooth/bpa10x.c
> @@ -254,6 +254,7 @@ static inline int bpa10x_submit_intr_urb(struct
hci_dev *hdev)
>        }
>
>        usb_free_urb(urb);
> +       kfree(buf);
>
>        return err;
>  }
> @@ -295,6 +296,7 @@ static inline int bpa10x_submit_bulk_urb(struct
hci_dev *hdev)
>        }
>
>        usb_free_urb(urb);
> +       kfree(buf);
>
>        return err;
>  }
> @@ -393,6 +395,7 @@ static int bpa10x_send_frame(struct sk_buff *skb)
>                                skb->data, skb->len, bpa10x_tx_complete,
skb);
>
>                hdev->stat.cmd_tx++;
> +               kfree(df);
>                break;
>
>        case HCI_ACLDATA_PKT:
> --
> 1.7.4.4
>
>

--90e6ba6e8ed63a76af04a576559b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

sorry this contains an error, I will redo the patch<br><br>On Sat, Jun 11, =
2011 at 2:21 PM, Connor Hansen &lt;<a href=3D"mailto:cmdkhh@gmail.com">cmdk=
hh@gmail.com</a>&gt; wrote:<br>&gt; both bpa10x_submit_initr_urb() and bpa1=
0x_submit_bulk_urb()<br>
&gt; malloc a char buffer(buf) for usb_fill_init_usb() but fail to<br>&gt; =
free it after freeing the urb.<br>&gt;<br>&gt; Likewise, bpa10x_send_frame(=
) allocates a usb_ctrlrequest(dr)<br>&gt; for sending packets but does not =
free it after the<br>
&gt; usb_fill_control_urb() call.<br>&gt;<br>&gt; Signed-off-by: Connor Han=
sen &lt;<a href=3D"mailto:cmdkhh@gmail.com">cmdkhh@gmail.com</a>&gt;<br>&gt=
; ---<br>&gt; =A0drivers/bluetooth/bpa10x.c | =A0 =A03 +++<br>&gt; =A01 fil=
es changed, 3 insertions(+), 0 deletions(-)<br>
&gt;<br>&gt; diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bp=
a10x.c<br>&gt; index 751b338..7dfd9ca 100644<br>&gt; --- a/drivers/bluetoot=
h/bpa10x.c<br>&gt; +++ b/drivers/bluetooth/bpa10x.c<br>&gt; @@ -254,6 +254,=
7 @@ static inline int bpa10x_submit_intr_urb(struct hci_dev *hdev)<br>
&gt; =A0 =A0 =A0 =A0}<br>&gt;<br>&gt; =A0 =A0 =A0 =A0usb_free_urb(urb);<br>=
&gt; + =A0 =A0 =A0 kfree(buf);<br>&gt;<br>&gt; =A0 =A0 =A0 =A0return err;<b=
r>&gt; =A0}<br>&gt; @@ -295,6 +296,7 @@ static inline int bpa10x_submit_bul=
k_urb(struct hci_dev *hdev)<br>
&gt; =A0 =A0 =A0 =A0}<br>&gt;<br>&gt; =A0 =A0 =A0 =A0usb_free_urb(urb);<br>=
&gt; + =A0 =A0 =A0 kfree(buf);<br>&gt;<br>&gt; =A0 =A0 =A0 =A0return err;<b=
r>&gt; =A0}<br>&gt; @@ -393,6 +395,7 @@ static int bpa10x_send_frame(struct=
 sk_buff *skb)<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0skb-&gt;data, skb-&gt;len, bpa10x_tx_complete, skb);<br>
&gt;<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hdev-&gt;stat.cmd_tx++;<br>&gt;=
 + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(df);<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0break;<br>&gt;<br>&gt; =A0 =A0 =A0 =A0case HCI_ACLDATA_PKT:<br>&gt; =
--<br>&gt; 1.7.4.4<br>&gt;<br>&gt;<br><br>

--90e6ba6e8ed63a76af04a576559b--
