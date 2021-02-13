Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7EAC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Feb 2021 23:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A49F64E3D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Feb 2021 23:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhBMX6t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Feb 2021 18:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhBMX6r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Feb 2021 18:58:47 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F328CC061574
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Feb 2021 15:58:06 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id t5so4066545eds.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Feb 2021 15:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scmarinetech-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=NsqqbHG0ceC2JxNYbDwk0HuWCJtr2+SBYYNB+QvP5H0=;
        b=X59iT4OKD1EFejnbnacehHRycIqPjna7m0KwXwcU5FWNtXFplN8DNOXlokv8M/3fhR
         fn6VAxS7hXFc8ZrQs7++tSGdI6eehnYdVq2DQmek80GrkNcXbS0G6MM8y1eeR3Hg8qVJ
         AuySghl6CPePpG/i5BSCYoI9P3CnKe0J1ALhRvGvcuAfFA8fxd7Guv3dRp3IVrGGyux9
         IuORJ9lGYNRqoNP9KtYGpDOgF1QpN8bjq+JHiQetcHt2PY2Ow2XLrVoLCYLrzDY4yK33
         AA9MrjMijelOxTGSuODqe1Mbu/j1+WSTk/lRYIO+HVqHaXBAhUfxIaJaqGC2FcJioJEl
         /Cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NsqqbHG0ceC2JxNYbDwk0HuWCJtr2+SBYYNB+QvP5H0=;
        b=riKgW42tmnOtGxCEvgSoGyBgbQYaRdH4jYWLXvZJPiXJkLqQaILrWafh9h9+DDa37W
         PZ0wPMo4yoJO9Wbdx12OM3PGnfgDPUmevqXfZH3N8AXEjkoK6pIvTq+3w4DiT5U5VV2Y
         drHgxZZqsnL3Svm+Gmaga5Y8mjTOtMU36D3kzl5gaecsJIB47uY1XxsSfxadVHkI+dQx
         rjUOTCZcCKNRin3FjTAYAdMcqgLNeDZMd19QgHjY/MoOVl+Isu/RrPZauKJ33pj6piR0
         97xxU7/FFcQjdEkHwzN15mcHvHegLCDrASCcYG2c8f/fMp2QYHMd1copTh5Hzne12jtY
         t5uw==
X-Gm-Message-State: AOAM532sSOShpCWpDoOd+2jau4RiBI5m75Lg8wKa9aAe7WpTcPdHHVpN
        Mtfx6vcSV+HPh3IPXHHedbMyotTXjv0dg3ywK8oFHUqSngozjUlE
X-Google-Smtp-Source: ABdhPJyD7S7hUK2mG3X2rHs8zZrEYHVaMj8paEJCl+Ln6mhQDQRScEPBUfOia5/7xz/pjgTV+80//6R3IbQKpzukOt8=
X-Received: by 2002:a05:6402:2547:: with SMTP id l7mr9216730edb.157.1613260685558;
 Sat, 13 Feb 2021 15:58:05 -0800 (PST)
MIME-Version: 1.0
From:   Sailor Jerry <sailorjerry@scmarinetech.com>
Date:   Sat, 13 Feb 2021 15:57:55 -0800
Message-ID: <CAFwzm1JbsDeQ-wtp+SH1V=iUT=PVKOX0WZYNWGd39SV0PPO3gQ@mail.gmail.com>
Subject: HID problem on Raspberry PI (Failed to initialize gatt-client)
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I'm trying to pair the remote control to the Raspberry PI running:
Linux 5.4.83-v7l+ #1379 SMP Mon Dec 14 13:11:54 GMT 2020 armv7l GNU/Linux

The BT remote is connected and I see the input coming in btmon, but it
fails to appear as HID input.

This is the output of bluetoothd:

 src/gatt-client.c:btd_gatt_client_connected() Device connected.
 src/adapter.c:new_conn_param() hci0 C7:A3:E8:B2:B1:EB (1) min 0x0006
max 0x0006 latency 0x0063
 src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
 src/device.c:gatt_debug() Primary services found: 5
 src/device.c:gatt_debug() start: 0x0001, end: 0x0004, uuid:
00001801-0000-1000-8000-00805f9b34fb
 src/device.c:gatt_debug() start: 0x0005, end: 0x000b, uuid:
00001800-0000-1000-8000-00805f9b34fb
 src/device.c:gatt_debug() start: 0x000c, end: 0x000e, uuid:
0000180a-0000-1000-8000-00805f9b34fb
 src/device.c:gatt_debug() start: 0x000f, end: 0x0027, uuid:
00001812-0000-1000-8000-00805f9b34fb
 src/device.c:gatt_debug() start: 0x002b, end: 0x002f, uuid:
00010203-0405-0607-0809-0a0b0c0d1912
 src/device.c:gatt_debug() Characteristics found: 3
 src/device.c:gatt_debug() start: 0x0028, end: 0x002b, value: 0x0029,
props: 0x12, uuid:
 src/device.c:gatt_debug() start: 0x002c, end: 0x002d, value: 0x002d,
props: 0x06, uuid:
 src/device.c:gatt_debug() start: 0x002e, end: 0x002f, value: 0x002f,
props: 0x02, uuid:
 src/device.c:gatt_debug() Failed to insert characteristic at 0x0029
 src/device.c:gatt_debug() service disappeared: start 0x002b end 0x002f
 src/device.c:gatt_debug() Failed to initialize gatt-client
 src/device.c:gatt_client_ready_cb() status: failed, error: 10
 src/device.c:device_svc_resolved() /org/bluez/hci0/dev_C7_A3_E8_B2_B1_EB err -5
