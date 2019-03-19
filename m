Return-Path: <SRS0=3ySR=RW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD20C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 02:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E6320828
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 02:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7jCwQCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfCSCfc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:35:32 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42181 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCSCfc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Mar 2019 22:35:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id b74so10964409qkg.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2019 19:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqXfWNSdabibSi3zXPY15t/6Ee5rIqhW+i5NnYtrDJc=;
        b=c7jCwQCL89IJXg8jFS2uwu4viDTCxaoBVjOfjlMVxORTCJp5NXpcSAgr6di7vUwPty
         Fnesa46MxHtEiy7+yjiwBasf30Rn87IpDnWXV82lcaZCcdSo4LjjW4yB36cpV2xbprkt
         cMvOFwoE5KZl2FOTOs2T4M3aNeEEGpYMKVKf+Pg4u6HF4AdhMkcoxcVI47N2ISZ60NYS
         4zNnIcfuTeIW+96KXUWRwHmWUeFb6jjynDosp68OIrb0AGdkdGqWzi56nuOFP91Up6DN
         7Td2pZNDzAB6XWi/6gA6mPrgQ7zsZgA+rUfphYzn7uiomlldXWWSuf87tD6zVCzn001g
         RAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqXfWNSdabibSi3zXPY15t/6Ee5rIqhW+i5NnYtrDJc=;
        b=ACn/CoimePSbb14hENSynzRolQSn/7DsWSF+kXPmQDjEUYIzwpx2MKvsj5ZWJSvMZm
         7Gg/u+7A/yE56rCbhtUkNxNKEF5+nQ0i8BSiJp6Hyw2DWDIZJxI6zCGUKRK784VuoOzH
         Hf4evLQJVlxm4R6gxxbcwu7nWN4kZmhTLpQ+h9moTccpOezAV2Fene2aybH1eBQwk5Bk
         jhP/xvohrBld0BCViJWnyFJ50wF19JbqjsHT33vOiDe1Zi55bHsnRVJwKpnesNuQH8V9
         gsaDN0BxINgrrrSmAdLupujHMA5dDb4KbEXO4ZD4LPXlfgMSmRtzXyO5mrd1dArbZzSi
         A4dw==
X-Gm-Message-State: APjAAAUQZJlQSboqzTeLcKLK4CbUdx9XHk04+nb1fKdlxBfzi9Gn6xrN
        zcsYW5s8OFcg0fFKIPYrErRbdiUManBXmc/Sx7A+vA==
X-Google-Smtp-Source: APXvYqxPSI5atp6OBEqwqup/ODSU0CG9uaN3v3uHzC2uV8RvTZjBx3+tsmk1efrFZsAClsYU9GCrykNTdur84FsOsu8=
X-Received: by 2002:a05:620a:109b:: with SMTP id g27mr83163qkk.128.1552962931657;
 Mon, 18 Mar 2019 19:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190306162113.8585-1-bgodavar@codeaurora.org>
 <155191158734.20095.15990837191526416248@swboyd.mtv.corp.google.com>
 <a22894cea091ee9945af9c22d6e42051@codeaurora.org> <82fdfbd3dc4dbc1b6258dd470afff589@codeaurora.org>
 <CANMq1KDrGYTrYi1UxyfM2ZMw_GmFpFrrTC6acZkKRHtizAT8OA@mail.gmail.com>
In-Reply-To: <CANMq1KDrGYTrYi1UxyfM2ZMw_GmFpFrrTC6acZkKRHtizAT8OA@mail.gmail.com>
From:   Claire Chang <tientzu@google.com>
Date:   Tue, 19 Mar 2019 10:35:20 +0800
Message-ID: <CALiNf2_ivxxhox2R6trANOoiH+Xfoi3AGjSRSUWdu5961xKKtw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Give enough time to ROME
 controller to bootup.
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     rjliao@codeaurora.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, johan.hedberg@gmail.com,
        marcel@holtmann.org, Matthias Kaehlcke <mka@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Claire Chang <tientzu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> > >>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Tested-by: Claire Chang <tientzu@chromium.org>
