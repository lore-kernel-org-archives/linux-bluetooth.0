Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8225CC433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 22:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43FAC6191E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 22:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhEKWle (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 18:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKWld (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 18:41:33 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7000C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 15:40:26 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id i4so28417435ybe.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 15:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+JC6rvwHTf85Wp7qTYRMmNZIuZS5upHtwk85Kn0Buc=;
        b=EARkgvXoN6ojQpaq/fFJlJoRJTASj65KhNPLpJZMjuuPf7Wvm0YtKtwgaDJIyNdVLH
         ESvix45Ts9L/0Asd37dF1ukya6TWelFjhDcA7TzO2egtF+lb++YlM3y2oWXJSWOetUeO
         MCS6vOzX5h+j8LrzNW6YOeqzvrK07M3gRM4kOn1tI6/1O5Y2EKPbRnd5tnJmxdQshC/A
         +SdjxACp7f7CNVehb2uesNybp0POlHIpi3prOwkK31qia7PaaT1tXbx5NDYGYoDRGUOz
         NtWaBUdKcVSqS7stVKBD8grNp6NM+LAilIeMAWfYfYRnA+OEQkfY+DdoeRkvk2OE7agm
         ncAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+JC6rvwHTf85Wp7qTYRMmNZIuZS5upHtwk85Kn0Buc=;
        b=RxfIOv/YPLdfdnUzvRGJWF5YLlFo9v4nBT0MZrWhUdOUQVaZitL/BG6KKCEpkRlaiB
         BeZIDuOJiT04sPIf2d39zphsQIN/RxBqxLk86EqSiLyel+VJ/QIbXTlhEjEOJM0RAr9l
         uaLlQ1KyjyZCy8HjkpUbzuZcYrDVB5jIQtUXDusmObPhCKUQ4wMzGbrJt0Bjhlezr8pD
         DfDuXcJO2oYWFhUfR/FC958ujnmGL77uMQaLrM3F7aAQS/TB52PeB69O6tJ/EpP40nMu
         pgmV8CfXfwzhkYIIFb9kxDtyGzdGSDwERrsQr8m0jAN6o5OMVrmG1O+Nm81hZt4DqDbU
         jCMg==
X-Gm-Message-State: AOAM530c9D90Bor2C935mT8L9jPhLiLPWfJztbnSblW8g752E2MEoBnv
        xR5qa7n/zr9AwzuEJQ7SYP8pfp8Z5lXfPggpuZdOMrtU
X-Google-Smtp-Source: ABdhPJypEVrmquJIDkRCYwC/ECQvdgZ2fROstCW/CxgjQ5BhDcopdZpTBoKf0kdnPY1xOn4aWBOdi+dnt0Ee/3a/id8=
X-Received: by 2002:a25:d0cb:: with SMTP id h194mr31568326ybg.408.1620772826012;
 Tue, 11 May 2021 15:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210511200843.1741595-1-hj.tedd.an@gmail.com> <609aec02.1c69fb81.cfa06.e3b9@mx.google.com>
In-Reply-To: <609aec02.1c69fb81.cfa06.e3b9@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 11 May 2021 15:40:15 -0700
Message-ID: <CABBYNZJD9eZnS=hGb3YqR3crZ4EGZe1BTN-wV6pi03XTa7WJLA@mail.gmail.com>
Subject: Re: [BlueZ,v2,1/2] config: Show error if rst2man not found when
 manpages are enabled
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, May 11, 2021 at 1:43 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=480695
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.80 seconds
> GitLint                       PASS      0.26 seconds
> Prep - Setup ELL              PASS      48.35 seconds
> Build - Prep                  PASS      0.11 seconds
> Build - Configure             PASS      8.59 seconds
> Build - Make                  PASS      206.79 seconds
> Make Check                    PASS      9.27 seconds
> Make Dist                     PASS      13.27 seconds
> Make Dist - Configure         PASS      5.30 seconds
> Make Dist - Make              PASS      83.52 seconds
> Build w/ext ELL - Configure   PASS      8.53 seconds
> Build w/ext ELL - Make        PASS      194.49 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
>
> ##############################
> Test: GitLint - PASS
> Desc: Run gitlint with rule in .gitlint
>
> ##############################
> Test: Prep - Setup ELL - PASS
> Desc: Clone, build, and install ELL
>
> ##############################
> Test: Build - Prep - PASS
> Desc: Prepare environment for build
>
> ##############################
> Test: Build - Configure - PASS
> Desc: Configure the BlueZ source tree
>
> ##############################
> Test: Build - Make - PASS
> Desc: Build the BlueZ source tree
>
> ##############################
> Test: Make Check - PASS
> Desc: Run 'make check'
>
> ##############################
> Test: Make Dist - PASS
> Desc: Run 'make dist' and build the distribution tarball
>
> ##############################
> Test: Make Dist - Configure - PASS
> Desc: Configure the source from distribution tarball
>
> ##############################
> Test: Make Dist - Make - PASS
> Desc: Build the source from distribution tarball
>
> ##############################
> Test: Build w/ext ELL - Configure - PASS
> Desc: Configure BlueZ source with '--enable-external-ell' configuration
>
> ##############################
> Test: Build w/ext ELL - Make - PASS
> Desc: Build BlueZ source with '--enable-external-ell' configuration

Applied, thanks.
