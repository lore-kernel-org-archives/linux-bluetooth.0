Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1337591234-24919-6-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1337591234-24919-6-git-send-email-mikel.astiz.oss@gmail.com>
Date: Mon, 21 May 2012 12:33:34 +0300
Message-ID: <CABBYNZKxOd-1VEvQvj-KmSzTxyAXdJtz14kGDn8Qh8LNbrhyiw@mail.gmail.com>
Subject: Re: [PATCH obexd v0 05/12] client-doc: Replace SendFiles with SendFile
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, May 21, 2012 at 12:07 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> Now that OPP sessions exist, sending multiple files can be achieved with
> consecutive calls to SendFile. Note that within a session the pending
> operations will be queued and sequentially executed.
> ---
>  doc/client-api.txt |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/doc/client-api.txt b/doc/client-api.txt
> index 32caa17..de726a8 100644
> --- a/doc/client-api.txt
> +++ b/doc/client-api.txt
> @@ -65,9 +65,9 @@ Service               org.openobex.client
>  Interface      org.openobex.ObjectPush
>  Object path    [variable prefix]/{session0,session1,...}
>
> -Methods                void SendFiles(array{string} files)
> +Methods                void SendFile(string sourcefile)
>
> -                       Send one or multiple local files to the remote device.
> +                       Send one local file to the remote device.
>
>                void PullBusinessCard(string targetfile)
>
> --
> 1.7.7.6

Perhaps it is a good idea to return the transfer object here, so the
application can track the progress and cancel it which is the whole
point of not having multiple files so we can do this properly.


-- 
Luiz Augusto von Dentz
