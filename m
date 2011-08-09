Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Aug 2011 13:00:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix missing Name header check in FTP action code
Message-ID: <20110809100037.GA19242@dell>
References: <1312879479-4577-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312879479-4577-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Tue, Aug 09, 2011, Slawomir Bochenski wrote:
> ---
>  plugins/ftp.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

Applied, but with a minor coding-style modification:

>  	name = obex_get_name(os);
> +
> +	if (name == NULL || !is_filename(name))
> +		return -EBADR;

Usually when we have an assignment to a variable and then an immediately
following check for the variable there's no empty line between the
assignment and the if-statement, so I removed this empty line.

Johan
