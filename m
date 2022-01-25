Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE4CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 21:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbiAYVih convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 16:38:37 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:57333 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiAYVig (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 16:38:36 -0500
Received: from smtpclient.apple (p5b3d24e1.dip0.t-ipconnect.de [91.61.36.225])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5E8F2CECF6;
        Tue, 25 Jan 2022 22:38:35 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [RFC 1/2] shared/mgmt: Add request timeout handling
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220125010458.2326473-1-luiz.dentz@gmail.com>
Date:   Tue, 25 Jan 2022 22:38:34 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2C1196AC-0A23-4EF6-9A54-B98612FFBEE1@holtmann.org>
References: <20220125010458.2326473-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds request timeout handling, by default the timeout is set to 2
> seconds but in case the user want a different timeout it can use
> mgmt_send_timeout to set a different value.
> ---
> src/shared/mgmt.c | 70 +++++++++++++++++++++++++++++++++++++++++------
> src/shared/mgmt.h |  5 ++++
> 2 files changed, 67 insertions(+), 8 deletions(-)
> 
> diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
> index 41457b430..291a2c636 100644
> --- a/src/shared/mgmt.c
> +++ b/src/shared/mgmt.c
> @@ -25,6 +25,9 @@
> #include "src/shared/queue.h"
> #include "src/shared/util.h"
> #include "src/shared/mgmt.h"
> +#include "src/shared/timeout.h"
> +
> +#define MGMT_TIMEOUT 2
> 
> struct mgmt {
> 	int ref_count;
> @@ -49,6 +52,7 @@ struct mgmt {
> };
> 
> struct mgmt_request {
> +	struct mgmt *mgmt;
> 	unsigned int id;
> 	uint16_t opcode;
> 	uint16_t index;
> @@ -57,6 +61,8 @@ struct mgmt_request {
> 	mgmt_request_func_t callback;
> 	mgmt_destroy_func_t destroy;
> 	void *user_data;
> +	int timeout;
> +	unsigned int timeout_id;
> };
> 
> struct mgmt_notify {
> @@ -81,6 +87,9 @@ static void destroy_request(void *data)
> 	if (request->destroy)
> 		request->destroy(request->user_data);
> 
> +	if (request->timeout_id)
> +		timeout_remove(request->timeout_id);
> +
> 	free(request->buf);
> 	free(request);
> }
> @@ -150,6 +159,26 @@ static void write_watch_destroy(void *user_data)
> 	mgmt->writer_active = false;
> }
> 
> +static bool request_timeout(void *data)
> +{
> +	struct mgmt_request *request = data;
> +
> +	if (!request)
> +		return false;
> +
> +	request->timeout_id = 0;
> +
> +	queue_remove_if(request->mgmt->pending_list, NULL, request);
> +
> +	if (request->callback)
> +		request->callback(MGMT_STATUS_TIMEOUT, 0, NULL,
> +						request->user_data);
> +
> +	destroy_request(request);
> +
> +	return false;
> +}
> +
> static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
> {
> 	struct iovec iov;
> @@ -169,6 +198,12 @@ static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
> 		return false;
> 	}
> 
> +	if (request->timeout)
> +		request->timeout_id = timeout_add_seconds(request->timeout,
> +							request_timeout,
> +							request,
> +							NULL);
> +
> 	util_debug(mgmt->debug_callback, mgmt->debug_data,
> 				"[0x%04x] command 0x%04x",
> 				request->index, request->opcode);
> @@ -566,7 +601,8 @@ bool mgmt_set_close_on_unref(struct mgmt *mgmt, bool do_close)
> static struct mgmt_request *create_request(struct mgmt *mgmt, uint16_t opcode,
> 				uint16_t index, uint16_t length,
> 				const void *param, mgmt_request_func_t callback,
> -				void *user_data, mgmt_destroy_func_t destroy)
> +				void *user_data, mgmt_destroy_func_t destroy,
> +				int timeout)
> {
> 	struct mgmt_request *request;
> 	struct mgmt_hdr *hdr;
> @@ -598,12 +634,18 @@ static struct mgmt_request *create_request(struct mgmt *mgmt, uint16_t opcode,
> 	hdr->index = htobs(index);
> 	hdr->len = htobs(length);
> 
> +	/* Use a weak reference so requests don't prevent mgmt_unref to
> +	 * cancel requests and free in case of the last reference is dropped by
> +	 * the user.
> +	 */
> +	request->mgmt = mgmt;
> 	request->opcode = opcode;
> 	request->index = index;
> 
> 	request->callback = callback;
> 	request->destroy = destroy;
> 	request->user_data = user_data;
> +	request->timeout = timeout;
> 
> 	return request;
> }
> @@ -735,10 +777,11 @@ unsigned int mgmt_send_tlv(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
> 	return ret;
> }
> 
> -unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
> -				uint16_t length, const void *param,
> -				mgmt_request_func_t callback,
> -				void *user_data, mgmt_destroy_func_t destroy)
> +unsigned int mgmt_send_timeout(struct mgmt *mgmt, uint16_t opcode,
> +				uint16_t index, uint16_t length,
> +				const void *param, mgmt_request_func_t callback,
> +				void *user_data, mgmt_destroy_func_t destroy,
> +				int timeout)
> {
> 	struct mgmt_request *request;
> 
> @@ -746,7 +789,7 @@ unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
> 		return 0;
> 
> 	request = create_request(mgmt, opcode, index, length, param,
> -					callback, user_data, destroy);
> +					callback, user_data, destroy, timeout);
> 	if (!request)
> 		return 0;
> 
> @@ -766,6 +809,15 @@ unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
> 	return request->id;
> }
> 
> +unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
> +				uint16_t length, const void *param,
> +				mgmt_request_func_t callback,
> +				void *user_data, mgmt_destroy_func_t destroy)
> +{
> +	return mgmt_send_timeout(mgmt, opcode, index, length, param, callback,
> +					user_data, destroy, MGMT_TIMEOUT);
> +}
> +

I am not happy with this. No every command has to setup a timeout handler and so on. This is not really what should be done since the mgmt communication with the kernel is actually pretty low latency.

If you want to add a special send_timeout, then do that, but leave the send alone.

Regards

Marcel

