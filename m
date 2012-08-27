Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1345533815-5611-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1345533815-5611-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Mon, 27 Aug 2012 10:00:00 +0300
Message-ID: <CABBYNZLSq1FKmOvKHG9b6SuV0QQux_Zik3ov2eDez89WxhYRmw@mail.gmail.com>
Subject: Re: [PATCH obexd v0] client-doc: Guarantee prefix in transfer paths
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Aug 21, 2012 at 10:23 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> The client D-Bus documentation should mention that all transfer paths
> contain a prefix consisting of the path of the session they belong to.
>
> This can be conveniently used by clients to install D-Bus signal matches
> that concentrate on the relevant signals.
> ---
>  doc/client-api.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/doc/client-api.txt b/doc/client-api.txt
> index 839a78c..7ca65cc 100644
> --- a/doc/client-api.txt
> +++ b/doc/client-api.txt
> @@ -466,7 +466,7 @@ Transfer hierarchy
>
>  Service                org.bluez.obex.client
>  Interface      org.bluez.obex.Transfer
> -Object path    [variable prefix]/{transfer0,transfer1,...}
> +Object path    [variable prefix]/{session0,session1,...}/{transfer0,...}
>
>  Methods                dict GetProperties()
>
> --
> 1.7.7.6

I went ahead and applied this patch.

-- 
Luiz Augusto von Dentz
