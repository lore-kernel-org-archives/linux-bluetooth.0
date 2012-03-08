Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Mar 2012 17:36:51 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 3/5] MAP/dummy: Actual code for folder listing
 retrieval
Message-ID: <20120308233651.GA15265@x220.amr.corp.intel.com>
References: <1331055748-14212-1-git-send-email-lkslawek@gmail.com>
 <1331055748-14212-3-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331055748-14212-3-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Tue, Mar 06, 2012, Slawomir Bochenski wrote:
> ---
>  plugins/messages-dummy.c |   61 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 60 insertions(+), 1 deletions(-)

I've applied the first two in this set, but this one had some minor
stylistic issues:

>  static ssize_t get_subdirs(struct folder_listing_data *fld, GSList **list)
>  {
> -	return 0;
> +	DIR *dp;
> +	char *path, *name;
> +	size_t n = 0;

Please leave this initialization later in the function.

> +	path = g_build_filename(fld->session->cwd_absolute, fld->name, NULL);
> +	dp = opendir(path);
> +
> +	if (dp == NULL) {
> +		int err = errno;

For consistency, variables called "err" should have a negative value to
indicate error or 0 to indicate no error. So this should be:

	err = -errno;

> +	while ((name = get_next_subdir(dp, path)) != NULL) {
> +		++n;

When it doesn't really matter whether you use post- or pre-increment
just use post-increment since I think that's the most widely used one in
the code base.

> +		if (fld->max != 0)

I'd prefer to have the test as > 0

Johan
