Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Jun 2009 14:26:55 +0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Forrest Zhao <forrest.zhao@intel.com>
Cc: linux-bluetooth@vger.kernel.org, forrest.zhao@gmail.com
Subject: Re: [PATCH] add support for PBAP integration with EDS
Message-ID: <20090611072655.GA20058@jh-x301>
References: <1244621622-6487-1-git-send-email-forrest.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244621622-6487-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

On Wed, Jun 10, 2009, Forrest Zhao wrote:
> ---
>  plugins/ebook.c  |  344 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  test/pbap-client |    1 +
>  2 files changed, 334 insertions(+), 11 deletions(-)

The patch has now been pushed with a few minor changes:

> +#define DEFAULT_COUNT	65535

Space instead of tab since there's no special indentation needed for the
value.

> +			gint32 i;
> +			const char *attrib_name = e_vcard_attribute_get_name(
> +						(EVCardAttribute *)l->data);
> +
> +			for (i = 0; i <= 28; i++) {

No need to have a specialized gint32 variable type here. Just use int.

> +			gint32 i;
> +			const char *attrib_name = e_vcard_attribute_get_name(
> +						(EVCardAttribute *)l->data);
> +			for (i = 0; i <= 28; i++) {

Same here.

About the vcard generation. Would it make sense to make some common helper
module for it so other contact backends woldn't need to duplicate all of
it?

Johan
