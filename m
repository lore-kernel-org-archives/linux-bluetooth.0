Return-Path: <SRS0=BOlL=2Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC876C3276C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jan 2020 01:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F79921D56
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jan 2020 01:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWh4l7sZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgACBUr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:20:47 -0500
Received: from mail-il1-f181.google.com ([209.85.166.181]:39297 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgACBUr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jan 2020 20:20:47 -0500
Received: by mail-il1-f181.google.com with SMTP id x5so35464522ila.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jan 2020 17:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=h+GMBXbxGePgXeRWnyAv40LFcSlKEWF1htGheF0K9wc=;
        b=ZWh4l7sZHnJOtJFHRHHQqZ2abPVKCxBqBEOn/9NY1uMKdStYx+f3O2gIDcDFGrV2uk
         iDwbwsorYGNnqOsPemfP+hHfhQFWUKnnKgxte39evyvLVWcmIXkC91qO5OHL3wfcZIaD
         Re2lW+A3BJ7PbWacnEVlnoPXVLJ/htqHoR0LbtjFbUsPeOF3YCSiUtjJrif1d8y2bnmn
         rIJkVLb+DNK9y7fgRiQ7eAgnXvHIMTYgxKl8q0uXsxxeI4wUFM3YIl8bqD37of8z0uNZ
         kXtLuzB4AqwnuVQL2vR4yVrT3+cJEI9tlotZi7jdJ4mW/8xjF06NuWkj5/y5ABephKwJ
         jz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=h+GMBXbxGePgXeRWnyAv40LFcSlKEWF1htGheF0K9wc=;
        b=X0maTb3/arq63WA9u/Nv/jiCQ+obyPMl939EgRC3lcqYvVPj6Crqv5fJcgV2f6ZG8Y
         zt7wH9Vr2femIJ/ZcaTNwrUSRIzTmDBvVgDNXIfR76TO6irdUcpFSqdRAA3ARibK1O0I
         wj2Ta1QSJa6GzmaPwgCjFI3r4qTzUF4r8TnQY71+v23IilPsC4oR+vOOUhyMmJA/bdjS
         XTQNGsRg6IdPxiitJhNV+IhvvXwV4Bp9AdP58YBSBKpHj/Uucrt6xuzRT3htpdQPgILq
         HKfXBP+P+G5pibAcyC8e4vpRhgpUMKnkewDLHSbB/l/Sv/MJTYy2bzIZhfB/4NDQY/WI
         dUhw==
X-Gm-Message-State: APjAAAVfAei8xiDBRkF4NNUYD2vP81KdhEUlgZeex8rwv3+USrvdlOOy
        bJn6G9I5h7gYCv0mAsWqP6PurDZ6PzAri9WwYM0fo62u
X-Google-Smtp-Source: APXvYqzCEhJtqeFVmAVq+wm9cMC4Bl9lSj39lSn19deOBRhRlIXdDEujTwXv9qk+H8p+jk4EVQLgxzK0B5k9N0/l7uI=
X-Received: by 2002:a92:c747:: with SMTP id y7mr46017271ilp.60.1578014446079;
 Thu, 02 Jan 2020 17:20:46 -0800 (PST)
MIME-Version: 1.0
From:   Peter Belau <pbelau1@gmail.com>
Date:   Thu, 2 Jan 2020 19:20:35 -0600
Message-ID: <CAAERL8RHaWGAg5FOwts_pdDmagSdDj-Ui3ittmop+beVj9y6dQ@mail.gmail.com>
Subject: Problems reading characteristics with Bluez 5.52
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I'm trying to get a Qardio ARM BP monitor working with Linux/Bluez but
cannot seem to read any device characteristics with Bluez. My
interaction through bluetoothctl looks like this:

# menu gatt
# attribute-info  00002a35-0000-1000-8000-00805f9b34fb
Characteristic - Blood Pressure Measurement
    UUID: 00002a35-0000-1000-8000-00805f9b34fb
    Service: /org/bluez/hci0/dev_B0_49_5F_02_B5_61/service0400
    Value:
  16 7f 00 49 00 5b 00 00 00 00 00 00 00 00 35 00  ...I.[........5.
  00 00                                            ..
    Notifying: no
    Flags: indicate
# select-attribute 00002a35-0000-1000-8000-00805f9b34fb
# read
# Attempting to read /org/bluez/hci0/dev_B0_49_5F_02_B5_61/service0400/char0410
Failed to read: org.bluez.Error.Failed

I have bluetoothd running with debug flags but nothing appears in the
debug logs. What am I doing wrong?
