Return-Path: <cyrus@holtmann.org>
Date: Sun, 10 Aug 2014 17:02:33 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com
Subject: Re: [RFC bluetooth-next 1/8] 6lowpan: add generic nhc layer interface
Message-ID: <20140810150206.GA31007@omega>
References: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
 <1407610943-27701-2-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1407610943-27701-2-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Aug 09, 2014 at 09:02:16PM +0200, Alexander Aring wrote:
...
> +
> +/**
> + * LOWPAN_NHC - helper macro to generate nh id fields and lowpan_nhc struct
> + *
> + * @varname: variable name of the lowpan_nhc struct.
> + * @nhcname: const char * of common header compression name.
> + * @nexthdr: ipv6 nexthdr field for the header compression.
> + * @nhidsetup: callback to setup id and mask values.
> + * @nhidlen: len for the next header id and mask, should be always the same.
> + * @nhuncompress: callback for uncompression call.
> + * @nhcompress: callback for compression call.
> + */
> +#define LOWPAN_NHC(varname, nhcname, nhnexthdr,	\
> +		   nhidsetup, nhidlen,		\
> +		   nhuncompress, nhcompress)	\
> +	static u8 name##_val[nhidlen];		\
> +	static u8 name##_mask[nhidlen];		\

this should be varname instead name. I will fix it for the next version.

> +	static struct lowpan_nhc varname = {	\
> +		.name		= nhcname,	\
> +		.nexthdr	= nhnexthdr,	\
> +		.id		= name##_val,	\
> +		.idmask		= name##_mask,	\
> +		.idlen		= nhidlen,	\
> +		.idsetup	= nhidsetup,	\
> +		.uncompress	= nhuncompress,	\
> +		.compress	= nhcompress,	\
> +	}
> +

- Alex
