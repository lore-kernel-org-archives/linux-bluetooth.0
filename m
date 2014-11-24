Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Nov 2014 15:10:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] shared/att: Directly close fd on ATT
 violations.
Message-ID: <20141124131038.GA21565@t440s.ger.corp.intel.com>
References: <1416613500-13315-1-git-send-email-armansito@chromium.org>
 <1416613500-13315-2-git-send-email-armansito@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416613500-13315-2-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Fri, Nov 21, 2014, Arman Uguray wrote:
> +	/*
> +	 * Directly terminate the connection as required by the ATT protocol.
> +	 * This should trigger an io disconnect event which will clean up the
> +	 * io and notify the upper layer.
> +	 */
> +	close(att->fd);
> +
>  	return false;
>  }

Shouldn't you also set att->fd to -1 since its old value is now invalid?
(similar to setting a pointer to NULL after freeing it)

However, wouldn't the more correct thing to do be to use shutdown()
instead of close()? That would guarantee that even in the case of
duplicated fd's the connection would get terminated - close() can be
considered to behave similar to an unref(), i.e. it invalidates the fd
value but only does something to the connection (the same as shutdown)
if there are no other references left.

Johan
