Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300D0C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 19:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiI2TBv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiI2TBj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 15:01:39 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52894F67B
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:01:38 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r20so1357552qtn.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=SA6DG3YxJJiz9YnftgJz+NEyB+YY6IKr1FvBwE65OI0=;
        b=eO/ktn48IJ8+553M13WV9gqKzMxL/qdELOCyKSXOiBrVYPJvnhKL+WmhXsa01qKZ0a
         axy21hZPrCD+tJJ+BHuPXDmKA+DmpfiZFhOWQgVyz7JEUxGNKpos613k9a2z7FmglXZB
         2YQ+NAZSxNYfZyOSDqeocQnR7elCM7OjyXTpU3TGbLyq6fpaUn1U0sBVgTgf1YYR3QIl
         IWwrgwPPX+mgIpz+tlZUMq0lT5q0z0icKvUD7LmNkbdZn/zBzMJ8VBa168/lV20rh5E4
         2n+0zUTyO+sj0gwzmnYw97sxa2u22W/OKQfiWaKuB+QN9sqb+Qmy+TJFkU6XtlXUKcbo
         8AjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=SA6DG3YxJJiz9YnftgJz+NEyB+YY6IKr1FvBwE65OI0=;
        b=YYdagtsacRqO7ZpSgMS2mGq9eUoBk7q2qceoqrzYjJt9jG4X7oHCDhEG+jhQYl8W2s
         Y0XlwJtbqLauZkIhiBLB7Tgk45abIsczzIK0zmfSkuISRIv5SInvjGAZ80dO8Q73ub/a
         AfCmTHT/lBe+u1piPgh5RwKgS+YPPSTNltKNDhEuD1LNHW5MihOGQNLQN5tP2l2xUJjC
         vizvei80PaBycpeiQxsAq/W278lvSQmCPlc0vw8ltBXzWE2AGeRIcaUO/xt+d6C0IIWg
         mSPe9EZSmDrk+6yDw1Rd/mE8EHGylQOvISO0OlqUHqoLGk+tRGqNIk1RuW1mmSJsZhPZ
         64oQ==
X-Gm-Message-State: ACrzQf2tbb9knc9QePHAkU/cff2SRe8BkkA/AOA3jj6ZjGSr5VZ+x8z8
        sjkDFzBlJIF5muSwiNnJOw3F0Hna4EtbqQ==
X-Google-Smtp-Source: AMsMyM7KsKcEWU9sRKlJqwIVdlTbyM2Q7T1lfm3rClRoeUiYE51GtAMunfO7KkaM7LQx0TZEz5uZeQ==
X-Received: by 2002:a05:622a:11c9:b0:35c:3a5a:1ca3 with SMTP id n9-20020a05622a11c900b0035c3a5a1ca3mr3792235qtk.476.1664478097507;
        Thu, 29 Sep 2022 12:01:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.14.151.55])
        by smtp.gmail.com with ESMTPSA id cq15-20020a05622a424f00b0035cdd7a42d0sm15793qtb.22.2022.09.29.12.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:01:37 -0700 (PDT)
Message-ID: <6335eb91.050a0220.2c332.00ae@mx.google.com>
Date:   Thu, 29 Sep 2022 12:01:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5944518086998133774=="
MIME-Version: 1.0
Subject: RE: plugins: Do not try to autopair with Nissan Connect devices
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, florian@ubports.com
In-Reply-To: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
References: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5944518086998133774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: plugins/autopair.c:66
error: plugins/autopair.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5944518086998133774==--
