Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH BlueZ] shared: Fix crash if adapter is removed before mgmt event is received
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1389408885-25395-1-git-send-email-anderson.lizardo@openbossa.org>
Date: Fri, 10 Jan 2014 19:51:33 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <F2A364DE-D788-4F25-AD70-9D4BB4580D2B@holtmann.org>
References: <1389408885-25395-1-git-send-email-anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> If "Index Removed" mgmt event is received after a mgmt command was sent
> by userspace, but before its Command Status/Complete event is received,
> bluetoothd will eventually call mgmt_cancel_index(), which will destroy
> the queue of pending commands. By the time request_complete() is called,
> the request callback is no more valid, because the destroy callback was
> already called.
> 
> Therefore, the fix is to simply ignore the event.
> 
> Valgrind output:
> 
> ==3676== Invalid read of size 4
> ==3676==    at 0x80BCD07: request_complete (mgmt.c:239)
> ==3676==    by 0x80BCF72: can_read_data (mgmt.c:350)
> ==3676==    by 0x80BBE22: read_callback (io-glib.c:164)
> ==3676==    by 0x40C019D: g_io_unix_dispatch (giounix.c:166)
> ==3676==    by 0x407FD45: g_main_context_dispatch (gmain.c:2539)
> ==3676==    by 0x40800E4: g_main_context_iterate.isra.21 (gmain.c:3146)
> ==3676==    by 0x408052A: g_main_loop_run (gmain.c:3340)
> ==3676==    by 0x41BE4D2: (below main) (libc-start.c:226)
> ==3676==  Address 0x10 is not stack'd, malloc'd or (recently) free'd
> ---
> src/shared/mgmt.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
> index a391ab5..a4ee224 100644
> --- a/src/shared/mgmt.c
> +++ b/src/shared/mgmt.c
> @@ -235,6 +235,8 @@ static void request_complete(struct mgmt *mgmt, uint8_t status,
> 
> 	request = queue_remove_if(mgmt->pending_list,
> 					match_request_opcode_index, &match);
> +	if (!request)
> +		goto done;
> 
> 	if (request->callback)
> 		request->callback(status, length, param, request->user_data);
> @@ -244,6 +246,7 @@ static void request_complete(struct mgmt *mgmt, uint8_t status,

you might want to put the done: label here.

> 	if (mgmt->destroyed)
> 		return;
> 
> +done:
> 	wakeup_writer(mgmt);
> }

Actually, I fixed this without using a label.

Regards

Marcel

