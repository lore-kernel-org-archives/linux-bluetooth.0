Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Dec 2012 17:24:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH BlueZ 1/7] build-sys: Define _GNU_SOURCE in config.h
Message-ID: <20121205152434.GA15812@x220>
References: <1354706575-4718-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354706575-4718-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, Dec 05, 2012, Lucas De Marchi wrote:
> Instead of defining _GNU_SOURCE in each source file (and potentially
> forgetting in some), tell the build system we use extensions and let it
> define _GNU_SOURCE in config.h.
> ---
>  configure.ac                | 1 +
>  monitor/btsnoop.c           | 1 -
>  monitor/sdp.c               | 1 -
>  profiles/input/hog_device.c | 1 -
>  src/adapter.c               | 1 -
>  src/mgmt.c                  | 1 -
>  src/sdp-xml.c               | 1 -
>  src/textfile.c              | 1 -
>  tools/btsnoop.c             | 1 -
>  tools/ciptool.c             | 1 -
>  tools/hciattach.c           | 1 -
>  tools/rfcomm.c              | 1 -
>  12 files changed, 1 insertion(+), 11 deletions(-)

All patches in this set have been applied. Thanks!

Johan
