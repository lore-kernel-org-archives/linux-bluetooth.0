Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1348501338-29639-4-git-send-email-mikel.astiz.oss@gmail.com>
References: <1348501338-29639-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1348501338-29639-4-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 25 Sep 2012 13:07:31 +0300
Message-ID: <CABBYNZLGW=QZHUQmWzHux+f4Lgg_HkSctUh7hcB6W+mPejX9Pg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] adapter: Queue parallel authorization requests
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Sep 24, 2012 at 6:42 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:

> +       g_queue_foreach(adapter->auths, (GFunc) g_free, NULL);
> +       g_queue_free(adapter->auths);

Above is probably a candidate to replace with g_queue_free_full

>  int btd_cancel_authorization(int auth_id)
>  {
> -       struct btd_adapter *adapter;
> -       struct agent *agent;
> -       int err;
> -
> -       adapter = find_authorization(auth_id);
> -       if (adapter == NULL)
> -               return -EPERM;
> -
> -       if (adapter->auth_idle_id) {
> -               g_source_remove(adapter->auth_idle_id);
> -               adapter->auth_idle_id = 0;
> -               g_free(adapter->auth);
> -               adapter->auth = NULL;
> -               return 0;
> -       }
> -
> -       /*
> -        * FIXME: Cancel fails if authorization is requested to adapter's
> -        * agent and in the meanwhile CreatePairedDevice is called.
> -        */
> +       struct service_auth *auth;
>
> -       agent = device_get_agent(adapter->auth->device);
> -       if (!agent)
> +       auth = find_authorization(auth_id);
> +       if (auth == NULL)
>                 return -EPERM;
>
> -       err = agent_cancel(agent);
> +       g_queue_remove(auth->adapter->auths, auth);
>
> -       if (err == 0) {
> -               g_free(adapter->auth);
> -               adapter->auth = NULL;
> -       }
> +       service_auth_cancel(auth);
>
> -       return err;
> +       return 0;
>  }

You can probably call id instead of auth_id, besides we normally use
uint/guint for handlers like this.

-- 
Luiz Augusto von Dentz
