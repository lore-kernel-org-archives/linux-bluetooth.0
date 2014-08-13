Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2 1/1] shared/att: Handle disconnects.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1407791934-3778-2-git-send-email-armansito@chromium.org>
Date: Tue, 12 Aug 2014 19:52:24 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <947AB89D-2418-4371-A684-F292E888C9B0@holtmann.org>
References: <1407791934-3778-1-git-send-email-armansito@chromium.org> <1407791934-3778-2-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch adds disconnect handling to bt_att, in which
> io_set_disconnect_handler is used to set up a handler which cancels all
> pending and queued ATT operations, marks the bt_att structure as invalid
> and notifies the user via a specialized callback which can be set using
> bt_att_set_disconnect_cb.
> 
> Once the bt_att structure is invalidated, either due to a timed-out ATT protocol
> request/indication or a disconnect, it now destroys the underlying io structure.
> ---
> src/shared/att.c         | 85 +++++++++++++++++++++++++++++++++++-------------
> src/shared/att.h         |  5 +++
> src/shared/io-mainloop.c |  5 +++
> 3 files changed, 73 insertions(+), 22 deletions(-)
> 
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 0d27dfa..b5ab742 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -47,9 +47,7 @@ struct att_send_op;
> struct bt_att {
> 	int ref_count;
> 	int fd;
> -	bool close_on_unref;

I like to keep the close_on_unref logic. So please do not remove it.

Regards

Marcel

