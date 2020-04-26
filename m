Return-Path: <SRS0=2aAe=6K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87178C55199
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Apr 2020 15:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602032070A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Apr 2020 15:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587914133;
	bh=Ut9eCrJ1zUUTzIQMadS0VxSRBI1mGDqKcK50d1sAm9o=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=RONWzRpljeRxfHIB3VOfEDxWNQEtOACU7HFmScO59AC1nXIlPmuse34bckO68mE04
	 xctDGcDa2KGssZgnWE2wMeaf5Jl29gQ2UtByvcxOrRc+ltAtk3wNi0yXr24aAh+yy5
	 dENj0f+zctMeQhkiwVKJx6nwMXmq6qBCZNEOYf+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDZPPd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Apr 2020 11:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgDZPPc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Apr 2020 11:15:32 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83DDF2070A;
        Sun, 26 Apr 2020 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587914131;
        bh=Ut9eCrJ1zUUTzIQMadS0VxSRBI1mGDqKcK50d1sAm9o=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=eYi7ApRO18foIy3uFmmtIY6QEDmZkPjljALgTWhk0zPAtMRiMkrB0pvRzryDESFZL
         F0bq1xs15KlIXTIRp4Vc/ntoVVFZj2tndbp0m5BFU91zC8HsV+RX5zAyDJ6pDhIbqp
         Zv7FCOmZm7p48wElde3x+jCN7CB/l5QaYAndMv3E=
Received: by pali.im (Postfix)
        id 8EEC5B71; Sun, 26 Apr 2020 17:15:29 +0200 (CEST)
Date:   Sun, 26 Apr 2020 17:15:29 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: bluetoothd crashes when tryting to change A2DP codec via DBus
Message-ID: <20200426151529.dpzojinssjqagsaq@pali>
References: <20200426150435.s562o34mertpj6ct@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200426150435.s562o34mertpj6ct@pali>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sunday 26 April 2020 17:04:35 Pali Rohár wrote:
> Hello!
> 
> Bluez bluetoothd daemon compiled from git master branch crashes when I
> try to call DBus method for switching A2DP codec. Below is stacktrace
> from gdb. It looks like NULL pointer dereference. It is reproducible.
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x000055e1b3659c1a in avdtp_find_remote_sep (session=0x55e1b408bf80, lsep=0x0) at profiles/audio/avdtp.c:1221
> 1221            if (lsep->info.inuse)
> (gdb) bt
> #0  0x000055e1b3659c1a in avdtp_find_remote_sep (session=0x55e1b408bf80, lsep=0x0) at profiles/audio/avdtp.c:1221
> #1  0x000055e1b36568fc in find_remote_sep (sep=<optimized out>, chan=<optimized out>, chan=<optimized out>) at profiles/audio/a2dp.c:1169
> #2  0x000055e1b3656955 in a2dp_reconfigure (data=0x55e1b40a1e10) at profiles/audio/a2dp.c:1188
> #3  0x00007f4e07e90863 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
> #4  0x00007f4e07e8fdd8 in g_main_context_dispatch () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
> #5  0x00007f4e07e901c8 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
> #6  0x00007f4e07e904c2 in g_main_loop_run () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
> #7  0x000055e1b36ef725 in mainloop_run () at src/shared/mainloop-glib.c:79
> #8  0x000055e1b36efb02 in mainloop_run_with_signal (func=<optimized out>, user_data=0x0) at src/shared/mainloop-notify.c:201
> #9  0x000055e1b364b15e in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:770
> (gdb) print lsep
> $1 = (struct avdtp_local_sep *) 0x0

It always happens if I kill target application (pulseaudio) during
bluetooth daemon is connecting to remote bluetooth headset. I guess that
there is a race condition between unregistering application agent
(together with unregistering all its local seps) and trying to use /
choose local sep for a new remote connection.

Here is simple patch which prevent bluetooth daemon crash:

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index a5590b24c..2f0fcd974 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1184,8 +1184,14 @@ static gboolean a2dp_reconfigure(gpointer data)
 		rsep_codec = (struct avdtp_media_codec_capability *) cap->data;
 	}
 
-	if (!setup->rsep || sep->codec != rsep_codec->media_codec_type)
+	if (!setup->rsep || sep->codec != rsep_codec->media_codec_type) {
+		if (!sep->lsep) {
+			error("no lsep");
+			posix_err = -EINVAL;
+			goto failed;
+		}
 		setup->rsep = find_remote_sep(setup->chan, sep);
+	}
 
 	posix_err = avdtp_set_configuration(setup->session, setup->rsep->sep,
 						sep->lsep,

After applying this patch I get following error message without any
crash in bluetooth log:

bluetoothd[...]: Error on avdtp_open Invalid argument (22)

Which is probably OK, as target application is not running anymore and
connect request could not be finished.
