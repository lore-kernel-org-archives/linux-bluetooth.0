Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1347371730-14933-2-git-send-email-mikel.astiz.oss@gmail.com>
References: <1347371730-14933-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1347371730-14933-2-git-send-email-mikel.astiz.oss@gmail.com>
Date: Thu, 20 Sep 2012 15:20:24 +0300
Message-ID: <CABBYNZ+J-URDs_301Z07K6T9g7idHF+HK0NUUfuaUfDKmOrnDg@mail.gmail.com>
Subject: Re: [PATCH v0 1/4] adapter: Replace device authorizing flag
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Sep 11, 2012 at 4:55 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> Refactor code to drop the device authorizing flag by replacing it with a
> private authorization pointer in btd_adapter. After all, no more than
> one authorization can be ongoing, so the code is easier to follow if
> this is made explicit.
> ---
>  src/adapter.c |   48 ++++++++++++++++++++++++++++++++----------------
>  src/device.c  |   11 -----------
>  src/device.h  |    2 --
>  3 files changed, 32 insertions(+), 29 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 4b675e8..14c5322 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -128,7 +128,8 @@ struct btd_adapter {
>         GSList *found_devices;
>         GSList *oor_devices;            /* out of range device list */
>         struct agent *agent;            /* For the new API */
> -       guint auth_idle_id;             /* Ongoing authorization */
> +       guint auth_idle_id;             /* Ongoing authorization (trusted) */
> +       struct service_auth *auth;      /* Ongoing authorization */

You should probably store the id directly inside struct service_auth
as they depend on each other then when you free auth you also remove
the id if not set to 0.

-- 
Luiz Augusto von Dentz
