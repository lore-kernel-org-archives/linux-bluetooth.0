Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A61C636CC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 02:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjBACje (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Jan 2023 21:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjBACjd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Jan 2023 21:39:33 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D95F4ABF6
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 18:39:32 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id y25so27162377lfa.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 18:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=matician-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap3Lc51bsx1q36vE4wSazR2PmZFf0he7F6ZwCbI9w8U=;
        b=zeqoSuByf/XFo4DWNh3Jdqkj6zmBsfrxHNI2NBIn8/oTknNVbPcO13ZugnDV+f2tu7
         3mWDaNWwacxDc5pi2dAtrZQZWYcgjQMRNc7baVGiqr8PQtPyM2n5CkiIZ2JWC1xEvbwq
         KV04q045CngSzrXTmIWN2i0HUA9ZNP27Rq9kU28+4GK1ZHzejBjFRwWhoqjcPegKG359
         p0gW6Td0tKVezqapOEt3aLH2jgg0j6IM7qtGvmoazWZ/lnRJpka7NesbHr+3v9kC19ry
         4kj4ygZUkm9wwD1X8wJ0CMFu1vlhAsMW/DNONertZTdIJ01hbXipNhYs2/OoKUY1GFha
         0smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ap3Lc51bsx1q36vE4wSazR2PmZFf0he7F6ZwCbI9w8U=;
        b=LsNHG0P/jmB+dG0k/U6iVRs0mM0v5pwYHNYN6WSoQCdHgB7mCt/VdRO4TsDzn1+Q8Y
         o9wrU1QKmqVIyllh4mXpMGbXQVgdeNs/BApEwbJMCLRlJTsA7bRNHZvqetoXPL5qyb7g
         oyHjUr6X+N4GJpRIocUcyjuMvL7lLhRzDJv6USaUaNRoiTAenH6ddc9sgygEwSYJuVb8
         r6DWcH4e9dM3ANZCu6dwY09P3KQJmMpHx8q+KLl7iipmPkdRd4sKq5V3i6wuzseFBeRV
         FLpo3zT8whIZci2F8XHV303Gu1X/qNLSUBSEYfmh4T/7fS5qjkSw46WLtHRmTjEYegvo
         hqRw==
X-Gm-Message-State: AO0yUKVu06UgSm/D9GYjkYN8o8/CMwlxo8qWt5SU+KIgw9ITclzdEwd2
        w/Xo9eVYqwcw1pXS4wMqzZEjVetxlEauuOTRi7JLxA==
X-Google-Smtp-Source: AK7set+xQZPtIDdtcmpRlO34w1ZoCsDW0ood116WFdvqacM/dMg6Rar8puPxy7chKaZAXBYHVIG3fGffV2rl5hZAFY8=
X-Received: by 2002:a05:6512:2399:b0:4cb:34b5:3196 with SMTP id
 c25-20020a056512239900b004cb34b53196mr79407lfv.240.1675219170230; Tue, 31 Jan
 2023 18:39:30 -0800 (PST)
MIME-Version: 1.0
References: <20230131230105.139035-1-alex.coffin@matician.com> <CABBYNZ+wXYH8vag6Xk2X7U7U096_YENasq1cPCEo-0SD5ut_wA@mail.gmail.com>
In-Reply-To: <CABBYNZ+wXYH8vag6Xk2X7U7U096_YENasq1cPCEo-0SD5ut_wA@mail.gmail.com>
From:   Alexander Coffin <alex.coffin@matician.com>
Date:   Tue, 31 Jan 2023 18:39:14 -0800
Message-ID: <CA+hUFcszm1UnoqeEsViR=0NO4M=rQMu-2DvaefJ70HDNR_9dtg@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: fix use-after-delete
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I like your proposed patch, and think it is much better (and what
should be used instead of mine) assuming that you have tested, and
verified that no code requires allocating buffers on a closed channel.

Regards,
Alexander Coffin
