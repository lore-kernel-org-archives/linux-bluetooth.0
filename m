Return-Path: <SRS0=McSj=ON=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0492C04EB8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Dec 2018 19:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A32A2082B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Dec 2018 19:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpjeTUwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A32A2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeLDTxf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:53:35 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:38865 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeLDTxe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Dec 2018 14:53:34 -0500
Received: by mail-ot1-f41.google.com with SMTP id e12so16388302otl.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Dec 2018 11:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmmqXQv2a47QgU0160yr8itboqA/wqRp3qwj7kkYBc8=;
        b=MpjeTUwClS14ibVj9UXoq07jpDLZmSqIvHimDKBxO+zbUiAiJFTuqUhbo2EVChzRkY
         FolW6leAUL2Ik0TIk7ugxmCAuLa3DrbD7FnFpZuNpCuzHIBuL6ffy/QPqqyCFcnDqoQe
         aOU+kA0shv4GI8z4/enS7wYuRLH+WT+KgZLbbcSrxC4sXbBsK6wzazBUYw04AHNlOiGv
         PEFXkFwIz2h9fxoRsBOJ4fXHU04HKDvEuiGu6Pfbeqx8g2eXy5L4cINnRqjBwxtfOPbC
         LyUwPhCbbwWYt/gWmSZQ6vqiMkkIyQq0VUseii8jTrTn3krHtat12ZbvXHhE8zD28ZdA
         OF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmmqXQv2a47QgU0160yr8itboqA/wqRp3qwj7kkYBc8=;
        b=mCA/t5ZRtx6mHV2sbPdaWXHHjoZs5b0eDfLs2PqYFtX9r4SjZ6hp9rvpqaJwCzi+Rg
         +J2phT1wGAddVuVgFzBwQkO9dMsd+xVZPLhJ1UjHS6KUwy+pD9CrYKR7Q0U8D1Gz2y2d
         YiLUYzH78i1mWZyKeMwnu7xcwtvuSuNJL2po4Me4WJRdWncEDcj3SbvMwvB+E7JLRFjV
         ZoArpZ6iSkEmXL/fPKeyEmyvx2elwYYLKSlW8GNI7QO2diHWpnzIbKdWvKygJHms4Wb4
         hW6dQUdhiQ701uJCu4q8pyYG6/Z9a72owPWqJs5BjJsTyFwNz2UTIeAkU70wXWWBFtit
         UqGw==
X-Gm-Message-State: AA+aEWYWEpMykXHtApQB+fmYeeiZ6Ju5vneuZEuCxHS8AlbqP7jlS63h
        Snm38j2SrrPmv4IB1C4tW4W6Fp4Fvo+qHU+9CCA=
X-Google-Smtp-Source: AFSGD/Vvjg+qqN9yX8r4XB4KvVyShEInFxScU/mTvDDQIDk6O8a5Bx7wCaFtleRHyinOOFhRLyObaJdIPSihz/PfYzs=
X-Received: by 2002:a9d:3d0:: with SMTP id f74mr13037467otf.52.1543953213467;
 Tue, 04 Dec 2018 11:53:33 -0800 (PST)
MIME-Version: 1.0
References: <150d16d9-9149-a463-e285-aaea10bed6e4@gmail.com>
In-Reply-To: <150d16d9-9149-a463-e285-aaea10bed6e4@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 4 Dec 2018 21:53:21 +0200
Message-ID: <CABBYNZJbT3fv8tq7JvBjiDuE2W+p__uceBSkduYtrChq0i8WFA@mail.gmail.com>
Subject: Re: Error setting UUIDs discovery filter on big endian systems
To:     mwtaylor@gmail.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Matt,
On Mon, Dec 3, 2018 at 3:59 PM Matt <mwtaylor@gmail.com> wrote:
>
> Hi,
>
> When setting a UUIDs discovery filter I am receiving
> "org.bluez.Error.InProgress" on starting a scan (which isn't in progress
> and will not start unless the discovery filter is cleared).
>
> I am using bluez 5.50 (on openWRT). The problem seems to only appear on
> big endian hardware (tested a couple of recent kernel and bluez
> versions), the same software compiled for and tested on little endian
> hardware works as expected. The issue can be reproduced in the following
> way using bluetoothctl:
>
> # /etc/init.d/bluetoothd restart
> # bluetoothctl
> [bluetooth]# power on
> Changing power on succeeded
> [CHG] Controller 00:1A:7D:DA:71:13 Powered: yes
> [bluetooth]# menu scan
> [bluetooth]# uuids 0000180f-0000-1000-8000-00805f9b34fb
> [bluetooth]# back
> [bluetooth]# scan on
> SetDiscoveryFilter success
> Failed to start discovery: org.bluez.Error.InProgress
>
> Setting an rssi filter does work as expected on my big endian hardware,
> it is only the uuids filter that appears to show this problem. The issue
> appears whether set using bluetoothctl or directly using DBus.

Do you have the bluetoothd logs when that happens? I wonder if it is
something with our string to UUID conversion.


-- 
Luiz Augusto von Dentz
