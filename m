Return-Path: <SRS0=oIVb=TR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB49C04AB4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 May 2019 05:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775AD2083E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 May 2019 05:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeHoMZw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfEQF7R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 May 2019 01:59:17 -0400
Received: from mail-yw1-f49.google.com ([209.85.161.49]:45645 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfEQF7R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 May 2019 01:59:17 -0400
Received: by mail-yw1-f49.google.com with SMTP id w18so2297692ywa.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2019 22:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bISXiKylWgVtDGPdgNDN2e+SULGKG57sWzoy+spvpw8=;
        b=YeHoMZw/AhzuTurykPTChUk/SEEmHjd+Q31v41rIUDtoQWcSNVI+imSCffcyujpMZB
         mCprHZ1T9xDdjuUUo0VJEQ88urzuHKxq66zft+CUxdrteFXRufdxCZ4Y5d7bA1MM4xoG
         RtaTk45Cr65fvZgYXmuMKdP9v+S/miElvFElYxxkesxxg0vlXT/HxpGXIiLFYiLBusO7
         9tbDdwY0COB60A/GDnQ0V8RJMBGWiDhUWPhI5BNMQ/Q1QpnpnPDaNO9oHXn6aRQjrEuG
         FJccp0meD/XCoTIobxy4iG3mgi5WG/zTcdd5EzWYIbKEg7C6F26Q5IZz0/HSsyPfNf4v
         i5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bISXiKylWgVtDGPdgNDN2e+SULGKG57sWzoy+spvpw8=;
        b=lpOBfA/ghkkecnevfG0sVluY5smVDxgLblKYcb5WY+ixJ5P4XiOJVSZqBX1DnE/A1D
         /MOZz0tUK1fWcwi9Zg2Nv/YYWSeKoycYMn8XpfodQjszf+Ouin0J7esJZSbQImvxmtyG
         MNfgGLSiwtZ+0GE3xgKdQH57XPaavkWek3B398OhC5IiSkLHBab98RnCKO0g00pZJnPJ
         wx1wyFO+Zce139ioi4B4Vxlk8UebXtJR3Oa7R8LYowbs3tVAdZcLhd6D2NdCxpInmWqg
         3SIFqE3ddqHO36yeb7hw26lYzyCxTlNNdW0jKz6S3Wq8No4zLtxKz3KsmjAJ9Bb0wasc
         J8Yg==
X-Gm-Message-State: APjAAAVEISmd2awEwIpL1D179KDrpdzh6OMO2+STEzXYAjq2+TMR9Mho
        PXHJVdEMPahWKzUkv7MT3GE9H1VaDAEJJj8oNI8Da7AMMQg=
X-Google-Smtp-Source: APXvYqxgyBBi/FwhG30raImwDBQs/ztYeUPglXl1VHvZzRkAyZ5LwaLaCKKw6/k3UytuZlDhTU8Qvghp7R6nbviG+Oc=
X-Received: by 2002:a81:3b4b:: with SMTP id i72mr10751028ywa.297.1558072756615;
 Thu, 16 May 2019 22:59:16 -0700 (PDT)
MIME-Version: 1.0
From:   Carlos Pita <carlosjosepita@gmail.com>
Date:   Fri, 17 May 2019 02:59:05 -0300
Message-ID: <CAELgYhdqAxTGA98RsUEOSEA5WfhxGaVn7C_DegAfU13sHx817A@mail.gmail.com>
Subject: After kernel update: connect/disconnect forever while attempting to auto-reconnect
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

after upgrading to kernel 5.1.1 (and also 5.1.2) my bluetooth speakers
are unable to auto-reconnect. I can connect them without problems, but
once I turn them off and on again an unending sequence of connections
and disconnections begins:

---- manual connection ok ---------
[bluetooth]# connect E0:D1:E6:07:62:E1
Attempting to connect to E0:D1:E6:07:62:E1
[CHG] Device E0:D1:E6:07:62:E1 Connected: yes
Connection successful
[CHG] Device E0:D1:E6:07:62:E1 ServicesResolved: yes
---- turned off speakers and on again ----
[CHG] Device E0:D1:E6:07:62:E1 ServicesResolved: no
[CHG] Device E0:D1:E6:07:62:E1 Connected: no
[CHG] Device E0:D1:E6:07:62:E1 Connected: yes
[CHG] Device E0:D1:E6:07:62:E1 Connected: no
[CHG] Device E0:D1:E6:07:62:E1 Connected: yes
[CHG] Device E0:D1:E6:07:62:E1 Connected: no
[CHG] Device E0:D1:E6:07:62:E1 Connected: yes
[CHG] Device E0:D1:E6:07:62:E1 Connected: no
[CHG] Device E0:D1:E6:07:62:E1 Connected: yes
[CHG] Device E0:D1:E6:07:62:E1 Connected: no

I've tested this with a number of kernels:

linux-lts 4.19.43: doesn't work
linux 5.0.13: works
linux 5.1: works
linux 5.1.1: doesn't work
linux 5.1.2: doesn't work

All the above tests were done against bluez 5.50. I've also tested
bluez git master against linux 5.1.2 to no avail.

During failed attempts to auto-reconnect, the debug log shows:

May 17 02:25:27 carlos bluetoothd[8178]:
src/adapter.c:connected_callback() hci0 device E0:D1:E6:07:62:E1
connected eir_len 5
May 17 02:25:27 carlos bluetoothd[8178]:
src/adapter.c:dev_disconnected() Device E0:D1:E6:07:62:E1
disconnected, reason 3
May 17 02:25:27 carlos bluetoothd[8178]:
src/adapter.c:adapter_remove_connection()
May 17 02:25:27 carlos bluetoothd[8178]:
plugins/policy.c:disconnect_cb() reason 3
May 17 02:25:27 carlos bluetoothd[8178]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr E0:D1:E6:07:62:E1
type 0 status 0xe
May 17 02:25:27 carlos bluetoothd[8178]:
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
May 17 02:25:27 carlos bluetoothd[8178]:
src/device.c:device_bonding_failed() status 14

Some other info that may be relevant:

> uname -a
Linux carlos 5.1.1-arch1-1-ARCH #1 SMP PREEMPT Sat May 11 13:02:48 UTC
2019 x86_64 GNU/Linux

> yay -Qi pulseaudio
Version         : 12.2-2

If you need something else to track down this issue, please let me
know. I've also reported this to pulseaudio tracker:
https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/674.

Best regards
--
Carlos
