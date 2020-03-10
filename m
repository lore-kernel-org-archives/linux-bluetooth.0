Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889AAC18E5B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 08:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8562051A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 08:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=besson.co header.i=@besson.co header.b="p6IzN4hs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rtRz+SS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgCJIud (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 04:50:33 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50649 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726423AbgCJIuc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 04:50:32 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2DCA722114;
        Tue, 10 Mar 2020 04:50:31 -0400 (EDT)
Received: from imap36 ([10.202.2.86])
  by compute1.internal (MEProxy); Tue, 10 Mar 2020 04:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=besson.co; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=3Viptgo61ZDNZi0eZMCnBsbmphdMjnd
        2R34Ys5nmLMY=; b=p6IzN4hskhh9LIMkQNLSs6G5ZdSdI0bigzEMxFdJoejnAzv
        penvgepJFN0ca2Mjftb8rSW8C9UBsGYtZ3fn/F88rgXngRAV/TAdKS/zIv8WP1wX
        Baxsrbor/4WqWcWH40bpQvd0/tk10cNTWjdzCqhjhrmT6OwYhECO9/Z1XHpmQATj
        U4m9tPYcrLc9hHWFi4oY4a1/JsgeF6sL2SLBKXAIGFRh9Y7IWZ5NkjUyGti+8fzI
        7dSFi3SkWq2jZQjzLFuI45Z2sZ0jqGj8hOsSXZFV02Me4FPt+Xy4pE/RV6WyvvED
        0GOZ07DjRxTibvvu2m6w6aaKBTZQ4mBRHD2FIsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3Viptg
        o61ZDNZi0eZMCnBsbmphdMjnd2R34Ys5nmLMY=; b=rtRz+SS4BpA1/tTVQH0xjh
        obgtwOpGfL5XTjzo+vWAa/bnME33bZsU9P8MnZCYEx9J+3HS0h7nwA89gjkTp6rP
        WyR9IVE7ACYbfcA04g7PVxtsJrUwc+85nJUI90frO3zcLSQClM/LWvJOeEO/t/ly
        dAuIpqkS4m4R1U5VbCMVYfkQ7TvEfQfqjk8U4rxDze2nwZ7OSjCdznmk30ry0FKe
        f3Af9Qv3bxuWQncbbEBmM4V/n8zK2MSHbvYMvBPLYWNY7COCB4TFtNRBkaTtzgsA
        wYrnkGoVsdf7eTdtSzBzBNBLGi9z2LHr7pF+/6KavEGk7Ws27ejGgU3Dcr+5/zRQ
        ==
X-ME-Sender: <xms:11RnXvBTSpkEvhPu4Zi3KmMgWaV9z8JAjOr3rs8QM7w6_wo3cPLEeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudduledguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfifhu
    ihhllhgruhhmvgcuuegvshhsohhnfdcuoehguhhilhhlrghumhgvsegsvghsshhonhdrtg
    hoqeenucffohhmrghinheprghmrgiiohhnrgifshdrtghomhdpghdujeehudeitdefgegr
    rdhhvghrvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehguhhilhhlrghumhgvsegsvghsshhonhdrtgho
X-ME-Proxy: <xmx:11RnXsQsVz1UNFmEVKIQVQeeLFpsJwQEop2U3CzCUAl9kvJSS6TZMw>
    <xmx:11RnXiGB138_6Tk47mupKX9502S9PeWCt7LBnKKeUHFRIXSJ0HOEvg>
    <xmx:11RnXv9EFCB4Q2ioeCImN30dG0o_iumNWXS6hyw5pbZxeXTc5SbQug>
    <xmx:11RnXp5tDLRKn1KKMm8pDxOjk-xqOk95H9swGOXvugGnlWuXJHu9tg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D93A71880062; Tue, 10 Mar 2020 04:50:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-991-g5a577d3-fmstable-20200305v3
Mime-Version: 1.0
Message-Id: <7b8a30a1-cff5-47e5-9e53-a9d4a19752be@www.fastmail.com>
In-Reply-To: <CABBYNZ+wA8NHmBuUiWbE5GtxgUD4QaN71KQeJcSse8q+o9DsdA@mail.gmail.com>
References: <3fa34b47-fd14-4672-8e95-93caa0c67397@www.fastmail.com>
 <CABBYNZ+wA8NHmBuUiWbE5GtxgUD4QaN71KQeJcSse8q+o9DsdA@mail.gmail.com>
