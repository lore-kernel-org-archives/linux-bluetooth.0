Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Aug 2014 15:45:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/1] shared/att: Handle disconnects.
Message-ID: <20140812124529.GA2842@t440s.lan>
References: <1407791934-3778-1-git-send-email-armansito@chromium.org>
 <1407791934-3778-2-git-send-email-armansito@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407791934-3778-2-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, Aug 11, 2014, Arman Uguray wrote:
> This patch adds disconnect handling to bt_att, in which
> io_set_disconnect_handler is used to set up a handler which cancels all
> pending and queued ATT operations, marks the bt_att structure as invalid
> and notifies the user via a specialized callback which can be set using
> bt_att_set_disconnect_cb.
> 
> Once the bt_att structure is invalidated, either due to a timed-out ATT protocol
> request/indication or a disconnect, it now destroys the underlying io structure.
> ---
>  src/shared/att.c         | 85 +++++++++++++++++++++++++++++++++++-------------
>  src/shared/att.h         |  5 +++
>  src/shared/io-mainloop.c |  5 +++
>  3 files changed, 73 insertions(+), 22 deletions(-)

Sorry to keep pushing for further iterations of this patch, but I think
it'd be good to split this into two separate changes: first one for the
io code and a second one for ATT.

> --- a/src/shared/io-mainloop.c
> +++ b/src/shared/io-mainloop.c
> @@ -92,12 +92,15 @@ static void io_callback(int fd, uint32_t events, void *user_data)
>  {
>  	struct io *io = user_data;
>  
> +	io_ref(io);
> +
>  	if ((events & (EPOLLRDHUP | EPOLLHUP | EPOLLERR))) {
>  		io->read_callback = NULL;
>  		io->write_callback = NULL;
>  
>  		if (!io->disconnect_callback) {
>  			mainloop_remove_fd(io->fd);
> +			io_unref(io);
>  			return;
>  		}
>  
> @@ -144,6 +147,8 @@ static void io_callback(int fd, uint32_t events, void *user_data)
>  			mainloop_modify_fd(io->fd, io->events);
>  		}
>  	}
> +
> +	io_unref(io);
>  }

Looking at how shared/io-glib.c does this (which I assume you've
verified doesn't need fixing) another (and possibly even better)
approach is to do the ref when adding the fd to the mainloop and the
unref in the destroy callback. I'll leave it up to you to choose which
one you want to go with.

Johan
