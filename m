Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Aug 2014 12:22:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/l2test: And listen and not receive mode option
Message-ID: <20140813092256.GB19215@t440s.lan>
References: <1407921074-19966-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407921074-19966-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Aug 13, 2014, Lukasz Rymanowski wrote:
> +static void not_receive_mode(int sk) {
> +
> +	syslog(LOG_INFO, "Connected and not receiving !");
> +	while (1) {};
> +}

A busy-loop taking up all CPU time doesn't seem very nice. Shouldn't you
instead be at least polling for HUP/ERR events? That's what the
do_listen function seems to expect to have happened when the handler
returns.

Johan
