Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01777C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Apr 2022 01:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbiDLB7L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Apr 2022 21:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiDLB7K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Apr 2022 21:59:10 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CBB24964
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 18:56:54 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id ay4so2278470qtb.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 18:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=EtNBXiiD1VTsw0l6SR+tkLkPUThIXNu2liah96VNvNk=;
        b=E/Q87fFw6u4aXVKzn60rmeCVNlOCNm99lToDBL+K5G4qwcCnEHmQS0+B0LWRKzSwny
         01lOSOBjFaXKQcPmsUY4ONEKa0CXCMlu6ik6x5UJSCQUh4BsYLeOgCK77CzeNMlT7w1l
         zXD9PdsLdW2ItNRJrHtB+x1Q1qqxN+XtPvHLG53OsxtrIwDdUqsnkO5IhzjwhL+oY6X6
         dewzcjCL4CL26CpAc7KIgAP95mb5jzuyjIBD/XQF7g1L9rSqZO05NFrIn+gEjI2+Lsbg
         2LdJPYJ+Klh8PEo4KLA4FAg9HheSw/m2xz0XO4ZnMafY0zNVRZBPUJ7I3wfYYFLMu8Sk
         4VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=EtNBXiiD1VTsw0l6SR+tkLkPUThIXNu2liah96VNvNk=;
        b=2kYb1TmBIxY7cDxUoYpr7qe15HXBG1wPxCJUsZqho7LdfI6+RM0bL0mzuxH+TIHr5M
         vYE5aHl++hJoq164tasLFRdo2l8ph1pi5lGlfA/uPyfQFEaN8/CNMWV9skF+AqtExcu9
         GeHxETSMONbzrKIWtMrZhXKakPSwHMZGGuhBuydJd2HzGM6DMJAfPIqmmgZgGvzOAUB5
         FvRkBLyHm6N7cc8qDjkQ7xwUkhJLgjh3sW3M2TcESr66o5L1hm/Sc+Q4EjQcusm5C/xm
         CieBeOi2OjQPA2X4iGYBKLIOv3s6MlqQDSK3tG/qcRcLrCkBEtfEANu/duVStQLr7L6B
         5Fow==
X-Gm-Message-State: AOAM5339OaYB/KK2Mi2t7lFEIwJ8nAIxe1u05lrYoeZJIh0dRsyXrLV6
        Zvd1MTMpeKCsC7JgBeVt4dYxB+nRaZfBHQ==
X-Google-Smtp-Source: ABdhPJzucbNLI3QYyXgYPt/c3XM4/w01oWTFYyLvHd31dyU0/SvsAQagQiYcQxBJWe1qczTgfUWzeQ==
X-Received: by 2002:a05:622a:349:b0:2e1:b9e9:7598 with SMTP id r9-20020a05622a034900b002e1b9e97598mr1768932qtw.146.1649728614001;
        Mon, 11 Apr 2022 18:56:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.228.200.159])
        by smtp.gmail.com with ESMTPSA id q8-20020a05622a030800b002e1c9304db8sm26364182qtw.38.2022.04.11.18.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 18:56:53 -0700 (PDT)
Message-ID: <6254dc65.1c69fb81.9d49c.dad1@mx.google.com>
Date:   Mon, 11 Apr 2022 18:56:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4999808245572245263=="
MIME-Version: 1.0
Subject: RE: [BlueZ] btdev: Fix not cleanup ssp_status and ssp_auto_complete
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
In-Reply-To: <20220411235804.3776702-1-luiz.dentz@gmail.com>
References: <20220411235804.3776702-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4999808245572245263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: client/player.c:49
error: client/player.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4999808245572245263==--
