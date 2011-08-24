Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314027047-5476-2-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1314027047-5476-2-git-send-email-frederic.dalleau@linux.intel.com>
Date: Wed, 24 Aug 2011 13:48:28 +0300
Message-ID: <CABBYNZJUPxjJzKdXL6iHXPGo-46WcwHd8aLcYL_47giPz0T3og@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] Fix double free in error case in endpoint_reply
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/8/22 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> If SetConfiguration call fails, the headset or gateway for which
> SetConfiguration is called is disconnected. This will free any
> pending request, but this does not prevent the request to
> terminate (endpoint_reply) and try to free itself once again.
> Note that a copy of the freed pointer is tested which has not
> been updated.
> ---
>  audio/media.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/audio/media.c b/audio/media.c
> index 42d8637..2076d04 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -264,7 +264,8 @@ done:
>        if (request->cb)
>                request->cb(endpoint, ret, size, request->user_data);
>
> -       endpoint_request_free(request);
> +       if (endpoint->request)
> +               endpoint_request_free(endpoint->request);
>        endpoint->request = NULL;
>  }
>
> --
> 1.7.1

Nice catch, ack.

-- 
Luiz Augusto von Dentz
