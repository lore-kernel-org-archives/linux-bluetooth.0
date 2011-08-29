Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314373178-11337-6-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1314373178-11337-6-git-send-email-frederic.dalleau@linux.intel.com>
Date: Mon, 29 Aug 2011 11:34:49 +0300
Message-ID: <CABBYNZKqmM6pXOkcHazpxD21uPdLyY86mFaFN6bEThETZfXe4w@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] Set state to "connecting" on connection requested
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/8/26 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> This change will become necessary when
> integrating the Audio interface which rely on
> state change to confirm that connection
> has started successfully.
> ---
>  audio/gateway.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index 7bab77c..353473b 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -503,8 +503,6 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
>        }
>
>        g_io_channel_unref(io);
> -
> -       change_state(dev, GATEWAY_STATE_CONNECTING);
>        return;
>
>  fail:
> @@ -530,6 +528,7 @@ static int get_records(struct audio_device *device)
>  {
>        uuid_t uuid;
>
> +       change_state(device, GATEWAY_STATE_CONNECTING);
>        sdp_uuid16_create(&uuid, HANDSFREE_AGW_SVCLASS_ID);
>        return bt_search_service(&device->src, &device->dst, &uuid,
>                                get_record_cb, device, NULL);
> --
> 1.7.1
>

How about incoming connections? If you take a look at headset,
audio/manage.c set HEADSET_STATE_CONNECTING, I guess we should have
something similar to gateway, right?

-- 
Luiz Augusto von Dentz
