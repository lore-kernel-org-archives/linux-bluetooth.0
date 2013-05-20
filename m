Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 May 2013 16:51:42 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 1/2] plugins: Use open()/read() instead of
 fopen()/fread() on autopair
Message-ID: <20130520235142.GA14092@x220>
References: <1368721510-14339-1-git-send-email-anderson.lizardo@openbossa.org>
 <1368801089-30703-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368801089-30703-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, May 17, 2013, Anderson Lizardo wrote:
> +	fd = open("/dev/urandom", O_RDONLY);
> +	if (fd < 0) {
> +		ssize_t n;
> +
> +		n = read(fd, &seed, sizeof(seed));
> +		if (n < (ssize_t) sizeof(seed))
> +			seed = time(NULL);
> +
> +		close(fd);
> +	} else
> +		seed = time(NULL);

So, it's not always wise to go blindly copying code examples/suggestions
from Marcel without thinking a bit. You're checking for invalid fd when
you should be checking for a valid one (>= 0).

Johan
