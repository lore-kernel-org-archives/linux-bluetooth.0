Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Jun 2011 11:06:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 4/4] Add copy and move support for filesystem plugin
Message-ID: <20110621080630.GA6620@dell.ger.corp.intel.com>
References: <1308292007-2111-1-git-send-email-luiz.dentz@gmail.com>
 <1308292007-2111-4-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308292007-2111-4-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Jun 17, 2011, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Move is implemented using rename and copy uses sendfile, both part of
> posix.
> ---
>  plugins/filesystem.c |   93 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 93 insertions(+), 0 deletions(-)

The first three patches have been pushed upstream, but could you please
fix a few things with this one:

> +static int filesystem_copy(const char *name, const char *destname)
> +{
> +	void *in, *out;
> +	ssize_t ret;
> +	size_t size;
> +	struct stat fstat;
> +	int err;
> +
> +	in = filesystem_open(name, O_RDONLY, 0, NULL, &size, &err);
> +	if (in == NULL) {
> +		error("open(%s): %s (%d)", name, strerror(-err), -err);
> +		return -err;
> +	}

Could you create local int type variables here (in_fd and out_fd) so
that it's clear what filesystem_open has returned and you don't need to
do the GPOINTER_TO_INT cast in every place.

> +	ret = stat(name, &fstat);

Since you already have the fd, please use fstat instead.

Johan
