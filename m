Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CBCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 20:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiCYU02 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 16:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbiCYU01 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 16:26:27 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCCD6E4EE
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 13:24:53 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2e5e31c34bfso94628197b3.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 13:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKuY9OBajKOBUYRrR89zZjDuOWwWEuc3gAdN9zXO400=;
        b=SaZQbwha3sFFaqpZEUGq+YpbbnOiV3Fi2Q20dI/1pOXv5nNa/LU51JhRRsQewatCzI
         Ys9/AsznjTRB9yBHA44ksw6kSOUc0kwbsfEvVWBhsFhQULCylrnagtg4+ysVSkSiJify
         rAhCTs+OHGk4NM8Z8fnMVDU05BMpmhIXOQeDgN2RAvxtd5rg/ex6PoteJBY1pmmlQbyF
         LYefmehPLIRT9sLVlyTovBDkELXDl1heUNb5zhcT+d/p2VARtUfMi2Ik1e/wRFwkBScl
         1tpIao74a/2Uo5jqzRcUXMSpJfbnOVhKgN23PKHXR8PCBlzDHrLLnIqiZIFbgSd6hDvd
         c9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKuY9OBajKOBUYRrR89zZjDuOWwWEuc3gAdN9zXO400=;
        b=KAeZ2aQFp6+VqIWMdkThwuhgZqHFlezFDI2x/WlnyWxbduTkz290hHDVT5DfXQDdBE
         KNe1jMQtPqOVwrs2jIMJsE+1g/mBFhwNUmZDpF7nj1X1KKMo7RyAVvhm5fpKIYRgSmfT
         3vP5bG0UVEJ6ciPxGlsBP3Z98yklmpCXq89NHVdfpWwzm8sW1UQ0hC/sPaH6J0gH6arZ
         Ur4kCGwdE5FiOfAcgCY9xS2i6UscOOAw5w9Ibv7wqGN+6AM5hJBkfLUgOcjC1oBUTzLQ
         gz8pgrDiBNL8vGtFcrDAtQjNodoS09ma0z/YpSh2ReOAsvz0mqjkQIYdWhBbA1u5TKPC
         9VAQ==
X-Gm-Message-State: AOAM532loJ87fcdks7yucEaCi8wAqTmVhFiz+SU5vw8JZQ6cEIFOSXo8
        KMwXQIgafFGnUGvLvAg0wqu/khOO3uwunETzsly9noVo
X-Google-Smtp-Source: ABdhPJzCvBDxGAJUUcsB6BOl7F0W+QaLossT/014MawQ8sN0xErihpOmU0BBuM2aj/VWlXj7aY4p4YyLVihUdUp09Hk=
X-Received: by 2002:a81:784e:0:b0:2e6:852b:c68 with SMTP id
 t75-20020a81784e000000b002e6852b0c68mr12926497ywc.317.1648239892290; Fri, 25
 Mar 2022 13:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220325181617.332701-1-luiz.dentz@gmail.com> <623e1b1c.1c69fb81.3c792.0ff0@mx.google.com>
In-Reply-To: <623e1b1c.1c69fb81.3c792.0ff0@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 25 Mar 2022 13:24:41 -0700
Message-ID: <CABBYNZKgQ1OcOpZ2ug1m7EPNMUShn-fntQvR=1JF_gZ6U_NE0w@mail.gmail.com>
Subject: Re: [BlueZ] mgmt: Remove mgmt_set_verbose
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, Mar 25, 2022 at 12:42 PM <bluez.test.bot@gmail.com> wrote:
>
> This is an automated email and please do not reply to this email.
>
> Dear Submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.
>
> ----- Output -----
> error: patch failed: src/shared/mgmt.c:50
> error: src/shared/mgmt.c: patch does not apply
> error: patch failed: src/shared/mgmt.h:28
> error: src/shared/mgmt.h: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
>
>
> Please resolve the issue and submit the patches again.

Looks like CI tree is outdated.

-- 
Luiz Augusto von Dentz
