Return-Path: <SRS0=AiOn=N6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCDEC43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 09:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70062206BA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 09:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qv6h2Pjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70062206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeKSTvA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:51:00 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:35118 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbeKSTu7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Nov 2018 14:50:59 -0500
Received: by mail-oi1-f169.google.com with SMTP id v6so12400741oif.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Nov 2018 01:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bPxQF30e525Cxq1QNN5X/YI6ZSjfeZ2JyuFQ5DzKfgc=;
        b=Qv6h2PjodGyxHbWAINxgHvsBQvXVt1XnZ1N/r0+5Tmo6cKSYt3dbvPcjqe1WcIDhwN
         brx9RxM2rI6q0HPTn59rGd4xW7EvUngqI46Xu4m3mL28xXZ7ac93+ZBBA7L0+YJJhRZg
         e+pcqQ9JZgF+y4MvxSKe7Ek2sOzy9Ln4QeS+lFK+oAtlhyGXIX+camKr/4nuXYJxWmQZ
         9OvuaAZLfu/r6a4NiR//GJdJfZR7a6hlo4z0U9hqY/xj/89sFUOzRZhGjSrpLVWMS2Xo
         HVn80TYn9PKNCtNHSW6K6f7qp4FgUvBvt2u5CkpSRrJDkkIgdXHTmZGXei2kSN7ZRc5T
         JPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPxQF30e525Cxq1QNN5X/YI6ZSjfeZ2JyuFQ5DzKfgc=;
        b=unG5J2SVgd6KchO8AjJvK9kSY3A7vIFYJGOjs5G6GyGW0oNfVZRgo02qqPb/PciAPx
         FktUTe9iVrYE30ob7iqcjQ18px92xZsk8GPZoxxoTjUXBPn3cucO06OUUKZNksD9nFvH
         wTfxeS3az4F7WoTzqS1zEM07xYyd68a8ybf1RDqOgrjD9WUElGzDXxvpcY+tZJpUpjvK
         AY9L9DXWzMLvvx4Tl1xoJj6BLgI2yonyKUmeHWonCMbkxrwN0m96tWsh0lDF1TtF0RYC
         dZPY1zdJCXNbwMt44JYZn/L5xCEWlI83kL/IXJckOTpic1HfFZnMx6sP4a+ulx539agF
         9wBg==
X-Gm-Message-State: AGRZ1gLf1n8au5aCb7zY22ogL20hq9Ed2A9irA8iVrGRLNiCu88WUEAs
        L4mXYTz5yFsTmxCWyKT/M3nnpiYLxVOw3lOTizE=
X-Google-Smtp-Source: AJdET5fZbg7XC52eD4svATqbmubHv0KjmNc1X+l9jZ1DEcjzSXi6MnG6apruKOsmFSM6tvktQh5h3SC7bT+fG3Wy09M=
X-Received: by 2002:aca:d886:: with SMTP id p128-v6mr6829513oig.346.1542619676010;
 Mon, 19 Nov 2018 01:27:56 -0800 (PST)
MIME-Version: 1.0
References: <CAO9gXyTw4P+poT_qDi3SoBHaBELWdPV7Fv4Q7Ce7vN7q_oDbDw@mail.gmail.com>
In-Reply-To: <CAO9gXyTw4P+poT_qDi3SoBHaBELWdPV7Fv4Q7Ce7vN7q_oDbDw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 19 Nov 2018 11:27:44 +0200
Message-ID: <CABBYNZJVR6XTEYshD9fv4wFm19nywrYC1bmTdVf9qu3iMaPQbA@mail.gmail.com>
Subject: Re: How to test SDP(Service Discovery Protocol) on PTS ?
To:     Calvin Yoo <choongbeom@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Calvin,

On Mon, Nov 19, 2018 at 5:00 AM Calvin Yoo <choongbeom@gmail.com> wrote:
>
> Hello,
>
> "LMP Error Transaction Collision" error occurs when I try to test
> SDP/SR/SA/BV-01-C.

LMP errors is don't to the controller, it has nothing to do with the
host stack where SDP is implemented.

> And finally displays "IUT failed to accept SDP channel".
> I checked server role and other mandatory items of SDP ICS and start
> the test and make my device discoverable(advertising).

SDP is used only on BR/EDR so the term advertising here makes no
sense, all you need to do is to make the adapter
connectable/discoverable:

bluetoothctl> discoverable on

> Is there any prior preparation for this test or need controls with sdptool?
> I mean do I need to do something more than advertising?

Don't advertise, BLE doesn't use SDP as it does use GATT to perform
service discovery.

>
> Thanks,
> Choongbeom



-- 
Luiz Augusto von Dentz
