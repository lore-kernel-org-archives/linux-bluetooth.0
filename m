Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349531535-706-2-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
References: <1349531535-706-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
	<1349531535-706-2-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
Date: Sat, 6 Oct 2012 19:24:09 +0530
Message-ID: <CAEd0BX_gDKY=Jy_7PGHMOeGzAFPj1XqTH-+2PFu-PycSL-=Wag@mail.gmail.com>
Subject: Re: [PATCH 1/4] client: Update the file offset to the beginning after
 writing to the file
From: "Venkateswaran, Srinivasa Ragavan"
	<srinivasa.ragavan.venkateswaran@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Oct 6, 2012 at 7:22 PM, Srinivasa Ragavan
<srinivasa.ragavan.venkateswaran@intel.com> wrote:
> When the transfer file is opened in O_RDWR mode, just after the contents are
> written to the file, the file offset has to be set to the beginning of the
> file. If not subsequent read fails. This patch fixes this.

Argh, got flushed from my outbox, when I was sending a different
patch. This is already applied. Please ignore this patch.

-Srini.
> ---
>  client/transfer.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/client/transfer.c b/client/transfer.c
> index fbcafc8..cac3884 100644
> --- a/client/transfer.c
> +++ b/client/transfer.c
> @@ -426,6 +426,7 @@ struct obc_transfer *obc_transfer_put(const char *type, const char *name,
>                                         "Writing all contents to file failed");
>                         goto fail;
>                 }
> +               lseek(transfer->fd, 0, SEEK_SET);
>         } else {
>                 if (!transfer_open(transfer, O_RDONLY, 0, err))
>                         goto fail;
> --
> 1.7.10.4
>
