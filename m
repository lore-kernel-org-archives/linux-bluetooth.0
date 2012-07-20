Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1342782148-10684-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1342782148-10684-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Fri, 20 Jul 2012 17:19:26 +0300
Message-ID: <CABBYNZ+GeJXvZvTnOOT6FrxxVoR-AnLL3C4Bs5yOVOm+oWJJ4Q@mail.gmail.com>
Subject: Re: [PATCH obexd v0 1/4] client-doc: Fix typo
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Jul 20, 2012 at 2:02 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> ---
>  doc/client-api.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/doc/client-api.txt b/doc/client-api.txt
> index 1938a38..11b79be 100644
> --- a/doc/client-api.txt
> +++ b/doc/client-api.txt
> @@ -288,7 +288,7 @@ Methods             void Select(string location, string phonebook)
>                 array{string} ListFilterFields()
>
>                         Return All Available fields that can be used in
> -                       SefFilter method.
> +                       SetFilter method.
>
>                 array{string} GetFilter()
>
> --
> 1.7.7.6

Patches 1-3 pushed, thanks.


-- 
Luiz Augusto von Dentz
