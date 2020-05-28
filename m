Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430C1C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 22:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09022207BC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 22:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhaxCmg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436928AbgE1WXE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 18:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436996AbgE1WWQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 18:22:16 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AED5C08C5C6
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 15:22:16 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id m67so715433oif.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 15:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sso3b3wFHdKHP6wsjx5Ouk12Bu95ydxyC6VUzzziXS8=;
        b=KhaxCmg33d6zWZ+E7Sbx0S6xCoiwE1Pytsqkwc/0ryCwvzLj3uQUAunZDzoC12yOGf
         SX3xlsYuny+gBD/b42BqoVoCGg2vo8PFFvNJued+XNZoHjX6LveeneC1IvKmFLfXeH2K
         QvZ4ofkso/D7/9ZRgnZwL1FLNjrYjcZfcnaVIJnkQDA3HlS5VDutVF/0fk5Ik9Euzp0J
         xwQUS4Ct4E7XEgmYRbcsZY7wAGlPOKuJAer7HmFNU6xt+wvTsaW8/S8+7KDbovyH4ovI
         n5riK47qgJ+YbMe2aripLQ9IOC+wIYz5FlEk78hIQ7HAepKRrZ5jvZYUh9y88NQj+aJg
         zBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sso3b3wFHdKHP6wsjx5Ouk12Bu95ydxyC6VUzzziXS8=;
        b=CDXa0AISSPV5jyeVUOCN1mPhqwpjjbSHLG+OkG/0hutbuKX5qynfd7diHrIca7uzxZ
         DKuf9ats+FJqVathMBhqJFsn3SIluBZcp+Kw1dkjBMfnEtK1YZM9QVBbhPU9k3wnxTHi
         X8QAOJEyjDoWNJVUh4QxzY93eb+sIrOPoCySiXOwN1gPnOHeMT5EhCI+kWKu6LyI+1XP
         WKs699FCyqAULoN5xvvJ94c8PiLI99sfvU49oyiAwPN00TcWzDBTi5kbbT9FfK2yFRrr
         //M5IgUxxv+XCxlxyNAmVq21vr32l29339i+epSKDtBTsciIpW61AhVv8UQPLtcXi0PU
         yVZw==
X-Gm-Message-State: AOAM533qBhZ/4wMoiUv8+8tb+yoYV/slwG1ca3W+iN5GFNxt5UFOo6Qf
        bqCrPUvSjTrR1nDgFEs7O5C/tYDmMV4emYi5lszUMg==
X-Google-Smtp-Source: ABdhPJyxV6tmpOMHTLMY75W6shE10mUTU/dyte+lYBpSqtrj8pGMwdj+l0pm/fyrYvR0dk3dQeT5rP6xPdCqQoDuMO8=
X-Received: by 2002:aca:6747:: with SMTP id b7mr3921546oiy.110.1590704535541;
 Thu, 28 May 2020 15:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAEQQxWzHgiK6KHCE4kM4KepayNT5EihusKBmzaJLx6DkFDifBg@mail.gmail.com>
In-Reply-To: <CAEQQxWzHgiK6KHCE4kM4KepayNT5EihusKBmzaJLx6DkFDifBg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 28 May 2020 15:22:03 -0700
Message-ID: <CABBYNZJyADb1RNt4OBmY5EAR0cucrmL9jvuM9xmQDDs+ZrHY+g@mail.gmail.com>
Subject: Re: [BUG] bluez: impossible to start/stop discovery over dbus if the
 first discovery have failed
To:     Andrey Batyiev <batyiev@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrey,

On Tue, May 26, 2020 at 7:39 AM Andrey Batyiev <batyiev@gmail.com> wrote:
>
> Hello everyone,
>
> There is an interesting bug that causes StartDiscovery dbus method to
> permanently
> per connected dbus client. The root cause of it is incorrect
> processing of errors
> in src/adapter.c:start_discovery_complete function.
>
> Steps:
> 0. bluetooth adapter should be powered down
> 1. start bluetoothctl and issue 'power on'
> 2. in separate console issue 'hcitool inq' (or otherwise make adapter BUSY)
> 3. return back to bluetoothctl and issue 'scan on'
> 4. there would and error 'Failed to start discovery: org.bluez.Error.InProgress'
> 5. wait until 'hcitool inq' completes
> 6. issue 'scan on' again
> 7. there would be same error 'Failed to start discovery:
> org.bluez.Error.InProgress'
>
> Expected:
> 7. discovery should start
>
> My investigation:
> 1. in src/adapter.c:start_discovery, there is specific check with comment
> "Every client can only start one discovery"
> 2. src/adapter.c:start_discovery adds new client into 'adapter->discovery_list'
> 3. in src/adapter.c:start_discovery_complete, if 'status' is not
> MGMT_STATUS_SUCCESS,
> the 'btd_error_busy' is sent to client, but client is not removed from
> discovery_list
> 4. apparently, it leads to a situation where bluez thinks that client
> have started discovery,
> but adapter is not discovering
>
> Personally, I'm not sure how to fix this bug (should the client be
> removed from discovery_list on error?).
>
> Hope it helps to fix the bug.

Thanks for the bug reporting, we should indeed remove the client since
we are replying with an error to StartDiscovery, note though that the
use of hcitool inq in parallel is not recommended since as you
experience first hand it does impact the states on the MGMT.

-- 
Luiz Augusto von Dentz
