Return-Path: <SRS0=a/5L=X5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B980FC4360C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Oct 2019 10:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B80C20867
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Oct 2019 10:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=noa-labs.com header.i=@noa-labs.com header.b="QMXKQjlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfJDKx7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:53:59 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:38115 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJDKx7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Oct 2019 06:53:59 -0400
Received: by mail-io1-f54.google.com with SMTP id u8so12543314iom.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Oct 2019 03:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noa-labs.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=T3D5IEVYupP5VelLCuQbA9qexKufNuKLYU9P2+Olsyc=;
        b=QMXKQjlfLuq1Kbvb4+fb/q+SVoFvFMxpbeUhcoXkG6Xb8VYCo3WFjyl7fDl6sxdZZK
         bve+LyJUjF9YKT9aYHAQ3LJiayC0hln3keqYozw3naR0jgZjlTf2spoFjaAMU+ARcYc3
         Mfjfc4ZpDaG9M/v9L6TA3IdMI9pGZgPVqoBuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=T3D5IEVYupP5VelLCuQbA9qexKufNuKLYU9P2+Olsyc=;
        b=QOPuq5D3rZED6NLhhZdDv86+ilj2N0m+miT0nwJLjphbgUJ5H2EAm/7cioeocQVZpP
         Fsegguuhu3O7tCh/TUap1nsnwWyF190E9ZT2E2HIQ+ldhK/jw8/59CGa9n3kn0CwOe2F
         kwotND3cAUk+ZebS7O3u9LKUyhVOWi3x5HLHr/5g6HPvFb0xWJAkESDJ9QV9BJZe7GWs
         dnYCnKEaL+FSTQmxga+zDe1TKrZJzCNdXMhMZhY69UjsT6JaAfo28YA2EMrigT1WEU2t
         iM1uRe8lb4j1ZNfiwK8sf42hGtrAHlMFTAxR/d+HjZxOxt2CcyHqcXfR3I41AhwVvRR/
         DZdw==
X-Gm-Message-State: APjAAAWIPQ4zkqucovZoLV5frftzenZpD8x6VLxHzR1vVyO2oU/DPCaE
        6wOVKRvlRan3JMIp5t2Ae0CcTIGftCF/pNYiA4w9XwLLy/GlEi2F
X-Google-Smtp-Source: APXvYqy+Hdwv0Hh6dQUnj0fvM/V7/0NAW5FUPf3X8LDnEwC+hyIINfkC6qWLdr7BmUeiBf9G5FvjP2SDuS1vlaECFOg=
X-Received: by 2002:a6b:fe09:: with SMTP id x9mr7123471ioh.144.1570186438637;
 Fri, 04 Oct 2019 03:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAG-pW8Gjp=adimXCkKEgZPvUkRV51zb1CwZaw6FrjVxOUwQdmQ@mail.gmail.com>
 <CAG-pW8GvMEcKmdquREi1ruDBHLYmgsVjk34NTmYgsmvmx5cX-w@mail.gmail.com>
In-Reply-To: <CAG-pW8GvMEcKmdquREi1ruDBHLYmgsVjk34NTmYgsmvmx5cX-w@mail.gmail.com>
From:   Pavel Nikulin <pavel@noa-labs.com>
Date:   Fri, 4 Oct 2019 16:53:51 +0600
Message-ID: <CAG-pW8EZjnd7dX9P2TdFHPSf9p3qEm+s+sfZuKCDssP2yjqhDw@mail.gmail.com>
Subject: Re: Battery readouts on dbus for GATT battery service
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Decoded text https://pastebin.com/NNdvbBNA

On Fri, Oct 4, 2019 at 2:49 PM Pavel Nikulin <pavel@noa-labs.com> wrote:
>
> Hello,
>
> Here is the BTMON capture
>
> http://s000.tinyupload.com/index.php?file_id=97528277907598647906
