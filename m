Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3535BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 11:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B05623355
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 11:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgLGLHU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Dec 2020 06:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgLGLHU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Dec 2020 06:07:20 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41DEC0613D2
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Dec 2020 03:06:39 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id 81so12898436ioc.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Dec 2020 03:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=zRrX7aCVKckrEhsVVSAuzOv47ib0tmixlandcVm0HAk=;
        b=qmIrJGGudqDmexzbaEV8qoL3s+Iq58yVy3UOdD4S+k+8mj/lq3E8/vSZPSV0T9BF4B
         KBSfhl8LdgyBo+HKxl4wVlN8tEFxNB9tE9UacmyyZ0AKMa8GE2tJPwkFmQ4o3Hv7yzIY
         F62b3/9Hiu0u89ZvUkI26keRdfa/C3DORd+7U8iflYL+8rvPa4eWtZUXOJQjKFNbOwpu
         Nt7KM44iZoEey4/xcMP6bvnmvZwrAcd8ZUa9eh3LNilCepZi/xSIJu6pqNTy1pJH0C40
         lvDnOJgZ09Lo9/KcB/J442fHw0F19SE81N9jiRvBlwH0v2A0EUxxu0+P/CUS0PzXWDi/
         NCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=zRrX7aCVKckrEhsVVSAuzOv47ib0tmixlandcVm0HAk=;
        b=GOs7pu/opCjySwF7B39OiWoFbEUlTUSoY6CuJ06qaFxLZTIWAyQSde6yUshOw0+yay
         jfV00ZAAdODG7//anN6Qp1gBGCA2zQylcK3E4ig+K95hi7TP7XRpDOUoUeXbCwIwfze6
         UfdyOSfDYYCCSQsEtoQXVtgZdSlsDO38AGmyUrrVM/MF7JnAf5YaQSdToRzskLM47UEC
         pOMX5fon3juAlaXCX3QBUwMmakuk1kFhbJTHPss8TMFIHE78Wc8YedRuV4XmugBHVXCY
         JInWMWqRP7cMgjSvFJDHkSmhIyxwsRivb+UpN02RUH7EIEl2EKTtSM4fvUUHen6KJ7PN
         UOWg==
X-Gm-Message-State: AOAM530zOC+miWMvVdsMV+0q0eyKwGVovDvQ4vRLGTlS6oMsl/C7AVdx
        LZ1MtgzHfrbZfMM0l+dSArzvzhpYKBU=
X-Google-Smtp-Source: ABdhPJxWV6XI9JlPGeK9w2+7Gg6IFlo6MsKQwUofS9uNd6Gmm2xsMknQMhLrNxIxBCfsHqfDYALTBg==
X-Received: by 2002:a02:b607:: with SMTP id h7mr21734506jam.120.1607339198845;
        Mon, 07 Dec 2020 03:06:38 -0800 (PST)
Received: from [172.17.0.2] ([40.75.94.8])
        by smtp.gmail.com with ESMTPSA id b18sm3412548iln.46.2020.12.07.03.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 03:06:38 -0800 (PST)
Message-ID: <5fce0cbe.1c69fb81.6b5ce.909a@mx.google.com>
Date:   Mon, 07 Dec 2020 03:06:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7828059898481902584=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: RE: MAINTAINERS: Update Bluetooth entries
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201207100842.128579-1-marcel@holtmann.org>
References: <20201207100842.128579-1-marcel@holtmann.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7828059898481902584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=397463

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============7828059898481902584==--
