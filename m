Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Aug 2014 10:24:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1 1/1] shared/att: Handle disconnects.
Message-ID: <20140811072409.GB21813@t440s>
References: <1407548769-5903-1-git-send-email-armansito@chromium.org>
 <1407548769-5903-2-git-send-email-armansito@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407548769-5903-2-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Fri, Aug 08, 2014, Arman Uguray wrote:
> +static bool disconnect_cb(struct io *io, void *user_data)
> +{
> +	struct bt_att *att = user_data;
> +
> +	bt_att_cancel_all(att);
> +
> +	att->invalid = true;
> +
> +	util_debug(att->debug_callback, att->debug_data,
> +						"Physical link disconnected");
> +
> +	if (att->disconn_callback)
> +		att->disconn_callback(att->disconn_data);
> +
> +	/* It's unsafe to destroy the struct io during the disconnect callback.
> +	 * post a task on the main loop to perform this later.
> +	 */
> +	att->io_destroy_id = timeout_add(1, io_destroy_cb, att, NULL);

Is this the only reason you're keeping the "bool invalid" variable? I'd
take a different approach and fix the generic IO handling to be able to
destroy the io from within of the disconnect callback. The simplest way
to do this would be to increment the reference count in the generic io
code before calling the disconnect callback and the decrement once done
with the io pointer.

Johan
