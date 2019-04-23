Return-Path: <SRS0=r7wX=SZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF33DC282DD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 12:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B303204EC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 12:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="lWKXK8TA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfDWMfv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:35:51 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:43251 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWMfu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Apr 2019 08:35:50 -0400
Received: by mail-lj1-f181.google.com with SMTP id f18so13327208lja.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2019 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fFilGsqDa2DIUB/tu6IfzCPI6R/hAZp1KW+w4YQehEQ=;
        b=lWKXK8TAq+bbYoquSH57bAKJfK6SQVFkluWGhfjMelyCJPRnqkhEdDVoZYLycOYbXQ
         ZJS5Rn3lkiljoKR/+ziC+ZthrfeBH3lFFfm33xivBOtNhTowgRtwdVHr7bEO1pR7tUfg
         hPBEge6J5FmceUtvUfmrbRcoUOIK34hiGkdXCNX/9Pil756tEOhnE1KjpqA7UYAtTj3/
         l5QDXswgECeElZzx686kyytxAyhxDa6ELR7/iDxDdiJKX8lnLBB6lt3yWtFcp8nN690q
         gfxMbwo0Yry93YBDq+JumEPKd5ZW/AYbPowzia2Mmfug9T82tgYDCJZPAnIo3AQHSkvo
         cU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fFilGsqDa2DIUB/tu6IfzCPI6R/hAZp1KW+w4YQehEQ=;
        b=BDlV3wLyJTq1WMso7740vV6ydW2pUSKXEWQMYN8IJauVR70MeRZZ1hgKBeetaCQxAG
         GIpCeIQLB6565yOrOHBHeu1vy154Rp0LnlEhcaMul6bTYchhx/YdxGS+0ok5NHXB/HnW
         fgIvlJ075kkQebE6//DWotBqWfh7AVR/SN3sFqB711DSEGE5d2ejJN2/u51/blwBnLDR
         ObQUmrL3SOy0gOxx4Lc3iF0h5NYYzk8dllQ+gJr/bGWme5u8/v4I779yLSN59LkZHOlo
         WqvUnizp8L7GGOzHVjqxL4kBBUNxFz8Uv044YOMAwQb5qQp/aTNe2TTHbKMZpa+LOVB1
         O9Sw==
X-Gm-Message-State: APjAAAU4PIOI69PoUZ4X9vQ1z34Deqg9vC2lGNUy4l3NJ8JtlVuTM9g8
        rwZNynJTlE46lHjpmgOATrz4o+60E2E=
X-Google-Smtp-Source: APXvYqygcW7w3ovGnBkVjQKcNCI2VPeotbEjR7ONaMzOKUA/HckCk3vAPjPaY88D5AXlrJZLEdJHHw==
X-Received: by 2002:a2e:8550:: with SMTP id u16mr13533038ljj.11.1556022948054;
        Tue, 23 Apr 2019 05:35:48 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id z206sm3703394lfa.53.2019.04.23.05.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 05:35:47 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] build: Bump glib dependency to 2.32
Date:   Tue, 23 Apr 2019 14:35:45 +0200
Message-ID: <1915942.yPAXW0zZuX@ix>
Organization: CODECOUP
In-Reply-To: <CABBYNZKM4jFa=e=A3PWmvtJpQznW3rLJ172eU7GBW6ekZd2u1Q@mail.gmail.com>
References: <20190419105146.29272-1-szymon.janc@codecoup.pl> <CABBYNZKM4jFa=e=A3PWmvtJpQznW3rLJ172eU7GBW6ekZd2u1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Saturday, 20 April 2019 08:48:10 CEST Luiz Augusto von Dentz wrote:
> Hi Szymon,
> 
> On Fri, Apr 19, 2019 at 10:48 PM Szymon Janc <szymon.janc@codecoup.pl> 
wrote:
> > make --no-print-directory all-am
> > 
> >   CC       client/main.o
> > 
> > In file included from /usr/include/glib-2.0/glib/gasyncqueue.h:32,
> > 
> >                  from /usr/include/glib-2.0/glib.h:32,
> 
> >                  from client/main.c:36:
> Weird it seems to be triggering the use of a deprecated API on its
> own? That would be a bug in glib, also weird it did not trigger to
> other tools only for client.

Yes, this looks like bug in glib but unfortunatelly that is the version 
shipped with Ubuntu 19.04...

It triggers for other files too, this is just first in line in case of single 
thread build.

-- 
pozdrawiam
Szymon Janc


