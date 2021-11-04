Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2160C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Nov 2021 00:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3207611F0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Nov 2021 00:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhKDAmt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Nov 2021 20:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhKDAms (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Nov 2021 20:42:48 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9C0C061714
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Nov 2021 17:40:11 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id p37so6658498uae.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Nov 2021 17:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LdAuPQSRnWRWcFN4wnjlTOngY3tFwf680GCuGMHjDqQ=;
        b=h+e9x7T5zrgUZX8WY/0oMUsdrxSG2Tu7WK5M3Y/0SRbKZ1X1fFo9wUEx5TMrSjCQE4
         uErSgVHCH/qxl0VD3XbZvDxFXrjtmKIQEk2ue5J2GKtULEBRLryR120TvMQg0Zxvpida
         ajxHExh7szDADLe9tnRzHvhPZ2qCSeFv6wBQJEfIDc9rAGxKCyAiMquLb4OqnqaN96uz
         zQRz4TNd5rOXRnSD0A1UlguEgDmN5gTWd7Xrrazgcnp/uB23pmVnHLpYU515Da1zGj+A
         QQHvcoC/cri3WEiWHGKS0GdqsDlnoCmDqXJZWDlGogZeMTPpIgh4yqF6Kuj1qf3rasHl
         daFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LdAuPQSRnWRWcFN4wnjlTOngY3tFwf680GCuGMHjDqQ=;
        b=7nVJW3ngt+aGyclYP7uMwg5hZ2ulGmO5feQUpaWgkGCXLXmz1arvfEPyW+gVwx9V3Z
         uIJTatenGU+2Wu1F0JkqAzEuURlmIjbNnKtiUQYO+jFeS+hegtfWpRCdgNw8PP+5Hol8
         qcwD9AlvduB3OQXSuQGOTkiGgEB58UQye+bqBxRUN/E7EAuJeqUcBjAprAHfSA9SkNMF
         wjmUIG6Q3dwO36rSIOOD6dLGKv5cNuWeMJpTaCle/EKwIeU9o+jyXX2wmGdia6Zmvma+
         KvNEbJ+LIpQaGqifjk2coU7gQSIKmPMHRvPVO9ZxgoptxPV/JzlovEw7cJq8lsDqRaU5
         pifw==
X-Gm-Message-State: AOAM531lBwHqAlY1m8MmVMmde19NqDxsF/rYWa8hpUEeeAKcYIbl2RTd
        motXR7379qiI/wyPOGI4jx0/QaZdINVK3Lz9DC/fKpYF
X-Google-Smtp-Source: ABdhPJx9tOg2rcjxV+YXSN2lrvqn+YIhCo0kOKzP1yvW5sexpf2unSbTBXjDxfau5P0tPfCNPz7WPGNbzrt94GUzuC0=
X-Received: by 2002:ab0:5a23:: with SMTP id l32mr52771334uad.129.1635986410296;
 Wed, 03 Nov 2021 17:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211103170206.Bluez.v2.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
 <61825891.1c69fb81.61efa.6759@mx.google.com>
In-Reply-To: <61825891.1c69fb81.61efa.6759@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Nov 2021 17:39:59 -0700
Message-ID: <CABBYNZL2VcG3Ddm-ihEG2+jsfmWk3DVBqwYA_K0M9rsvQbKmmg@mail.gmail.com>
Subject: Re: [Bluez,v2,1/3] adapter: Use PeripheralLongTermKey to store LTK
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Archie Pusaka <apusaka@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Wed, Nov 3, 2021 at 2:39 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=574639
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      4.46 seconds
> GitLint                       PASS      3.02 seconds
> Prep - Setup ELL              PASS      49.79 seconds
> Build - Prep                  PASS      0.54 seconds
> Build - Configure             PASS      9.54 seconds
> Build - Make                  PASS      216.71 seconds
> Make Check                    PASS      9.87 seconds
> Make Distcheck                PASS      251.91 seconds
> Build w/ext ELL - Configure   PASS      8.81 seconds
> Build w/ext ELL - Make        PASS      198.37 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
