Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E540AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 21:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD62B20734
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 21:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6+6r94w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgFCVGc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 17:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgFCVGc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 17:06:32 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BB7C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 14:06:32 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id m2so3042640otr.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 14:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sg2CYBqopDGDr+8VKbF7fs0kGFl/fW8WKEvVebttR6c=;
        b=k6+6r94w5cjTszY2QOzGp/lUjAE+6XubJUQL/3py/Y9P1WEm/dXbQLTCreBHcXldq4
         t0x+xV+Te//2Tfhe5DT9BB+o6CTLKuxG+cTFW5YFsSPHU9h3W1Dit9sLktZSjXAMn827
         T5W/IcxxVXTX3sunCmQH8d+804dVHMix1feOHm6Io79HHSWKZcPUvFOfNC8KVpSA716+
         2bzPOLbQjHueARXEZB85VeFymVnkisE4khuVp88XEd0Xl6O/X32p7UKT6hAXma07wFzd
         /gvk0x2tchyJkOOgICvaw0zItWv2FSTWi1nKg4Jq1qUqoaHkKcENbAwY7amwcy6x+mA7
         AyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sg2CYBqopDGDr+8VKbF7fs0kGFl/fW8WKEvVebttR6c=;
        b=sfE5wIe0h3b4Ieo3Bman6fx3t2C7yZNsGGyJ6VAhZpufOFa49ip9qEyrVHQwC775qJ
         jeCrnQWiAUOLjJ0ggEnOxXMrgfP3R0opLBNoPXcWTKn/Knt7L/K5EKGH+9NCcnaeeLYh
         zJSr404sztozD5iEaykAvbzCb8q6pbUEHC4jBywuiu2yTR9Y0SomNH21adUzXlMHUVXz
         oNJaDs6B5i3mYkertSmzDzEfwTDnJoqed3lcmZcH/iDX3WjbVR0a+W2xn81+Xv+KxIZ+
         9Awy2LOzszISe2XG0/2w8pimT3lMVE/LUOtJk0YHuJZcAZ1vY7uX5ilkmX2j/GdUU0y6
         ofrg==
X-Gm-Message-State: AOAM530kMwQn6lwJrLBoMvB28E1PsWJjQKFUU6Cd+IBAgp+j7x0gN6jA
        swxgjYdkV13jB7EssrdVBsefcgEL/1qWVEAqAbk=
X-Google-Smtp-Source: ABdhPJzmDBaDrJ4WHCC6rLUcxroRTQU7UE0IKsuRHxG2SUUzqqboInPravhqpvVq4Odtp2I89dI3F8IUFMAdD0umSlM=
X-Received: by 2002:a05:6830:310c:: with SMTP id b12mr1427007ots.11.1591218391144;
 Wed, 03 Jun 2020 14:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAGpqJgrBtwdauxv03jXsq+8+EG_BW-4QZXryXt-e5Y8HA_5+_g@mail.gmail.com>
 <CABBYNZLLx+zX_XyNjkW99D7HG_6+eZM_MP7EWVVAuuRtf0J6dw@mail.gmail.com>
 <CABBYNZJxVsnGtpnJkCCQtQFKXOiSEV7490me1vjAOOGynCdfUw@mail.gmail.com> <CAGpqJgrcxd0iwWUu=VB=MhiSS9+TRMLLsyTjbwQMdJ+6u66u6Q@mail.gmail.com>
In-Reply-To: <CAGpqJgrcxd0iwWUu=VB=MhiSS9+TRMLLsyTjbwQMdJ+6u66u6Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Jun 2020 14:06:18 -0700
Message-ID: <CABBYNZKTQzEuBpP3YG7=Ms6c-36mnR7qAc4A1XDOLfggDPXXCA@mail.gmail.com>
Subject: Re: Segmentation fault in bluetoothd with btgatt-client
To:     Arthur Lambert <lambertarthur22@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Arthur,

