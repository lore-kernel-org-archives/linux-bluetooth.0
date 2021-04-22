Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71144C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Apr 2021 04:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D1596142B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Apr 2021 04:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhDVENw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Apr 2021 00:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbhDVELt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Apr 2021 00:11:49 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC73EC06138D
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Apr 2021 21:11:02 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id i4so12249895ybe.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Apr 2021 21:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZuDgbG3oSi5c8wYBhfvkdOyrAKhDomOIx7YS6WV9Fs=;
        b=uamoPolJZJ0Ztijlnl3MpAx6vmndRhEU2UkPpR7gQ+B9K0z6jReIuhnvdWw70ezrML
         PKJtpI0ooCsGdqWAj0HgLzD4jriWv2B/pw2/l/trvvK5nn4KivCCZMkKXaJxJvjUYKTk
         II05GqYmi+i5peIfgVjHiWpE05ofVS8gx2VQPlGIIDGYmJJYnz/Fy/0j9WiTtCKBT0hz
         aRSwtoxMRigH0bsNjuE7Wh/698Os04bg5Uk1JXXDOJwEy4zi/d+WDuTS5Q4tS7pLwFmO
         SiM5TIAVg/nCd8OGOvooK+aI65surkGORCNzUJP9/YhrAAqZ7CHDBFMzNuWsmAz13Hhe
         NMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZuDgbG3oSi5c8wYBhfvkdOyrAKhDomOIx7YS6WV9Fs=;
        b=RctytwdIbZ5AjcJYM8SU9cCjqMYIRuT53iiqR3jkWw9MmIn+Op41hZuX9vX1/ZVgrE
         +iRDatjirwKXECFk10qJgrsuckJ68r23UCDNVQ5DAeLcbphcR3mbnYz/5hXBDyNi1Quf
         jB0ZA29glchAoYqR+QHEm0V3x337A81KfFv1/vOplZDNySogVrXpIfroyK0FhErNMxPC
         +OntGJTSF3PC4IaCcy1u9BOZqAcAlqQnvhbC74n1eRz4awvvU2Mx4wanH/EBNqGRqC4+
         0fiZQ/Z6b0zxdo/uxn79aA+TAVbocti8bbNuZ0rMoZ6l7wpT5JEmXAy1rXZH0IOCe9Ts
         Sn3w==
X-Gm-Message-State: AOAM531PFutW+7mjfVYqnD+hOsn54KRzXobt2cjtXiq5kCYJUV7PahP+
        OQzoKiW3xw6UkwML/0b5VaH0+bhQneIcCTwrmyAH1qqbmxM=
X-Google-Smtp-Source: ABdhPJxKs2SmCHRIphoP13YMZEO9+mzvpYf1dF2GVcDa92TnOk0tB8h9VG40ezDVXGRlz1ZildsrWCMMbEiK62CISAc=
X-Received: by 2002:a25:ba87:: with SMTP id s7mr1968362ybg.222.1619064662038;
 Wed, 21 Apr 2021 21:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210421202408.itigrlc2cltwu4sv@gonzo.waveform.org.uk>
In-Reply-To: <20210421202408.itigrlc2cltwu4sv@gonzo.waveform.org.uk>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 21 Apr 2021 21:10:51 -0700
Message-ID: <CABBYNZJN4t2F37rrmb2TfdeyYdpv8q4K02SXXNEgY_Y9tONWKQ@mail.gmail.com>
Subject: Re: Archived raspi compatibility patchset
To:     Dave Jones <dave.jones@canonical.com>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dave,

On Wed, Apr 21, 2021 at 6:23 PM Dave Jones <dave.jones@canonical.com> wrote:
>
> Hi,
>
> I've just noticed the patchset [1] I submitted a while back for
> compatibility with the bt modules on Raspberry Pi boards was archived,
> and was wondering if I'd missed some procedure to follow in getting it
> reviewed? My apologies if I've jumped the gun on something!
>
> I'm happy to either rebase and re-submit (though looking at the current
> master I think they'd probably apply cleanly still), or unarchive them
> on patchwork (if that's an acceptable alternative)?
>
> [1]:
> https://patchwork.kernel.org/project/bluetooth/cover/20201218190609.107898-1-dave.jones@canonical.com/

My bad I probably forgot to reply, hciattach was deprecated in favor
of btattach so please port the changes to btattach whenever possible
and re-submit them.

> Thanks,
>
> Dave Jones.



-- 
Luiz Augusto von Dentz
