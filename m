Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1488235227-27632-2-git-send-email-juha.kuikka@synapse.com>
References: <1488235227-27632-1-git-send-email-juha.kuikka@synapse.com> <1488235227-27632-2-git-send-email-juha.kuikka@synapse.com>
From: Petri Gynther <pgynther@google.com>
Date: Mon, 27 Feb 2017 18:17:30 -0800
Message-ID: <CAGXr9JG_dKSjD31DW5=0TH5Y9YD_oFdpQ6t-MTek_2hCd7GzNg@mail.gmail.com>
Subject: Re: [PATCH] hog: Destroy uHID device when disconnected
To: Juha Kuikka <juha.kuikka@synapse.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        juha.kuikka@gmail.com,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Juha,

On Mon, Feb 27, 2017 at 2:40 PM, Juha Kuikka <juha.kuikka@synapse.com> wrote:
>
> Unlink bluetooth classic HID, HoG persists the uHID device after across
> connections. This is fine for stateless devices but some device utilize hidraw
> to configure them upon connection and with the persisting uHID device,
> reconnections are hidden from them.
>
> Similarly, applications such as game emulators may be using the presence of the
> HID or the accompanying input event devices to indicate that it is available,
> thus changing behavior.
>
> This patch destroys the uHID device upon disconnection, it gets re-created upon
> reconnection, just like on initial connection.

For HID and HoG remote controls, the reconnect latency is important
for user experience. Thus, it is desirable that the uHID device is
persistent across reconnects until next reboot.

How about adding a new config item to profiles/input/input.conf to
control this (default = persistent uHID devices)?

-- Petri

>
> ---
>  profiles/input/hog-lib.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index dab385f..f41055b 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -1565,6 +1565,25 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
>         }
>  }
>
> +static void destroy_uhid(struct bt_hog *hog)
> +{
> +       struct uhid_event ev = {
> +               .type = UHID_DESTROY
> +       };
> +       int err;
> +
> +       if (hog->uhid_created) {
> +               err = bt_uhid_send(hog->uhid, &ev);
> +               if (err < 0) {
> +                       error("bt_uhid_send: %s", strerror(-err));
> +                       return;
> +               }
> +               hog->uhid_created = false;
> +
> +               DBG("HoG destroyed uHID device");
> +       }
> +}
> +
>  bool bt_hog_attach(struct bt_hog *hog, void *gatt)
>  {
>         GSList *l;
> @@ -1651,6 +1670,8 @@ void bt_hog_detach(struct bt_hog *hog)
>         queue_foreach(hog->gatt_op, (void *) cancel_gatt_req, NULL);
>         g_attrib_unref(hog->attrib);
>         hog->attrib = NULL;
> +
> +       destroy_uhid(hog);
>  }
>
>  int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
