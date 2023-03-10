Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6F2C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 09:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCJJmf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 04:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCJJmO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 04:42:14 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208FAFAEE9;
        Fri, 10 Mar 2023 01:41:42 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id k10so17941534edk.13;
        Fri, 10 Mar 2023 01:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678441300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=70s013/dgDQt9Hd+q0XNfufjQBVoZkl0Jr00dHEDQc0=;
        b=CNOQ4ilSrUMZ33NsFPGzmze1c+zg2tDxYaWD2JYyHbHbP8zyfMlCog7bIagZl5egXZ
         s4co2jGPI5S1x2CHDcEAOVTmfu6ND3ygBCdVcEHbI1Vis3KO+afxkMZ7QuJYSe4vIydB
         lKrFHTKDbVf2s4BI4mz5LN8x/5d7mWUl06+UjWt7ZPiPiIJzbD7RCNVC2jmUUiQsizt9
         ADBOFa2w9qrv5PJ+G2KRmP8IBs2ZAvhqomHypCvLBnoKs+RiKWpA0pqMEbUoSnZtwwIf
         9eAdyZ/wPw6v20hPvQSFxQCcwVUkzplXu3M0R2tEFSXNr/o90c3vqApsGfZCon+aqvse
         qCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678441300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70s013/dgDQt9Hd+q0XNfufjQBVoZkl0Jr00dHEDQc0=;
        b=KSr2AtZeomKpfxBgIaze+qFkXvK5btR2aSqiRUjvvwz9RzJsGUXtBwTulIr5DE/dOV
         1QA4qqXiGxkwMR/bBYLEs/y7ES6B29eaxlB73YSZlsFiP7NYVcV4PDQpPUpxGJiC81UX
         kiLykSzkFeY+9WdaRncLewwXmAzqzNGifS2pVQLkNTMWLvvZV+zgc738eZ1Oq63x7hpU
         uFS+w56UbMxO7eYcPRJTH+uLmeanDs+pyqkocWXsRZhOit3IBwgkLnuEya3E2YHif2Un
         hD7Dw0a3+L20F3wT0iNPiwCIaV8pQDQbdVYoxIJyI+VppjK8jSpUIieCTI1MfXWk6QFp
         A5qg==
X-Gm-Message-State: AO0yUKVcAjgo7XsLdEWP34lIv1UIJJKTSVeIkpDRJwaK2DHidQMmMcKB
        RgzbMx++XVzEwM7Gdnm51DIiZqJej7kRZ5kaWNw=
X-Google-Smtp-Source: AK7set8oFzojnyc0nMewgFeFCqKlKX1jTXihG7AGJrPnOHK4nsBLCYfa9PnLzoVR3Yx/V/zE3IBF6oE0ur5E4jzjXnw=
X-Received: by 2002:a17:906:40b:b0:8b1:2916:9804 with SMTP id
 d11-20020a170906040b00b008b129169804mr12748877eja.9.1678441299970; Fri, 10
 Mar 2023 01:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20230224-btbcm-wtf-v1-1-d2dbd7ca7ae4@gmail.com> <ZArmD064NVhNS96C@kroah.com>
In-Reply-To: <ZArmD064NVhNS96C@kroah.com>
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
Date:   Fri, 10 Mar 2023 10:41:28 +0100
Message-ID: <CAMT+MTT1RE2M0Fn3k+EXO=WNgAvNGPGHpidpTp0Jdus61M5UPw@mail.gmail.com>
Subject: Re: [PATCH RESEND] bluetooth: btbcm: Fix logic error in forming the
 board name.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>
Sorry about that, let's just skip the stable tree part for now then.
