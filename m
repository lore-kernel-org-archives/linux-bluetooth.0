Return-Path: <SRS0=Z/iR=N3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F6BC43441
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 20:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7967F2086C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 20:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7967F2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbeKQGPZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:15:25 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:46214 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725753AbeKQGPZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Nov 2018 01:15:25 -0500
Received: from marcel-macbook.fritz.box (p4FEFC1D6.dip0.t-ipconnect.de [79.239.193.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 883D2CF167;
        Fri, 16 Nov 2018 21:09:08 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH BlueZ] core: Ignore SIGPIPE
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181116191452.17377-1-gbenhaim@augury.com>
Date:   Fri, 16 Nov 2018 21:01:37 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5F365876-5DA6-4916-B810-E2DF1ABD3772@holtmann.org>
References: <20181116191452.17377-1-gbenhaim@augury.com>
To:     Gal Ben-Haim <gbenhaim@augury.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Gal,

> bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
> was acquired by AcquireNotify and there are no readers. it can be
> reproduced by terminating the reader process without closing the reader
> end of the pipe.
> 
> Ignoring the SIGPIPE will cause the write operation to return an
> error which will be logged as "io_send: Broken pipe".
> ---
> src/main.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/src/main.c b/src/main.c
> index 4716f5388..c62886593 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -691,7 +691,7 @@ int main(int argc, char *argv[])
> 	uint16_t sdp_mtu = 0;
> 	uint32_t sdp_flags = 0;
> 	int gdbus_flags = 0;
> -	guint signal, watchdog;
> +	guint signal_source, watchdog;
> 	const char *watchdog_usec;
> 
> 	init_defaults();
> @@ -721,7 +721,11 @@ int main(int argc, char *argv[])
> 
> 	event_loop = g_main_loop_new(NULL, FALSE);
> 
> -	signal = setup_signalfd();
> +	signal_source = setup_signalfd();
> +
> +	/* Ignore SIGPIPE, a broken pipe error will be returned from write 
> +	 * attempts to a pipe with no readers */
> +	signal(SIGPIPE, SIG_IGN);

if we decide not to use MSG_NOSIGNAL, then everything has to go via signalfd and not just by hacking in signal(SIG_IGN).

Regards

Marcel

