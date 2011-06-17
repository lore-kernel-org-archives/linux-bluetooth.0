Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Jun 2011 13:32:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix return code of hid2hci
Message-ID: <20110617103255.GA28423@dell.ger.corp.intel.com>
References: <1307628035-3619-1-git-send-email-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307628035-3619-1-git-send-email-iwamatsu@nigauri.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 09, 2011, Nobuhiro Iwamatsu wrote:
> hid2hci already return 1.
> This set 0 to default retuen code and add error code.
> ---
>  tools/hid2hci.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/hid2hci.c b/tools/hid2hci.c
> index 45a3a3d..da278cb 100644
> --- a/tools/hid2hci.c
> +++ b/tools/hid2hci.c
> @@ -240,7 +240,7 @@ int main(int argc, char *argv[])
>  	enum mode mode = HCI;
>  	const char *devpath = NULL;
>  	int err = -1;
> -	int rc = 1;
> +	int rc = 0;
>  
>  	for (;;) {
>  		int option;
> @@ -288,13 +288,16 @@ int main(int argc, char *argv[])
>  	}
>  
>  	udev = udev_new();
> -	if (udev == NULL)
> +	if (udev == NULL) {
> +		rc = errno;
>  		goto exit;
> +	}
>  
>  	snprintf(syspath, sizeof(syspath), "%s/%s", udev_get_sys_path(udev), devpath);
>  	udev_dev = udev_device_new_from_syspath(udev, syspath);
>  	if (udev_dev == NULL) {
>  		fprintf(stderr, "error: could not find '%s'\n", devpath);
> +		rc = errno;
>  		goto exit;
>  	}

I don't see anything in the libudev reference documentation about it
using errno for errors (which really only should belong to libc).

I also don't see why you'd need a second "error" variable. You could
just reuse err here and at the end of main() do exit(1) if err is less
than zero.

Johan
