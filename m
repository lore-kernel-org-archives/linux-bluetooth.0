Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Feb 2011 15:41:27 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: jaikumar@google.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix control channel shutdown in case of errors.
Message-ID: <20110207234127.GA28215@jh-x301>
References: <1296856305-54896-1-git-send-email-jaikumar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296856305-54896-1-git-send-email-jaikumar@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaikumar,

On Fri, Feb 04, 2011, jaikumar@google.com wrote:
> When there are connection errors, like host is down, when
> establishing the control channel connection, the control io
> channel was not being shutdown. This will cause future
> connections to fail.
> ---
>  input/device.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Thanks, there were several other issues present (which we already
discussed) so a little bit different (and more comprehensive) patch has
now been pushed upstream.

Johan
