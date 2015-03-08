Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1425795255-832-1-git-send-email-hychao@chromium.org>
References: <1425795255-832-1-git-send-email-hychao@chromium.org>
Date: Sun, 8 Mar 2015 13:10:42 +0200
Message-ID: <CABBYNZLmzO3qbQitxNASXAwko4safOii5ugsZBJ-jwQs6+fTqA@mail.gmail.com>
Subject: Re: [PATCH v1] audio/media: Fix crash at endpoint handling no reply err
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Hsin-Yu Chao <hychao@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Arman Uguray <armansito@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Mar 8, 2015 at 8:14 AM, Hsin-Yu Chao <hychao@chromium.org> wrote:
> When handling DBUS_ERROR_NO_REPLY error in media endpoint, the
> a2dp_setup gets unref'ed in the associated request callback when
> it's called for the first time.  A crash happens in the later
> clear_endpoint call with below backtrace that, the request callback
> will be triggered again with NULL session.
> To fix this, remove the additional request callback so that every
> callback only gets triggered for once in clear_endpoint.
>
> 0xb6f30d44 [bluetoothd -avdtp.c:1421 ] setconf_cb
> 0xb6f2c3bb [bluetoothd -a2dp.c:407 ]   auto_config
> 0xb6f32c39 [bluetoothd -media.c:137 ]  media_endpoint_cancel
> 0xb6f32e8d [bluetoothd -media.c:145 ]  clear_endpoint
> 0xb6f32faf [bluetoothd -media.c:276 ]  endpoint_reply
>
> ---
>  profiles/audio/media.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 965b32a..762758b 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -270,9 +270,6 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
>
>                 /* Clear endpoint configuration in case of NO_REPLY error */
>                 if (dbus_error_has_name(&err, DBUS_ERROR_NO_REPLY)) {
> -                       if (request->cb)
> -                               request->cb(endpoint, NULL, size,
> -                                                       request->user_data);
>                         clear_endpoint(endpoint);
>                         dbus_message_unref(reply);
>                         dbus_error_free(&err);
> --
> 2.1.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
