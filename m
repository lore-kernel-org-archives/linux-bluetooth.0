Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB139C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jul 2022 07:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiGYHQl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jul 2022 03:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGYHQk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jul 2022 03:16:40 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B8CDF4B
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jul 2022 00:16:39 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id z18so7703914qki.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jul 2022 00:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vuH/JHbUGVMY2Anft537keFAVbLma7oJxPmHc57XhQY=;
        b=XtFRGZiH9UzZ64bk0AUQDm0x49dsJ3pd4wOOZCp9oPODUZPN5xVL8BYeoP5w7bkMMT
         2sJGwrwL++RaZEY34DNgQHTY4ytrx/x7sYyd+f1xO3zvCQJd2e3MPUfqZfooS9MVAtWZ
         2Bhp7SB0f16nTYNCWYPzwyAePIGw2Xbvjti9D3NjLKn7eXtGH9iLFCH5YG85Xm8AO2gO
         HNNAXVI8fV8MznURtqX8LtI36GxFY+tAp2pGVYUE9RpYFB3HhUp6sd5ImBqFr2yRu8Me
         P6rm6nPytiQpf7gxvll4oxB+liBr5TQ7MZ8k16/A3L46HQ/RZMPW6qp/e2ds24RvNfPG
         gDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vuH/JHbUGVMY2Anft537keFAVbLma7oJxPmHc57XhQY=;
        b=Byl0STioEh0QYqya80IRGK0PwIVAtAct1QASSf+R4aPbbUxIIbF2s8BSlXH3NrH3wW
         ii2juz3i8tlJwfr5oWjHt0hWXwP+g/pQJ54XFRZPyHo4GtUwfpl4xAepElAuZ5sMzwbF
         6z6nyLwHh0VL7cICt2s8aDwT5cfMvf/wxvJLMkDE6CWVBBP2gayzpbns1q7ZQJqw1NQ5
         BrxltfKqIMLfzCL8IqgpgRNtDjBRKDTe6dq2AndPKpRoWuULzgMXSuqM1EkGs38Irkzb
         fR0yjpPXSX32HXEuxzTq2lv5BkfaXy3rYayXmXYSnCMM+VWoiyiCSiqG8iLMAcMtXs5L
         eDdg==
X-Gm-Message-State: AJIora9jGFJ9id1PYkAOyfm6SkyzK5zQgDuMYAbC5Ih3XkL+fpOGO3qb
        ghK5MaaJ/0INOl+HClLy0yp8DIO6TNY=
X-Google-Smtp-Source: AGRyM1vu5IfsoeLPI6ztLkkOWxvLHG/qG9k8pJtYE+z1yUza/sQ60hsr1yQcSo9PT66IMg/JZStL9Q==
X-Received: by 2002:a05:620a:12e1:b0:6b6:5548:a6c0 with SMTP id f1-20020a05620a12e100b006b65548a6c0mr3323967qkl.237.1658733398483;
        Mon, 25 Jul 2022 00:16:38 -0700 (PDT)
Received: from [172.17.0.2] ([13.92.87.215])
        by smtp.gmail.com with ESMTPSA id k20-20020a05622a03d400b0031eb5648b86sm7411923qtx.41.2022.07.25.00.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 00:16:38 -0700 (PDT)
Message-ID: <62de4356.1c69fb81.6d042.2a4c@mx.google.com>
Date:   Mon, 25 Jul 2022 00:16:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0691734106194367367=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, soenke.huster@eknoes.de
Subject: RE: [Resend] Bluetooth: virtio_bt: Use skb_put to set length
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220725065316.6942-1-soenke.huster@eknoes.de>
References: <20220725065316.6942-1-soenke.huster@eknoes.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0691734106194367367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=662674

---Test result---

Test Summary:
CheckPatch                    PASS      1.93 seconds
GitLint                       PASS      1.15 seconds
SubjectPrefix                 PASS      0.94 seconds
BuildKernel                   PASS      35.95 seconds
BuildKernel32                 PASS      31.76 seconds
Incremental Build with patchesPASS      54.12 seconds
TestRunner: Setup             PASS      534.87 seconds
TestRunner: l2cap-tester      PASS      17.22 seconds
TestRunner: bnep-tester       PASS      6.22 seconds
TestRunner: mgmt-tester       PASS      103.51 seconds
TestRunner: rfcomm-tester     PASS      9.55 seconds
TestRunner: sco-tester        PASS      9.40 seconds
TestRunner: smp-tester        PASS      9.23 seconds
TestRunner: userchan-tester   PASS      6.22 seconds



---
Regards,
Linux Bluetooth


--===============0691734106194367367==--
