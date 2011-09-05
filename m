Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314805732-30418-5-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314805732-30418-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1314805732-30418-5-git-send-email-frederic.dalleau@linux.intel.com>
Date: Mon, 5 Sep 2011 11:10:49 +0300
Message-ID: <CABBYNZLmdM6tQ0+nmd+AR8ko_RZkVDN6q+b8-q5ws1oUEGq9Qw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] Set state to "connecting" on connection requested
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/8/31 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> This change will become necessary when
> integrating the Audio interface which rely on
> state change to confirm that connection
> has started successfully.
> ---
>  audio/gateway.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index 7b6c535..e5295c8 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -318,8 +318,6 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
>                goto fail;
>        }
>
> -       change_state(dev, GATEWAY_STATE_CONNECTING);
> -
>        sk = g_io_channel_unix_get_fd(chan);
>
>        gw->rfcomm = g_io_channel_ref(chan);
> @@ -494,8 +492,6 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
>        }
>
>        g_io_channel_unref(io);
> -
> -       change_state(dev, GATEWAY_STATE_CONNECTING);
>        return;
>
>  fail:
> @@ -515,6 +511,7 @@ static int get_records(struct audio_device *device)
>  {
>        uuid_t uuid;
>
> +       change_state(device, GATEWAY_STATE_CONNECTING);
>        sdp_uuid16_create(&uuid, HANDSFREE_AGW_SVCLASS_ID);
>        return bt_search_service(&device->src, &device->dst, &uuid,
>                                get_record_cb, device, NULL);
> @@ -758,6 +755,8 @@ int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
>
>        dev->gateway->rfcomm = g_io_channel_ref(io);
>
> +       change_state(dev, GATEWAY_STATE_CONNECTING);
> +

I suspect this will not track/close if the connection
fails/authorization is rejected, for headset we have headset_set_state
public and then if the authorization fails we set the state back to
disconnected so we properly signal that we are no longer connecting
and close the connection.


-- 
Luiz Augusto von Dentz
