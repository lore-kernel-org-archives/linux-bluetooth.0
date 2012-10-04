Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349360560-21631-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
References: <1349360560-21631-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
Date: Thu, 4 Oct 2012 23:55:03 +0300
Message-ID: <CABBYNZKMpftvs_mBiUqg++JREkSTbvKxOvRT_shrAAcDkS73Zw@mail.gmail.com>
Subject: Re: [PATCH 1/4] client: Update the file offset to the beginning after
 writing to the file
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Srinivasa,

On Thu, Oct 4, 2012 at 5:22 PM, Srinivasa Ragavan
<srinivasa.ragavan.venkateswaran@intel.com> wrote:
> When the transfer file is opened in O_RDWR mode, just after the contents are
> written to the file, the file offset has to be set to the beginning of the
> file. If not subsequent read fails. This patch fixes this.
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

All 4 patches are now upstream, thanks.


-- 
Luiz Augusto von Dentz
