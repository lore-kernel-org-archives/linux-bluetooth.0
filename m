Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Feb 2009 13:12:58 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] audio: make *_suspend() use bt_stop_stream_rsp
Message-ID: <20090217111258.GA24132@localhost>
References: <1234867777-24745-1-git-send-email-marcandre.lureau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1234867777-24745-1-git-send-email-marcandre.lureau@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 17, 2009, Marc-André Lureau wrote:
> diff --git a/audio/unix.c b/audio/unix.c
> index 294155a..7fc4387 100644
> --- a/audio/unix.c
> +++ b/audio/unix.c
> @@ -352,7 +352,7 @@ static void headset_suspend_complete(struct audio_device *dev, void *user_data)
>  {
>  	struct unix_client *client = user_data;
>  	char buf[BT_SUGGESTED_BUFFER_SIZE];
> -	struct bt_start_stream_rsp *rsp = (void *) buf;
> +	struct bt_stop_stream_rsp *rsp = (void *) buf;
>  
>  	if (!dev)
>  		goto failed;
> @@ -613,7 +613,7 @@ static void a2dp_suspend_complete(struct avdtp *session,
>  {
>  	struct unix_client *client = user_data;
>  	char buf[BT_SUGGESTED_BUFFER_SIZE];
> -	struct bt_start_stream_rsp *rsp = (void *) buf;
> +	struct bt_stop_stream_rsp *rsp = (void *) buf;
>  	struct a2dp_data *a2dp = &client->d.a2dp;
>  
>  	if (err)

Pushed upstream. Thanks!

Johan
