Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1397610266-20894-2-git-send-email-armansito@chromium.org>
References: <1397610266-20894-1-git-send-email-armansito@chromium.org>
	<1397610266-20894-2-git-send-email-armansito@chromium.org>
Date: Sat, 19 Apr 2014 16:07:08 -0700
Message-ID: <CAHrH25RW=NKRMf-xyOfJx0B67T2iQwoT3praY+BZM+s74prCxA@mail.gmail.com>
Subject: Re: [RFC 1/2] src/shared/att: Introduce struct bt_att.
From: Arman Uguray <armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Caught two bugs in bt_att_cancel:

> +bool bt_att_cancel(struct bt_att *att, unsigned int id)
> +{
> +       struct bt_att_request *request;
> +
> +       if (!request || !id)
> +               return false;

This above if statement should be:

if (!att || !id)
        return false;

> +
> +       request = queue_remove_if(att->request_queue, match_request_id,
> +                                                       UINT_TO_PTR(id));
> +       if (request)
> +               goto done;
> +
> +       request = queue_remove_if(att->pending_list, match_request_id,
> +                                                       UINT_TO_PTR(id));
> +       if (request)
> +               goto done;

The above if statement should be:

if (!request)
        return false;

> +
> +done:
> +       destroy_request(request);
> +
> +       wakeup_writer(att);
> +
> +       return true;
> +}

-Arman
