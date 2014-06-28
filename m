Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] sdp: Fix requests with invalid size
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403929003-31639-1-git-send-email-arakhov@chromium.org>
Date: Sat, 28 Jun 2014 08:21:50 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6BD6758B-7800-4952-BD69-FF4586468383@holtmann.org>
References: <1403929003-31639-1-git-send-email-arakhov@chromium.org>
To: Artem Rakhov <arakhov@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Artem,

> This patch fixes processing of SDP requests which have wrong PDU size in header.
> 
> Every SDP request consists of two parts: header and data.
> Header always contains 3 values: request code (identifies it's type),
> transaction ID (in order to match response with request), and data's size.
> 
> According to Bluetooth specification, when the data's size is wrong,
> SDP server should return SDP_ErrorResponse with "Invalid PDU Size" parameter.
> But now the server doesn't respond at all, and corresponding socket on
> client's side crashes.
> 
> The patch actually reverts commit 388761cdc8f8a1293bb0b1a5bd576b5fb41616ca,
> because the size of request should be checked inside handle_request() function
> in order to be able to respond with SDP_ErrorResponse, instead of stopping
> the connection.
> ---
> src/sdpd-server.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/sdpd-server.c b/src/sdpd-server.c
> index b411abe..230e467 100644
> --- a/src/sdpd-server.c
> +++ b/src/sdpd-server.c
> @@ -176,7 +176,7 @@ static gboolean io_session_event(GIOChannel *chan, GIOCondition cond, gpointer d
> 		return TRUE;

can you please add a short comment here on why this check is correct so that we do not end in cycle of changing this and then reverting it agin.

> 	len = recv(sk, buf, size, 0);
> -	if (len != size) {
> +	if (len <= 0) {
> 		sdp_svcdb_collect_all(sk);
> 		free(buf);
> 		return FALSE;

Regards

Marcel

