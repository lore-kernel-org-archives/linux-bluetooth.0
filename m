Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1425614285-8938-1-git-send-email-hychao@chromium.org>
References: <1425614285-8938-1-git-send-email-hychao@chromium.org>
Date: Fri, 6 Mar 2015 08:06:01 -0800
Message-ID: <CAHrH25QDy5krahDcrUNa_NP6cFwXog+9EDRTK7fSLkoGNcOn2A@mail.gmail.com>
Subject: Re: [PATCH] audio/media: Fix crash at endpoint handling no reply err
From: Arman Uguray <armansito@chromium.org>
To: Hsin-Yu Chao <hychao@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hsin-yu,

> On Thu, Mar 5, 2015 at 7:58 PM, Hsin-Yu Chao <hychao@chromium.org> wrote:
> When handling DBUS_ERROR_NO_REPLY error in media endpoint,
> the a2dp_setup gets unref'ed in the associated request callback.
> We need to remove the request from list once it has been
> handled, or in the following clear_endpoint call this
> request callback will be triggered again with NULL session
> and cause crash.
>

Can you please post a stack trace in the commit message? You can look
for examples in the git log.

> ---
>  profiles/audio/media.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 965b32a..0bb82eb 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -273,6 +273,9 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
>                         if (request->cb)
>                                 request->cb(endpoint, NULL, size,
>                                                         request->user_data);
> +                       endpoint->requests = g_slist_remove(endpoint->requests,
> +                                                           request);
> +                       endpoint_request_free(request);

I had a brief chat with Luiz and he said that another, potentially
cleaner fix, would be to remove the lines above that invoke the
callback ("if (request->cb) request->cb(...)"), since that should
prevent the callback from executing twice. Can you see if that fixes
the crash?

Send a v1 whenever you have a new patch ready (run git format-patch
with -v1). Also can you cc luiz.dentz@gmail.com?

>                         clear_endpoint(endpoint);
>                         dbus_message_unref(reply);
>                         dbus_error_free(&err);
> --
> 2.1.2
>

Thanks,
Arman
