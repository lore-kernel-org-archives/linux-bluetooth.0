Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDABC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jan 2022 20:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbiA0Ugr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jan 2022 15:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiA0Ugr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jan 2022 15:36:47 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40A9C061714
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 12:36:46 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id g14so12244241ybs.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 12:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DSxcO9r4Qi94JuqSuyvCOroTPG4wxHRc4ag65LKGq4=;
        b=VkBRYtVau7VhabK/7SX49pifZOhqBIFKTuTOgipfUQtJM9B+38V//L2J3JgBhfsfSg
         JMVLSALDFGIuHu/dZmfa5zb2m06CWu/U1rqryHsWDXe8e0KocIw00KEjSRPzNfzN2LJv
         yfZFtmvalapwXtBsTKkM6ugNtmQBgeyAaSt6DYGtmxNP2U0az5GkWww+L7KOdy7jrX69
         5UpO2Yqf5DuMRWz3QuTxiy86rMjJFOFXXzDR4V1qA1UJrdCSvDPOeWzKOP7VN+NyG9BP
         Cyv26cZOLF6H0Qd1Xq3SQgtVcNgzzSHlI/cdhFmyAz1QHRMAb7xx8aVTdseDb3qgs7a9
         Drmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DSxcO9r4Qi94JuqSuyvCOroTPG4wxHRc4ag65LKGq4=;
        b=u7vhGElERaBLARJTxWwiGGB19aQVpktWSQUAydvBpz+dp8/sehL0C08PcGwVVQumiy
         +xp3dt3VX8qCytz1tDTjK1A6M/wziFpR7yPXr4fxSbS82dVSkMm6y6BJzoV9wDk8SXTF
         VXSEz/9rxPesDboavi+Zr8Cz1lXzGteLmHVg7Ij9wv05FrpGcHPbX5WjhVBNPWYbw+aE
         vh+aQoPpWhgFpeYUQOQH+VpNaCOjluQm9A4rPCRrmWlZCKxyM8jTSNtiXRw4wRUX2X3g
         8mShbOA9PRI/CfXE2m+9h3spIXlRK9O7+v01rxuachpuGYccwN5slYPwKW5BrDL+lTt9
         SpeQ==
X-Gm-Message-State: AOAM530A2F5WZMo9d6xmn/iI5ctMd6uY2xAKZlLZMri9HFe/8VoIN10C
        JXr5dEJKPgKE6/kjqtcezSEgxgrFXpR9b5wDITv3emlmLdE=
X-Google-Smtp-Source: ABdhPJwKDapy5A9ICUYRVtXEszphvJrMrpnlZIWrCI7FmCwQACdbmnrRzRkBd0sU7R3RCEfhl2LUN6WE5HeThxeynmQ=
X-Received: by 2002:a05:6902:725:: with SMTP id l5mr7899230ybt.351.1643315805744;
 Thu, 27 Jan 2022 12:36:45 -0800 (PST)
MIME-Version: 1.0
References: <20220126173012.81238-1-marcel@holtmann.org> <61f18c6e.1c69fb81.5c7e0.5432@mx.google.com>
In-Reply-To: <61f18c6e.1c69fb81.5c7e0.5432@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Jan 2022 12:36:35 -0800
Message-ID: <CABBYNZKfyjD_3wFbzBp8-6Gy84WReNAorG+oX+wwPWgGN+1w-Q@mail.gmail.com>
Subject: Re: Bluetooth: Increment management interface revision
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Jan 26, 2022 at 2:26 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=608717
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.57 seconds
> GitLint                       PASS      0.99 seconds
> SubjectPrefix                 PASS      0.83 seconds
> BuildKernel                   PASS      27.93 seconds
> BuildKernel32                 PASS      24.44 seconds
> Incremental Build with patchesPASS      35.92 seconds
> TestRunner: Setup             PASS      422.60 seconds
> TestRunner: l2cap-tester      PASS      12.37 seconds
> TestRunner: bnep-tester       PASS      5.54 seconds
> TestRunner: mgmt-tester       PASS      96.92 seconds
> TestRunner: rfcomm-tester     PASS      6.75 seconds
> TestRunner: sco-tester        PASS      6.93 seconds
> TestRunner: smp-tester        PASS      6.92 seconds
> TestRunner: userchan-tester   PASS      5.78 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
