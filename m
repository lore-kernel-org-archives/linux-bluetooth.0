Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE6CC282C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 11:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5971820870
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 11:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtJuonBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfAWLYC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:24:02 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44842 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfAWLYB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 06:24:01 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so1460586oig.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jan 2019 03:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=8CmZTpoO7WzlV8VipA8BQzD5kWg0/6j/W5scHpA7UOk=;
        b=qtJuonBCaj1Rve07xOY5SzB8yvXaCn9umbUpMbMENrWU4ux+g5aAjhnshENX81o/T0
         U6VxS0HAkXR0A8tep5Zd50qhrSSY8FaTmP5NaAxCzF12tKCBgWrwIz2EevtgYNPP9/4e
         MrNKyNIjTPLYdbpRbLfu5+4mFWncd4Z+ciPP2kdHnn4d7wz3n+8Oep+E/Iqzw8Ug8AFd
         4lNcmKA/7cQ70jW7nzrI8AJ6ZGi1aQ24F583tbMpKSTr5VjA5rAp2f4YeOlBF900duKn
         2qrB5MKvFEzLlJ4Rc4pqfhgsOB2N041AcO5FYc+puIhXgdZ8wlkPKxzzWVGecXvxdmJQ
         LJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=8CmZTpoO7WzlV8VipA8BQzD5kWg0/6j/W5scHpA7UOk=;
        b=Z2/EFc604mgVxsMyS++YRoPZSvKERKSG6r/b8D6dnKdoeEU2JNMG5KglCU1+q5GwQb
         vZIG2bs8b2vp5+msB3NRjt/vV6j/oa+hRkOxNvI8eeGNdWjAXrWHVVJ12PRRUIdbJPiT
         sRn1QysyIgAny49AsIi9nnz0TgRv8s27voqwviaJ1EqrUuXLnoojFJvGr1fXsrGU7XVb
         eDId9OsStH9EXvGlLojCkcpBwMYrBOGsqwQtk0+TFUllzkHmr4hlMgunk7Hh3TPheDYS
         CD0XcB9ZFyilJuC+/EnU0G3idJ4gzBsECDlNHErcCjQcQQH6cpQh88n00ZFHu8JIHK+O
         aNnQ==
X-Gm-Message-State: AJcUukfZpkZub0tsW1doI/HFvD6RyATH3SJYeGEpk08pwgMMSwBJc7xU
        qKtgS0yTRqySuX6N9Xdfxaq0eZ+zmQqIWIQHz5/b1iLA
X-Google-Smtp-Source: ALg8bN6nzGHm1jZa954kSyjHk03C9DFbwMx6M0yGvLM5vqG7IP7dO2fYy+uHFVwC+sbn1ZJymSJaZWCE85b6vu8jScA=
X-Received: by 2002:aca:5e09:: with SMTP id s9mr1053725oib.153.1548242640311;
 Wed, 23 Jan 2019 03:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20190121115745.5353-1-luiz.dentz@gmail.com>
In-Reply-To: <20190121115745.5353-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 23 Jan 2019 13:23:48 +0200
Message-ID: <CABBYNZJA-seDm0hT49uWda0fsRr4w6BWji_giDnHGzPBrtZdEA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] avdtp: Fix always destroying session immediatelly
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Mon, Jan 21, 2019 at 1:57 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> In case the remote device sent a close/abort the session shall not be
> free immediatelly as the remote may want to reconfigure the stream.
> ---
>  profiles/audio/avdtp.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 4f964feb5..f4c9a2ed8 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -412,6 +412,7 @@ struct avdtp {
>         struct pending_req *req;
>
>         guint dc_timer;
> +       int dc_timeout;
>
>         /* Attempt stream setup instead of disconnecting */
>         gboolean stream_setup;
> @@ -1152,10 +1153,12 @@ static void set_disconnect_timer(struct avdtp *session)
>         if (session->dc_timer)
>                 remove_disconnect_timer(session);
>
> -       if (!session->stream_setup && !session->streams)
> +       DBG("timeout %d", session->dc_timeout);
> +
> +       if (!session->dc_timeout)
>                 session->dc_timer = g_idle_add(disconnect_timeout, session);
>         else
> -               session->dc_timer = g_timeout_add_seconds(DISCONNECT_TIMEOUT,
> +               session->dc_timer = g_timeout_add_seconds(session->dc_timeout,
>                                                         disconnect_timeout,
>                                                         session);
>  }
> @@ -1797,6 +1800,8 @@ static gboolean avdtp_close_cmd(struct avdtp *session, uint8_t transaction,
>
>         avdtp_sep_set_state(session, sep, AVDTP_STATE_CLOSING);
>
> +       session->dc_timeout = DISCONNECT_TIMEOUT;
> +
>         if (!avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
>                                                 AVDTP_CLOSE, NULL, 0))
>                 return FALSE;
> @@ -1893,8 +1898,10 @@ static gboolean avdtp_abort_cmd(struct avdtp *session, uint8_t transaction,
>
>         ret = avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
>                                                 AVDTP_ABORT, NULL, 0);
> -       if (ret)
> +       if (ret) {
>                 avdtp_sep_set_state(session, sep, AVDTP_STATE_ABORTING);
> +               session->dc_timeout = DISCONNECT_TIMEOUT;
> +       }
>
>         return ret;
>  }
> @@ -2377,6 +2384,8 @@ struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
>          * with respect to the disconnect timer */
>         session->stream_setup = TRUE;
>
> +       session->dc_timeout = DISCONNECT_TIMEOUT;
> +
>         avdtp_connect_cb(chan, NULL, session);
>
>         return session;
> @@ -3512,8 +3521,10 @@ int avdtp_close(struct avdtp *session, struct avdtp_stream *stream,
>
>         ret = send_request(session, FALSE, stream, AVDTP_CLOSE,
>                                                         &req, sizeof(req));
> -       if (ret == 0)
> +       if (ret == 0) {
>                 stream->close_int = TRUE;
> +               session->dc_timeout = 0;
> +       }
>
>         return ret;
>  }
> @@ -3561,8 +3572,10 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
>
>         ret = send_request(session, TRUE, stream, AVDTP_ABORT,
>                                                         &req, sizeof(req));
> -       if (ret == 0)
> +       if (ret == 0) {
>                 stream->abort_int = TRUE;
> +               session->dc_timeout = 0;
> +       }
>
>         return ret;
>  }
> --
> 2.17.2

Applied.

-- 
Luiz Augusto von Dentz
