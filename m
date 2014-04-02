Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Apr 2014 18:41:14 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: "Poulain, Loic" <loic.poulain@intel.com>
Cc: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv5] tools: add bcm43xx specific init in hciattach
Message-ID: <20140402154114.GA6844@t440s.P-661HNU-F1>
References: <50C3158CF44D924791C15F1437EF2EC65D760E@HASMSX104.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50C3158CF44D924791C15F1437EF2EC65D760E@HASMSX104.ger.corp.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

On Wed, Apr 02, 2014, Poulain, Loic wrote:
> +static int bcm43xx(int fd, struct uart_t *u, struct termios *ti)
> +{
> +    return bcm43xx_init(fd, u->speed, ti, u->bdaddr);
> +}

What did you do to your indentation settings? You seem to have switched
indentation style for the entire patch since v4. BlueZ uses only tabs
for indentation but now your entire patch uses 4 spaces.

> +    struct timespec tm_mode = {0, 50000};
> +    struct timespec tm_ready = {0, 2000000};

Still missing spaces after { and before }.

> +        fprintf (stderr, "Cannot open directory '%s': %s\n",
> +                dir_name, strerror (errno));

No space after the function name here. Applies both for fprintf as well
as strerror.

> +    /* Recursively look for a BCM43XX*.hcd */
> +    while (1) {
> +        entry = readdir(dir);

Try to declare variables in the smallest scope possible. Seems like
entry could be declared in the beginning of this while-loop instead of
the beginning of the function.

Johan