On Wed, Jun 3, 2020 at 11:22 AM Arthur Lambert
<lambertarthur22@gmail.com> wrote:
>
> Hi Luiz,
> thanks for your reply!
>
> Sorry I am lazy and stupid. I know that your next question will be
> around symbol...
>
> After removing the binary strip option and enable debug symbol :
>
> bluetoothd[246]: src/device.c:device_svc_resolved()
> /org/bluez/hci0/dev_80_32_53_37_58_A6 err -5
> bluetoothd[246]: src/device.c:gatt_debug() Read By Grp Type - start:
> 0x00bb end: 0xffff
> bluetoothd[246]: src/device.c:gatt_debug() Read By Grp Type - start:
> 0x0001 end: 0xffff
> bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> 0x0001 end: 0x00ba
> bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> 0x0001 end: 0x00ba
> bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> 0x002a end: 0x00ba
> bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> 0x0053 end: 0x00ba
> bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> 0x007a end: 0x00ba
> bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> 0x00a3 end: 0x00ba
> bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> 0x00ba end: 0x00ba
> bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> 0x0001 end: 0xffff
> bluetoothd[246]: src/gatt-database.c:db_hash_read_cb() Database Hash read
> ==246== Invalid read of size 1
> ==246==    at 0x4831BA4: memcpy (vg_replace_strmem.c:1035)
> ==246==    by 0x87F3B: read_by_type_read_complete_cb (gatt-server.c:392)
> ==246==    by 0x892AB: pending_read_result (gatt-db.c:145)
> ==246==    by 0x8B2FB: gatt_db_attribute_read_result (gatt-db.c:1866)
> ==246==    by 0x3AB0B: db_hash_read_cb (gatt-database.c:1156)
> ==246==    by 0x8B1AB: gatt_db_attribute_read (gatt-db.c:1825)
> ==246==    by 0x87DB7: process_read_by_type (gatt-server.c:482)
> ==246==    by 0x8854F: read_by_type_cb (gatt-server.c:559)
> ==246==    by 0x81727: handle_notify (att.c:966)
> ==246==    by 0x81873: can_read_data (att.c:1057)
> ==246==    by 0x8B91B: watch_callback (io-glib.c:170)
> ==246==    by 0x488A413: g_main_context_dispatch (in
> /usr/lib/libglib-2.0.so.0.5600.3)
> ==246==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
> ==246==
> ==246==
> ==246== Process terminating with default action of signal 11 (SIGSEGV)
> ==246==  Access not within mapped region at address 0x0
> ==246==    at 0x4831BA4: memcpy (vg_replace_strmem.c:1035)
> ==246==    by 0x87F3B: read_by_type_read_complete_cb (gatt-server.c:392)
> ==246==    by 0x892AB: pending_read_result (gatt-db.c:145)
> ==246==    by 0x8B2FB: gatt_db_attribute_read_result (gatt-db.c:1866)
> ==246==    by 0x3AB0B: db_hash_read_cb (gatt-database.c:1156)
> ==246==    by 0x8B1AB: gatt_db_attribute_read (gatt-db.c:1825)
> ==246==    by 0x87DB7: process_read_by_type (gatt-server.c:482)
> ==246==    by 0x8854F: read_by_type_cb (gatt-server.c:559)
> ==246==    by 0x81727: handle_notify (att.c:966)
> ==246==    by 0x81873: can_read_data (att.c:1057)
> ==246==    by 0x8B91B: watch_callback (io-glib.c:170)
> ==246==    by 0x488A413: g_main_context_dispatch (in
> /usr/lib/libglib-2.0.so.0.5600.3)
> ==246==  If you believe this happened as a result of a stack
> ==246==  overflow in your program's main thread (unlikely but
> ==246==  possible), you can try to increase the size of the
> ==246==  main thread stack using the --main-stacksize= flag.
> ==246==  The main thread stack size used in this run was 8388608.
> /usr/bin/bluetoothd: can't resolve symbol '__libc_freeres'
>
> is it the crypto error that you expect?
> Could you share a sha1 commit or a link to the patch to test the potential fix?

Ive just pushed the fix:

commit 41a5413023fa85bc711d461eb736a0624542df2d
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Wed Jun 3 10:31:59 2020 -0700

    gatt: Fix possible crash when unable to generate hash


-- 
Luiz Augusto von Dentz
