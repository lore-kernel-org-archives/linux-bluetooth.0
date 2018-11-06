Return-Path: <SRS0=bD4U=NR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125E7C32789
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Nov 2018 16:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC432085B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Nov 2018 16:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InU2oLIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC432085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389214AbeKGB4S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:56:18 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:40088 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388658AbeKGB4S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Nov 2018 20:56:18 -0500
Received: by mail-lj1-f181.google.com with SMTP id t22-v6so11999649lji.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Nov 2018 08:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3/PttDuZnei6BXEnvYrFteQMix1B5JMc3k5I8i6eToQ=;
        b=InU2oLIMetb6UqPzjdNczEGfSBYwYJnaQMXFZ5cx4rKOvNHdj+PB8j7la9+FJkMt1V
         l1TVGRlhTuz+F4k4mYTpv48/nqAk0RYgQHC8ZNm+Af9OPf8OFMWb9q1XP+y5OXJ/DXqL
         pPtD/VYMWczdTxG90Q8W860DxdeV5bDKdLXmNBGxrwu1yNQOmBEehx63AD4uKyQ+J129
         3wJkjLEdFDKLGmWHDJyRpQqKaPSGmVsHmKJaIVvTqmJwz+0OAm6scijsRd/vx2Qirry7
         Ruxgxv4yHaAernI+vkbdoTvdO5kroT5nSkrSru3g9Q0N1ZlBNWV3XTk3A6AukHE8wX55
         bFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3/PttDuZnei6BXEnvYrFteQMix1B5JMc3k5I8i6eToQ=;
        b=QNYjYo1IxWpunBgeP2i2AaKcFYeC7HfDMWV/IQCslJCFMYtU+MZmCtClZhuKUTFafl
         PmmMviR+8aIImu4R2QJKeUdRNqTZT1VeKaWAuujDKV6Tb81tJOKTYMxGyZExaJ5HI0lJ
         OmjrvfPSF4fJnlWvLJTFtH14wxbn5lGXXSom61BxXv61v38nVtoPFj+jpQTlMxzgj4e3
         xO9MHJUXGmdSUXqqcogjOs0joqhMQhqn7Y7hwqvPy5++TEvjCfyP9E7A7i3sxvA48LkS
         F4sdPc8u5FRd/J6SFnqdAKTodQQiQVVXxyv6PtxT5xXDeoHKdJ+TRz1JyWvxNM6HnhMn
         ERJQ==
X-Gm-Message-State: AGRZ1gLQkeQzN4Zgm41FWvLTVWS3icTCmU43WsynHFrcDlh2W0eaQxzf
        57/YTXtNGQts07+BtY42/z03Pxekj+bvTRK9Uyra6TE9
X-Google-Smtp-Source: AJdET5c/RPeW9IBDKPxTa/m27OSrQI1Oi7tQwP0wZvRKAPrqlBhQVVmvN+0p0jKmxj/S7QZ8pJNywZuThsG5pb46a1A=
X-Received: by 2002:a2e:6e08:: with SMTP id j8-v6mr19252528ljc.61.1541521817001;
 Tue, 06 Nov 2018 08:30:17 -0800 (PST)
MIME-Version: 1.0
From:   dhananjay gj <dhguja@gmail.com>
Date:   Tue, 6 Nov 2018 17:30:05 +0100
Message-ID: <CAKOuF3dMz7THOgEzOAF0GdfUeDoXp0K6-xZiJNCRA0DTd7L5_g@mail.gmail.com>
Subject: Compatibility issue with Zephyr BLE
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello All,
       I am working on BLE based barcode scanner which will send the
data via HID over GATT profile. I am using Nordic based nRF52840
device and Zephyr 1.13 BLE stack with default connection interval
parameters set by the peer system.

My device uses 5 BLE Tx buffers so that my HID application works fast
since more HID characters can be sent per connection interval. This
works as expected in Android, iOS Host devices. But on Windows 10 and
Ubuntu system the behavior seen is that HID characters are not
accepted after some point. The last character that is sent before
hanging is printed continuously until the connection is closed. The
common factor between both these laptops is Intel BLE chipsets. I also
posted a similar question in zephyr but my application works fine in
Android and iOS device with increased buffers. The suggestion was that
peer is not handling data transfers in "connection event length" for
some reason. Most of the time the disconnect reason is either 0x22 or
0x08.

When only one packet is sent per connection interval then there is no
problem with this connection. But this affects my throughput sending
press and release keys for every HID character.

Has anyone else faced similar issue with data stopped receiving
abruptly in Intel chipsets in either Windows or Linux systems due to
increased Tx buffers on the peripheral side.

Regards,
Dhananjay G J
