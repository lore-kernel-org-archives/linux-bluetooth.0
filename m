Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 May 2012 11:25:37 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] client: Fix not checking if destination exist
 while renaming file
Message-ID: <20120529142537.GB13737@samus>
References: <1338293498-2356-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338293498-2356-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 15:11 Tue 29 May, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> rename return an error if the destination directory doesn't exist, so
> in case it doesn't exist it should be created before calling rename.
> ---
>  client/transfer.c |   27 +++++++++++++++++++++++++--
>  1 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/client/transfer.c b/client/transfer.c
> index 3065c9c..772834f 100644
> --- a/client/transfer.c
> +++ b/client/transfer.c
> @@ -715,11 +715,34 @@ int obc_transfer_set_filename(struct obc_transfer *transfer,
>  					const char *filename)
>  {
>  	int err;
> +	struct stat st;
> +	char *dirname;
> +	gboolean dir = FALSE;
> +
> +	dirname = g_path_get_dirname(filename);
> +	if (stat(dirname, &st) < 0) {
> +		if (errno != ENOENT) {
> +			error("stat(): %s (%d)", strerror(errno), errno);
> +			return -errno;
> +		}
> +
> +		if (mkdir(dirname, 0755) < 0) {

For example, if my /tmp is empty, and "dirname" is "/tmp/foo/bar", this
would fail, right? i.e. mkdir() isn't able to create two (or more) levels
at a time.

So for consistency, I would prefer if the error that the directory
doesn't exist is returned, and the user creates the directory himself.
This is mostly for FTP, right?

> +			error("mkdir(): %s (%d)", strerror(errno), errno);
> +			return -errno;
> +		}
> +
> +		dir = TRUE;
> +	}
>  
>  	err = rename(transfer->filename, filename);
>  	if (err < 0) {
> -		error("rename(): %s (%d)", strerror(errno), errno);
> -		return -errno;
> +		err = -errno;
> +
> +		if (dir)
> +			rmdir(dirname);
> +
> +		error("rename(): %s (%d)", strerror(-err), -err);
> +		return -err;
>  	}
>  
>  	g_free(transfer->filename);
> -- 
> 1.7.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
