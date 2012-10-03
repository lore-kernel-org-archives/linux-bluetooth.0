Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Oct 2012 22:59:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] storage: Move adapter info to adapter.conf
Message-ID: <20121003195912.GA27664@x220.P-661HNU-F1>
References: <1349274401-32012-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1349274401-32012-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Wed, Oct 03, 2012, Frédéric Danis wrote:
> Add functions to read and write to .conf files.
> Convert adapter "config" file to "adapter.conf".
> ---
>  .gitignore          |    1 +
>  Makefile.am         |    3 +-
>  Makefile.tools      |    6 +-
>  src/keyfile.c       |  282 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/keyfile.h       |   51 ++++++++++
>  src/storage.c       |  100 +++++++-----------
>  test/test-keyfile.c |  252 +++++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 627 insertions(+), 68 deletions(-)
>  create mode 100644 src/keyfile.c
>  create mode 100644 src/keyfile.h
>  create mode 100644 test/test-keyfile.c

The keyfile.[ch] files should be split into their own patch along with
test-keyfile.c.

> +int keyfile_put_string(const char *pathname, const char *group,
> +				const char *key, const char *value)
> +{
> +	GKeyFile *key_file;
> +	char *data;
> +	FILE *file;
> +
> +	key_file = g_key_file_new();
> +
> +	g_key_file_load_from_file(key_file, pathname, 0, NULL);
> +
> +	g_key_file_set_string(key_file, group, key, value);
> +
> +	data = g_key_file_to_data(key_file, NULL, NULL);
> +	file = fopen(pathname, "w");
> +	fputs(data, file);
> +	fclose(file);

It seems like there's some error checking missing here as both
g_key_file_load_from_file and fopen could fail.

> +}
> +
> +
> +int keyfile_get_boolean(const char *pathname, const char *group,

Two consecutive empty lines above. Please remove one.

> +				const char *key, gboolean *value)
> +{
> +	GKeyFile *key_file;
> +	GError *error = NULL;

Please don't reuse the symbol name "error" since we already have that
for error logging. Use gerr instead

> +	int err = 0;

This initialization upon declaration is unnecessary. Set to 0 at the end
of the success path instead.

> +	if (error) {
> +		g_error_free(error);
> +		err = -EINVAL;
> +	}

< i.e. here >

> +
> +failed:
> +	g_key_file_free(key_file);
> +	errno = -err;

Don't mix errno into this. It should be considered "owned" by libc and
we should only read it and not write to it. Return the error in the
function return value instead.

> +	return keyfile_put_integer(filename, "General", "DiscovTO", timeout);

I really dislike this "TO" short-hand for timeout. I think we can use
longer and more readable names in the INI-format files. In this case
DiscoverableTimeout should be perfectly fine. 

> +	return keyfile_put_integer(filename, "General", "PairTO", timeout);

Same here. PairableTimeout should be fine.

Johan
