Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A14E748E9
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Oct 2023 08:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjJAIOy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Oct 2023 04:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbjJAIOy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Oct 2023 04:14:54 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22278C2
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Oct 2023 01:14:52 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7741c5bac51so887346785a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Oct 2023 01:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696148091; x=1696752891; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vSDU3pNGpbCfCVOzW32zt1q7kzbkx3JeuL8RDliWJFY=;
        b=Cq/3VN+6MRmjCFizFw5pdQLuUDIZbZx1g2i/hmOTHvS3vpqyEjbuhbI6KMvQ32e/Hj
         30hdiZAfN0To8VSAXLUywa8UteSknNwXlh/azuDtLUTkbxH4fpgntFhE0NswYU9Ff5lX
         I+7D1S9+V7tBMNp0XFx274bG4h6IK1EgiL2LWR3OrRfsZE0OYUUlSliwyxWoBIiUzvwd
         Z0LEGNOxtpQ3mpis3/GBTQ3s0CASuoH2JQuBo7wKC22po74HcWWOEyI8imdpR96Cj1a4
         IGo+0x+EViaPkjFbQi5+wqD43K+yZIMnPr3dm6n5WbN96GDAsbh9JbkO4T9NmUxJOQUg
         0UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696148091; x=1696752891;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSDU3pNGpbCfCVOzW32zt1q7kzbkx3JeuL8RDliWJFY=;
        b=iPtIdhDhdAINlfPFuGfc02YHNU26kPW2yC8TKKletEMscTKWSVm3lCqbzkCaoPBwbM
         6E7/PLfuetbhSpcu/wXD7+5fwtrdjLPk0KJs1tmKqAe2JhwapMvKByjapUquskvdAm4Q
         k52ORlBTUMjnnSra1hL3lxRJ3oZu3nydDg9UJWEPORKmpmFUUV6tFxlXPnGqzEcMdx3B
         dDDwqR5MiDzpeU8z25ddpM+rDATGD/iYfpIuSwUg+3tYupVo46O7M8xLhuSRbHOVwH7k
         PLhNTEdRlY2DPHpukdg2S97YnRIxiu3dFAAaqzrXhj2XQlLWjVe8fPPaV6KI+zbXx0Mt
         sJiA==
X-Gm-Message-State: AOJu0Yw0kbhKl8uBr60SUTJ13lrZZPwewu4m/ChyGd5S0fuMcAmyjJVs
        WPv7tVUuUH7f6fTOtTk09FV5uLkwpeE=
X-Google-Smtp-Source: AGHT+IGurs/u68N+uLNsUl/YcrTKOx1nYDnJbclBi+9md9e9MvgFFqn1Ury82hMl7jgRYtIbM/fCyA==
X-Received: by 2002:a05:620a:4489:b0:774:16fc:65eb with SMTP id x9-20020a05620a448900b0077416fc65ebmr9471863qkp.4.1696148091082;
        Sun, 01 Oct 2023 01:14:51 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.150.112])
        by smtp.gmail.com with ESMTPSA id x2-20020a05620a14a200b007756e75b91bsm3549942qkj.78.2023.10.01.01.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:14:50 -0700 (PDT)
Message-ID: <65192a7a.050a0220.74207.ee6c@mx.google.com>
Date:   Sun, 01 Oct 2023 01:14:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7740754450056697014=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jlee@suse.com
Subject: RE: Bluetooth: ignore NULL link key and reject connection
In-Reply-To: <20231001074807.GA14403@linux-691t>
References: <20231001074807.GA14403@linux-691t>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7740754450056697014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_event.c:4692
error: net/bluetooth/hci_event.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7740754450056697014==--
