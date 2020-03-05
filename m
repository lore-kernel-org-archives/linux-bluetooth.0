Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8DDC3F2D2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 23:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AE5207FD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 23:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAp1+bn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCEXdv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 18:33:51 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36992 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgCEXdu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 18:33:50 -0500
Received: by mail-ot1-f66.google.com with SMTP id b3so691425otp.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2020 15:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2WYYDn8f8XiiimSBAtEFafrXJohsppd3HXqpqRWzOb0=;
        b=DAp1+bn3YnCarv3PFYVB6HtTMgHLzL4q9CQYDhV+cPTnQP+SB739oUyDy1fTH0Fa3Q
         nYKUZazBZOyAljXz08SMK/VSTM7jzivJ/hq7oOoF2OZ6qi6rY+qT+d24d6LAUNEvc8Tl
         JOqOf8TXnuosfbEbMnoRA/GvoDFpsvbgd8px0mOZAIyv/U9U8UBftQmKJuY5y3qJzC2o
         MDV+yJvZkcyWwD4H4EqeMLFs/TTbDQg14doE5v7hyRQzec5z44U2ap3V+lKCZDvKaRLO
         fR0uJHtUdfHvUuYptBVQvwsT/Y4vz1+0K0YmN6uMyEwOa5X8+LdutjbQ/n+66Z1+fuSJ
         12BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2WYYDn8f8XiiimSBAtEFafrXJohsppd3HXqpqRWzOb0=;
        b=rpIbpANhpnNL2g/qdWBW0Ajz43OOAc46o1KIIEwZPrcYHiPMP5yHDBns2O+qBMMPl5
         1y9qCPuBdSXcQ0RwC9OqTUqJ85QGEflKTbR6QSfbV19rLyHCWBH6E87bCKt+NCavYL25
         wu3VKc6UqPr7DyAa5f2jAhIoOkLYDHKIOKWQyWqPFEiK7niMn7dq8V8Ls3gyBE0JEGbQ
         JLnQscy1Qf1kIx3/jMpTpELcw5S/zL4cqV/loc0TRhyitdP8ze2i6RxlGwj+RNIHPTJ4
         pvXk6EnetRelGidXYZ0nyFZWy1JXd/xwTvDNWewWx615M16JnwD8brL5Jxr6LeHGvFvI
         y60Q==
X-Gm-Message-State: ANhLgQ0vjXZrCm4NfHzsrSkSmMZPlA2OxoKkLi3QSGqARKq89peZlDZ3
        saUtT4JCL+5mhKQhMOFJMFp80ufmoi71sDsmqO9LRSdS
X-Google-Smtp-Source: ADFU+vsTB3d2FvHw7+QZqvN1AUfzPqtxFgQ50aIr/6f0SATYabAMsxF8KmTcUiq7rfYP7C+sLppC1S9aZNI/2D1exes=
X-Received: by 2002:a05:6830:1e34:: with SMTP id t20mr293558otr.79.1583451230117;
 Thu, 05 Mar 2020 15:33:50 -0800 (PST)
MIME-Version: 1.0
References: <3fa34b47-fd14-4672-8e95-93caa0c67397@www.fastmail.com>
In-Reply-To: <3fa34b47-fd14-4672-8e95-93caa0c67397@www.fastmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 5 Mar 2020 15:33:36 -0800
Message-ID: <CABBYNZ+wA8NHmBuUiWbE5GtxgUD4QaN71KQeJcSse8q+o9DsdA@mail.gmail.com>
Subject: Re: Random segfault on mouse connection
To:     Guillaume Besson <guillaume@besson.co>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Guillaume,

On Thu, Mar 5, 2020 at 8:45 AM Guillaume Besson <guillaume@besson.co> wrote=
:
>
> Hello,
> On my Lenovo X1 Extreme Gen2, the bluetoothd process segfault frequently =
on mouse connection. The bluetooth chipset is integrated in the Intel Corpo=
ration Wi-Fi 6 AX200 card. I'm using the latest Linux kernel (5.5.4) and bl=
uez-git (bluez-git-1:5.53.r4.g17516034a).
> Here's the stacktrace from the coredump:
>
> #0  queue_remove (queue=3D0x55e521458c90, data=3Ddata@entry=3D0x55e521454=
510) at src/shared/queue.c:258
> #1  0x000055e51fde63fe in enable_ccc_callback (opcode=3D<optimized out>, =
pdu=3D<optimized out>, length=3D<optimized out>, user_data=3D0x55e521454510=
) at src/shared/gatt-client.c:1559
> #2  0x000055e51fde157c in disc_att_send_op (data=3D0x55e521454b20) at src=
/shared/att.c:547
> #3  0x000055e51fddd802 in queue_remove_all (queue=3D0x55e52144da10, funct=
ion=3Dfunction@entry=3D0x0, user_data=3Duser_data@entry=3D0x0, destroy=3Dde=
stroy@entry=3D0x55e51fde1560 <disc_att_send_op>) at src/shared/queue.c:354
> #4  0x000055e51fde285a in disconnect_cb (io=3D<optimized out>, user_data=
=3D0x55e521447330) at src/shared/att.c:576
> #5  0x000055e51fded0d5 in watch_callback (channel=3D<optimized out>, cond=
=3D<optimized out>, user_data=3D<optimized out>) at src/shared/io-glib.c:17=
0
> #6  0x00007fbccc71726f in g_main_context_dispatch () from /usr/lib/libgli=
b-2.0.so.0
> #7  0x00007fbccc7191b1 in ?? () from /usr/lib/libglib-2.0.so.0
> #8  0x00007fbccc71a0c3 in g_main_loop_run () from /usr/lib/libglib-2.0.so=
.0
> #9  0x000055e51fded6d6 in mainloop_run () at src/shared/mainloop-glib.c:7=
9
> #10 0x000055e51fdedb58 in mainloop_run_with_signal (func=3D<optimized out=
>, user_data=3D0x0) at src/shared/mainloop-notify.c:201
> #11 0x000055e51fd56909 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>) at src/main.c:756

It looks like an early disconnect happens, can you collect the hci
trace with btmon when this happens.

> The syslog also adds these line just before the segfault:
>
> Feb 19 09:12:49 geekuillaume-laptop bluetoothd[1189]: Read Report Referen=
ce descriptor failed: Request attribute has encountered an unlikely error
> Feb 19 09:12:49 geekuillaume-laptop bluetoothd[1189]: Read Report Referen=
ce descriptor failed: Request attribute has encountered an unlikely error
> Feb 19 09:12:49 geekuillaume-laptop bluetoothd[1189]: Protocol Mode chara=
cteristic read failed: Request attribute has encountered an unlikely error
>
> The mouse is a Logitech MX Master 2 which has no problem on Windows with =
the same laptop. I have a keyboard (Keychron K2) connected by Bluetooth bef=
ore the crash which still works after the crash. If I restart the bluetooth=
d process with systemctl, the mouse reconnects and it works fine but can cr=
ash again after some random period of time.
>
> There is another issue with the mouse that could be related: sometimes, t=
he mouse stops working and a lot of "bt_uhid_send: Invalid argument (22)" a=
re logged to the syslog. After 10 seconds it goes back to working fine.
>
> What to do to debug this?

Have btmon collecting the HCI traffic, I suspect the mouse may be
disconnecting after a period of inactivity and then reconnecting again
once active, in any case we need to figure out how to reproce and then
proceed to fix the problem.

--=20
Luiz Augusto von Dentz
