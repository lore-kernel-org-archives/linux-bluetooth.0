Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1373854203-3338-1-git-send-email-martin.xu@linux.intel.com>
References: <1373854203-3338-1-git-send-email-martin.xu@linux.intel.com>
Date: Tue, 16 Jul 2013 14:36:37 +0300
Message-ID: <CABBYNZKwZK6DQOYf-yd76KD3on0dcpXe4VoPg2iNwWvQD+F7mg@mail.gmail.com>
Subject: Re: [PATCH] Obex/Session: Redefine session target property
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: martin.xu@linux.intel.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On Mon, Jul 15, 2013 at 5:10 AM,  <martin.xu@linux.intel.com> wrote:
> From: Martin <martin.xu@linux.intel.com>
>
> The definition of Target should be the same with Target parameter
> of CreateSession.
>
> And add TargetUUID to save the Obex service UUID
> ---
>  doc/obex-api.txt |    8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/doc/obex-api.txt b/doc/obex-api.txt
> index 22449c4..ad03690 100644
> --- a/doc/obex-api.txt
> +++ b/doc/obex-api.txt
> @@ -67,7 +67,15 @@ Properties   string Source [readonly]
>                         Bluetooth channel
>
>                 string Target [readonly]
> +                       The currently supported targets are the following:
> +
> +                               "ftp"
> +                               "map"
> +                               "opp"
> +                               "pbap"
> +                               "sync"
>
> +               string TargetUUID [readonly]
>                         Target UUID
>
>                 string Root [readonly]
> --
> 1.7.10.4

I wonder what is the benefit of yet another property, would the UI
double check if the UUID matches the friendly name? I like to see the
use case in the description so we really tell how it is going to be
used, otherwise Target is fine. Btw, for OPP there is as actually a
UUID as well:

static struct obc_driver opp = {
.service = "OPP",
.uuid = OPP_UUID,
.probe = opp_probe,
.remove = opp_remove
};

So I wonder if we should just update the documentation, anyway with
ObjectManager we do get the interfaces with InterfacesAdded signal so
you can tell what type of session is that from the interfaces it
supports, the friendly names in the CreateSession are supported just
for convenience but they map to UUIDs anyway.


--
Luiz Augusto von Dentz
