Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1483C38A2A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 19:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47D820CC7
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 19:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uk12o/nZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgEGT6B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 15:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726326AbgEGT6B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 15:58:01 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C6EC05BD43
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2020 12:58:00 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j14so5553707lfg.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2020 12:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=LZSYhADvuHRpifEOF7gLKSCh8M2H3hPlTou5Ev9J84Y=;
        b=uk12o/nZDv9iQtDfuXIgVhYuY50GYnJQRBQ+vh8U+L0iWC3I0RykJeqs6zNxRRxGMY
         YvfbgIuNgpDqo8jFXQ57gvmG6nL/AUzb1NEY8aym0PVB2fY9cppAyIRUG9Txa5TUNs3S
         FUpHzA9o9D5bkvYL6OYbN1SVHlxRmdghZuyGUmvPXP/b9xMlOeP70+9Oa8DXXL7JS0bm
         avmrK8CyBH5k6yQ5BP3o9lPjJEJg0hF2utA7BAmkjoIl3vFDT2JvkMGOMm1TOuhapNaJ
         Z7K3apEM8E34ZPwSXPoRCTJcMBOWnK4m+fxAQ3Z9UPBiKHjeUSCwr5a+xqwrh5VwuZQ7
         xmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=LZSYhADvuHRpifEOF7gLKSCh8M2H3hPlTou5Ev9J84Y=;
        b=prM6g6DFWBN450dk4w9qx4F4NGfIb10VregOji81q2v+8YDyaVBz9sd88/i8J5TMAp
         p82sEH4Do9OGu6jXkzh1yEDcvL691ZkgJkaS583CaKPUyUgty1DYOC1rzFQHKOdUCR14
         4NH+dF6qf6lDINNLTZP61tfnat60i9UQSBNHasTof89hADP1iXPNoRaSCT4zIy0yGxal
         k43TfhDXVfUgGGKnSLMP9kRLXQSwfskACrasIFVCFCV56fU1elBlihBw8BvPRCQ1brZ4
         iE+zx9a7Q6pXjs7fdYKwFWV+oOWTyorOE5p6Xyq77ZiWiVhoMmk6UW0vS2oL9WjkXXu+
         P1hw==
X-Gm-Message-State: AGi0PuZUkhjTKMqjS983bG9JJTf0zhP7qthK6sC1+XxffdcLdQCJ1PsD
        6WCC5SLSPXjszf18eqO1GpTY4i8toJzQVpAt6Yum+veI
X-Google-Smtp-Source: APiQypKx3jkGp8HUAGrH/PM2cSnOjfShNkcEqKnxyBElQmdlMgQye+o9Aic9PhDHloCcbEE34d2TZT9hROP06Wfwz3w=
X-Received: by 2002:a19:c85:: with SMTP id 127mr9389295lfm.189.1588881478310;
 Thu, 07 May 2020 12:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <3057615.CFlnn7pYAm@g550jk>
In-Reply-To: <3057615.CFlnn7pYAm@g550jk>
From:   Barry Byford <31baz66@gmail.com>
Date:   Thu, 7 May 2020 20:57:46 +0100
Message-ID: <CAAu3APZoiMyJysKGdK79Ofa67MnWGhu05LNtak-VP+DA1EJOpg@mail.gmail.com>
Subject: Re: ManufacturerData while discovering
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 7 May 2020 at 20:28, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Hello,
> I've been trying to get frequent manufacturer data from advertisements from a
> BLE device into an application of mine. Unfortunately it looks like I only get
> new ManufacturerData about every 15 seconds while discovering/scanning. The
> manufacturer data from the device changes frequently (at least once per
> second) so I need updates to this data more frequently than the 15 seconds.
>
> I couldn't find any reference on how I could achieve this in the documentation
> so any help would be welcome.
>
> Regards
> Luca
>
>
