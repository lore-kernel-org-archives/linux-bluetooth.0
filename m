Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <op.v0av70tbh52hc0@dhcp-25-209.brq.redhat.com>
References: <op.v0av70tbh52hc0@dhcp-25-209.brq.redhat.com>
Date: Tue, 16 Aug 2011 13:31:57 +0300
Message-ID: <CABBYNZJ3pUUQOcgRDUH21cMzPigiibQLem4ZViOLZJfFmvLpUQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] Added NULL check before dereferencing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Pavel Raiskup <praiskup@redhat.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"ovasik@redhat.com" <ovasik@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavel,

On Tue, Aug 16, 2011 at 12:49 PM, Pavel Raiskup <praiskup@redhat.com> wrote:
> ---
>  plugins/hciops.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/plugins/hciops.c b/plugins/hciops.c
> index ecc0e86..e975eb5 100644
> --- a/plugins/hciops.c
> +++ b/plugins/hciops.c
> @@ -593,7 +593,8 @@ static gboolean init_adapter(int index)
>        } else {
>                adapter = manager_find_adapter(&dev->bdaddr);
>                /* FIXME: manager_find_adapter should return a new ref */
> -               btd_adapter_ref(adapter);
> +               if (adapter)
> +                       btd_adapter_ref(adapter);

Perhaps we should either make manager_find_adapter to return a new ref
or create a function e.g. manager_get_adapter which does that for us.

-- 
Luiz Augusto von Dentz
