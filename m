Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED985C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 22:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiKAWpE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAWpC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 18:45:02 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2AC1DDC1
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 15:45:02 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id h12so16228744ljg.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Nov 2022 15:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=83hzk/8jAqlD2YK4UDIvx6csB+spUzkO56eRkv7lWvc=;
        b=Nb6YjG8oW752zm6v5T0SojwM7ZdAAMyku41hTHbEohAQBD7ca6DXCQNryQBy4GeGOR
         59RyTul6oUTwp+mhTDMmeH2UW9euxMUBDt/8YnOedKe8M4bJ7nqjsiL8g/D1wy4wzPRG
         X98hDnJjHXf7ghk+VEwpgMMA5PZimCzvViigNY0ltVB3NXJOxdAnxGyW90s85sbHMS/s
         fLS+ekIoPpDFsqgqJ31mA8/RBlOnwaQH1HXwABKzQdAmdCJMd7UaWT+CF6l4HWORQaJn
         lNGDfMcak0ofYegJAQTWsR1SigkvqztICD6DUB4Z9M8KIhpR0jzf5sX56WBRXVcDV4sd
         AtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83hzk/8jAqlD2YK4UDIvx6csB+spUzkO56eRkv7lWvc=;
        b=icA9mB7X6BorJEpO9fjpncBO3oW82GHU44QkXbJZUjxJ7Gg9uQn9HSJdguIi2o16mx
         i69GJYtmd1gAcYQACkX2JRgUpDl6jkb5mPA3zmSYBMSOMiG4RpcIK5eow4rZNagYvOGa
         aUKtL8YKVV3U3TyfS+3PTCXrDOzgTsN4PmSCRwQvWtWs6xe/ttPZVs2UtvtuVsi72LY9
         aRV67gwcCpeXNtAzNYaGmlSFRAeyAkBN5mEPjYCJ+2fgCpnmwRlqy38HAhHJoEi/gP5E
         eBolWfdgcIkapxVycwnYdPXCeKMaSL+ndqLkJAZ0FKHUPc/JPrSVqH2SLtHgoc8xlBT2
         bDhQ==
X-Gm-Message-State: ACrzQf0kK3lGpUZAwoLJ5T9x6IH1Qp/WJi63NWoak7B6+k1B7Lf8KQSw
        8QPdjN1/6y/THGyRyiMONZhTzu5DJgqkNyPAd0o=
X-Google-Smtp-Source: AMsMyM6rZoyhUwZ86+dTU0TN9oXCrvrTEBUjMVLKEF2usHsX6pH9qw6gbcItvIWLv/XvFk94XqsGqh0iaDLvMk/+h1o=
X-Received: by 2002:a2e:9ac3:0:b0:277:1c8e:684f with SMTP id
 p3-20020a2e9ac3000000b002771c8e684fmr7607959ljj.260.1667342700241; Tue, 01
 Nov 2022 15:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221031204804.195267-1-marex@denx.de> <6360471e.4a0a0220.4aceb.91b7@mx.google.com>
 <a7485b76-b4aa-a6d6-b509-c6f370380926@denx.de>
In-Reply-To: <a7485b76-b4aa-a6d6-b509-c6f370380926@denx.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 1 Nov 2022 15:44:48 -0700
Message-ID: <CABBYNZLpaT7FCwXrGq8RU4owP74VA7Eo99jceFzVsqqVnYFaHw@mail.gmail.com>
Subject: Re: [1/2] dt-bindings: net: broadcom-bluetooth: Add CYW4373A0 DT binding
To:     Marek Vasut <marex@denx.de>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marek,

On Tue, Nov 1, 2022 at 3:38 PM Marek Vasut <marex@denx.de> wrote:
>
> On 10/31/22 23:07, bluez.test.bot@gmail.com wrote:
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690631
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    PASS      2.99 seconds
> > GitLint                       PASS      1.48 seconds
> > SubjectPrefix                 FAIL      0.58 seconds
>
> Should the DT bindings really have Bluetooth: prefix/tag too ?
> git log on prior art indicates they shouldn't .

If it is meant for bluetooth-next then yes it shall contain it since
the CI does attempt to check its presence, in the other hand we could
perhaps use the prefix [bluetooth] to avoid having the CI run on
patches that are not meant for bluetooth-next but I don't think other
subsystem do require this so it sort of hard to enforce proper
prefixing.

-- 
Luiz Augusto von Dentz
