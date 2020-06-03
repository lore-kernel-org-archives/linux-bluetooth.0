Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9328CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 18:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7761E20734
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 18:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGSfLSh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgFCSWj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCSWi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 14:22:38 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CCFC08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 11:22:38 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g18so2869951qtu.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 11:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtk3d48GZKqQPiCGMf66/sanUiiyzy5OiciyHOy0SUU=;
        b=VGSfLSh9K71NZ5CAnTNhOnUm88A1gP5om7Au6ebzMIfkHFTxbkq4ITNWWt68CaCsiu
         u6VPzeG0wsrTyYICiv1L9kYvE9lUzv/JqvyYCIWf/KuMGgxfbeedg57yNXwaXrbjQMQT
         4GpUmamIG7DCf/w/95kjoDchDmy8nh6PD3Mg4wcDVD11ABrvhzE9B2hMDhR/eIVK79fG
         GDxKmQZzXeVeNvEWr6kI/p/VfDLVngr0YeEVQOFl5sjdHHe9L/CEg4yKv+wrpLpbQAbK
         3Kz1ti+2ETpKTKUU13w2bzeGuErXIU5Fk82FXlB+cFtSq21FG0/kFe0bAyhT/0ouquMI
         46oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtk3d48GZKqQPiCGMf66/sanUiiyzy5OiciyHOy0SUU=;
        b=kkN4C3+vFzjbl1gQmO5CALeEysiWN9bo7AhZHj/9wGRQe+xKZo8hnsSF1ojEUK8zbk
         3JmP3GjcrfcI7BvTcNGmacicRlArMj4WF5PCVZdZm9V/jikekYnaFBKs9G97C3tQgJvH
         Bo4/VZ7oIT6kP1gFOy5zzjwB14j71l+Au79rMJESBl8UHgLCCW3AbVgeAUulR9mb9jHX
         19zi97gPxO/9/KGnKNdgQdpOr/yHmTI71arxHCnx5cfH8vBKkbN4+LeqdryK4oz+UTnA
         24UKzFG4lki2+WEaTIS5pnRBdZD/ot49/ceKSM32GX66wLDZiyLlPN6LtYl42ENpZkn0
         2vMw==
X-Gm-Message-State: AOAM530vr8Vxpmm4ThAtAuSJMMv0sKfhdR6M9X8Vzon15leH6MwFYueK
        2FQY9f4cPeP/FlXDcVBBOc3hBiZnHhKzqSvaFmE=
X-Google-Smtp-Source: ABdhPJycHYyhrocdYRAKI2pdJAOxn/G1fDfK7sJocYTPa58SXDcyO8a0V6BglpGNRgvqNAwzqF+yClltbBs151I02uo=
X-Received: by 2002:ac8:3f88:: with SMTP id d8mr691865qtk.164.1591208556444;
 Wed, 03 Jun 2020 11:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAGpqJgrBtwdauxv03jXsq+8+EG_BW-4QZXryXt-e5Y8HA_5+_g@mail.gmail.com>
 <CABBYNZLLx+zX_XyNjkW99D7HG_6+eZM_MP7EWVVAuuRtf0J6dw@mail.gmail.com> <CABBYNZJxVsnGtpnJkCCQtQFKXOiSEV7490me1vjAOOGynCdfUw@mail.gmail.com>
In-Reply-To: <CABBYNZJxVsnGtpnJkCCQtQFKXOiSEV7490me1vjAOOGynCdfUw@mail.gmail.com>
From:   Arthur Lambert <lambertarthur22@gmail.com>
Date:   Wed, 3 Jun 2020 20:22:25 +0200
Message-ID: <CAGpqJgrcxd0iwWUu=VB=MhiSS9+TRMLLsyTjbwQMdJ+6u66u6Q@mail.gmail.com>
Subject: Re: Segmentation fault in bluetoothd with btgatt-client
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,
thanks for your reply!

Sorry I am lazy and stupid. I know that your next question will be
around symbol...

After removing the binary strip option and enable debug symbol :

bluetoothd[246]: src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_80_32_53_37_58_A6 err -5
bluetoothd[246]: src/device.c:gatt_debug() Read By Grp Type - start:
0x00bb end: 0xffff
bluetoothd[246]: src/device.c:gatt_debug() Read By Grp Type - start:
0x0001 end: 0xffff
bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
0x0001 end: 0x00ba
bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
0x0001 end: 0x00ba
bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
0x002a end: 0x00ba
bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
0x0053 end: 0x00ba
bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
0x007a end: 0x00ba
bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
0x00a3 end: 0x00ba
bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
0x00ba end: 0x00ba
bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
0x0001 end: 0xffff
bluetoothd[246]: src/gatt-database.c:db_hash_read_cb() Database Hash read
==246== Invalid read of size 1
==246==    at 0x4831BA4: memcpy (vg_replace_strmem.c:1035)
==246==    by 0x87F3B: read_by_type_read_complete_cb (gatt-server.c:392)
==246==    by 0x892AB: pending_read_result (gatt-db.c:145)
==246==    by 0x8B2FB: gatt_db_attribute_read_result (gatt-db.c:1866)
==246==    by 0x3AB0B: db_hash_read_cb (gatt-database.c:1156)
==246==    by 0x8B1AB: gatt_db_attribute_read (gatt-db.c:1825)
==246==    by 0x87DB7: process_read_by_type (gatt-server.c:482)
==246==    by 0x8854F: read_by_type_cb (gatt-server.c:559)
==246==    by 0x81727: handle_notify (att.c:966)
==246==    by 0x81873: can_read_data (att.c:1057)
==246==    by 0x8B91B: watch_callback (io-glib.c:170)
==246==    by 0x488A413: g_main_context_dispatch (in
/usr/lib/libglib-2.0.so.0.5600.3)
==246==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
==246==
==246==
==246== Process terminating with default action of signal 11 (SIGSEGV)
==246==  Access not within mapped region at address 0x0
==246==    at 0x4831BA4: memcpy (vg_replace_strmem.c:1035)
==246==    by 0x87F3B: read_by_type_read_complete_cb (gatt-server.c:392)
==246==    by 0x892AB: pending_read_result (gatt-db.c:145)
==246==    by 0x8B2FB: gatt_db_attribute_read_result (gatt-db.c:1866)
==246==    by 0x3AB0B: db_hash_read_cb (gatt-database.c:1156)
==246==    by 0x8B1AB: gatt_db_attribute_read (gatt-db.c:1825)
==246==    by 0x87DB7: process_read_by_type (gatt-server.c:482)
==246==    by 0x8854F: read_by_type_cb (gatt-server.c:559)
==246==    by 0x81727: handle_notify (att.c:966)
==246==    by 0x81873: can_read_data (att.c:1057)
==246==    by 0x8B91B: watch_callback (io-glib.c:170)
==246==    by 0x488A413: g_main_context_dispatch (in
/usr/lib/libglib-2.0.so.0.5600.3)
==246==  If you believe this happened as a result of a stack
==246==  overflow in your program's main thread (unlikely but
==246==  possible), you can try to increase the size of the
==246==  main thread stack using the --main-stacksize= flag.
==246==  The main thread stack size used in this run was 8388608.
/usr/bin/bluetoothd: can't resolve symbol '__libc_freeres'

is it the crypto error that you expect?
Could you share a sha1 commit or a link to the patch to test the potential fix?

Thanks !
