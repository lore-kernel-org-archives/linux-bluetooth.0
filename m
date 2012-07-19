Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1342716765-28912-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1342716765-28912-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Thu, 19 Jul 2012 14:31:32 -0300
Message-ID: <CAKT1EBcrYAJsdv=zsDjDMApXP-7YcJYu9dKqz3L_BPs+jKkveg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] doc: Remove deprecated ListAdapters() method
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

On Thu, Jul 19, 2012 at 1:52 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> ---
>  doc/manager-api.txt |   10 ----------
>  1 files changed, 0 insertions(+), 10 deletions(-)
>
> diff --git a/doc/manager-api.txt b/doc/manager-api.txt
> index d2c1caf..4e6653b 100644
> --- a/doc/manager-api.txt
> +++ b/doc/manager-api.txt
> @@ -37,16 +37,6 @@ Methods              dict GetProperties()
>                         Possible errors: org.bluez.Error.InvalidArguments
>                                          org.bluez.Error.NoSuchAdapter
>
> -               array{object} ListAdapters() {deprecated}
> -
> -                       Returns list of adapter object paths under /org/bluez.
> -                       This method is deprecated, instead use the Adapters
> -                       Property to get the list of adapter object paths.
> -
> -                       Possible errors: org.bluez.Error.InvalidArguments
> -                                        org.bluez.Error.Failed
> -                                        org.bluez.Error.OutOfMemory
> -
>  Signals                PropertyChanged(string name, variant value)
>
>                         This signal indicates a changed value of the given
> --
> 1.7.8.6
>

Ignore this patch.
Gustavo already sent a patch removing this method.

BR,

Claudio