Date:   Tue, 10 Mar 2020 09:50:09 +0100
From:   "Guillaume Besson" <guillaume@besson.co>
To:     "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Random segfault on mouse connection
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for taking time to look into this. I've tried to reproduce the segfault but I couldn't. It doesn't seem to happens when btmon is running which is quite weird. I still get the "bt_uhid_send: Invalid argument (22)" error. It happens for a few seconds and during this time my bluetooth mouse is unresponsive. Here's a capture file that produce this error:  https://guillaumebesson.s3.eu-west-3.amazonaws.com/bt_uhid_send_bug.btsnoop

I'll still try to reproduce the segfault while monitoring and send you the dump if it happens again.

Thanks,
Guillaume Besson

On Fri, Mar 6, 2020, at 12:33 AM, Luiz Augusto von Dentz wrote:
> Hi Guillaume,
> 
> On Thu, Mar 5, 2020 at 8:45 AM Guillaume Besson <guillaume@besson.co> wrote:
> >
> > Hello,
> > On my Lenovo X1 Extreme Gen2, the bluetoothd process segfault frequently on mouse connection. The bluetooth chipset is integrated in the Intel Corporation Wi-Fi 6 AX200 card. I'm using the latest Linux kernel (5.5.4) and bluez-git (bluez-git-1:5.53.r4.g17516034a).
> > Here's the stacktrace from the coredump:
> >
> > #0 queue_remove (queue=0x55e521458c90, data=data@entry=0x55e521454510) at src/shared/queue.c:258
> > #1 0x000055e51fde63fe in enable_ccc_callback (opcode=<optimized out>, pdu=<optimized out>, length=<optimized out>, user_data=0x55e521454510) at src/shared/gatt-client.c:1559
> > #2 0x000055e51fde157c in disc_att_send_op (data=0x55e521454b20) at src/shared/att.c:547
> > #3 0x000055e51fddd802 in queue_remove_all (queue=0x55e52144da10, function=function@entry=0x0, user_data=user_data@entry=0x0, destroy=destroy@entry=0x55e51fde1560 <disc_att_send_op>) at src/shared/queue.c:354
> > #4 0x000055e51fde285a in disconnect_cb (io=<optimized out>, user_data=0x55e521447330) at src/shared/att.c:576
> > #5 0x000055e51fded0d5 in watch_callback (channel=<optimized out>, cond=<optimized out>, user_data=<optimized out>) at src/shared/io-glib.c:170
> > #6 0x00007fbccc71726f in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
> > #7 0x00007fbccc7191b1 in ?? () from /usr/lib/libglib-2.0.so.0
> > #8 0x00007fbccc71a0c3 in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
> > #9 0x000055e51fded6d6 in mainloop_run () at src/shared/mainloop-glib.c:79
> > #10 0x000055e51fdedb58 in mainloop_run_with_signal (func=<optimized out>, user_data=0x0) at src/shared/mainloop-notify.c:201
> > #11 0x000055e51fd56909 in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:756
> 
> It looks like an early disconnect happens, can you collect the hci
> trace with btmon when this happens.
> 
> > The syslog also adds these line just before the segfault:
> >
> > Feb 19 09:12:49 geekuillaume-laptop bluetoothd[1189]: Read Report Reference descriptor failed: Request attribute has encountered an unlikely error
> > Feb 19 09:12:49 geekuillaume-laptop bluetoothd[1189]: Read Report Reference descriptor failed: Request attribute has encountered an unlikely error
> > Feb 19 09:12:49 geekuillaume-laptop bluetoothd[1189]: Protocol Mode characteristic read failed: Request attribute has encountered an unlikely error
> >
> > The mouse is a Logitech MX Master 2 which has no problem on Windows with the same laptop. I have a keyboard (Keychron K2) connected by Bluetooth before the crash which still works after the crash. If I restart the bluetoothd process with systemctl, the mouse reconnects and it works fine but can crash again after some random period of time.
> >
> > There is another issue with the mouse that could be related: sometimes, the mouse stops working and a lot of "bt_uhid_send: Invalid argument (22)" are logged to the syslog. After 10 seconds it goes back to working fine.
> >
> > What to do to debug this?
> 
> Have btmon collecting the HCI traffic, I suspect the mouse may be
> disconnecting after a period of inactivity and then reconnecting again
> once active, in any case we need to figure out how to reproce and then
> proceed to fix the problem.
> 
> -- 
> Luiz Augusto von Dentz
> 

----------
Guillaume Besson
+33 6 11 67 39 56
besson.co

