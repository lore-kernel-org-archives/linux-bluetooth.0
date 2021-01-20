Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63191C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jan 2021 05:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D86623110
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jan 2021 05:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbhATFKg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jan 2021 00:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbhATFE7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jan 2021 00:04:59 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304C8C061757;
        Tue, 19 Jan 2021 21:04:19 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id p185so7126926ybg.8;
        Tue, 19 Jan 2021 21:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2QNIuDgC5vixuFYsnYmkXpiIls3XVH0dL8gRb6T6ZM8=;
        b=e82rsUdK/Y6ddR2zdT0kKv+G5OkLEYU8hrRAuzTOyZtpI7dYQYG5a3NrceAxX+cN47
         0fyB2JO34Al//LuvpGWC4iN0rKS0fg4e49AjsLEr5+owB0+HNZDVdP66piFAb4Oo8hVW
         6dZ8/oarGX8fJBTCxsNILesPJzVJDxu2QSo8l7jrQdDHvF8mqb05HsqD0Y3HCXcy3TEU
         +aFBnqU40O86yhLvpfWEmwjzSHSHKmMyaXwxcb2tnCeAHfQ6Ijxl54lXrAUDd5fIFJBe
         JAQGgyD+MHAi5GsA05Cuv5Vk1+WMNvKZuetseoYwjUDrCoDQvKuTbaQzxLXggdr+0BTo
         CoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2QNIuDgC5vixuFYsnYmkXpiIls3XVH0dL8gRb6T6ZM8=;
        b=tJ3/+q2z+D9ukuclBG1dWTs4kafKv2Dli8fJ6AOK4ytemlJULGPXkvJE+kOhv+zeVQ
         +6hfYOTfcwoByz87tz+3pwgfnh0kjya1OTwkRNTZylX/5Wj2v85J1pg/HR10YyJlq0vT
         vuDKRFZbM9+9PwtWLCo+4CX9pchh3LXomSygOxroTW1x1ARvAs8749MQzKCpYCCdzJ9Y
         hPq/djostG8WGwBci7hhiU6uUuWN9P7UjsY+IRjmcFWc+6ljWPrEY8EERS4JAsEMQS+n
         wYj93WktKrsmUVHddEHFHoktMIpB2Z+IshZWl1K2rUDJG/mvxrebw2e2iFDWPdN7TrFn
         Qb2w==
X-Gm-Message-State: AOAM530TuVjAbQqvR8zJI6Iz+fejnZc7QXqEDQJTiPssEHvTBrZY/D+w
        xNKtCJZeFARl5Cd28XXg7hgIy2nawxTAAsOrr9u0beBRQGbFHvJ7
X-Google-Smtp-Source: ABdhPJw9L4jaPxHZP4K8kMNUE01qQydu5uD2hO4uP6LuilAByXP0GeO/QqZRx0Vjpg4sRBkNv16ghzPTXhJK2IiebTo=
X-Received: by 2002:a25:cf12:: with SMTP id f18mr11243168ybg.18.1611119058511;
 Tue, 19 Jan 2021 21:04:18 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Wed, 20 Jan 2021 13:03:52 +0800
Message-ID: <CAD-N9QVWNK=SPgT0mc81_UqbSV57aQ+x-s=iz9PnjQWNc5bG6A@mail.gmail.com>
Subject: "WARNING: locking bug in finish_task_switch" and "WARNING: locking
 bug in finish_lock_switch" should share the same root cause
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
        netdev@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear kernel developers,

I found that on the syzbot dashboard, =E2=80=9CWARNING: locking bug in
finish_task_switch=E2=80=9D[1] and
"WARNING: locking bug in finish_lock_switch"[2] should share the same
root cause.

The reasons for the above statement:
1) the stack trace is the same, and this title difference is due to
the inline property of "finish_lock_switch";
2) their PoCs are the same as each other;

If you can have any issues with this statement or our information is
useful to you, please let us know. Thanks very much.

[1] WARNING: locking bug in finish_task_switch -
https://syzkaller.appspot.com/bug?id=3Dfff3de4144dc949f632cb91af9b12f9c2f30=
9894
[2] WARNING: locking bug in finish_lock_switch -
https://syzkaller.appspot.com/bug?id=3Dc7f3ee17ec2ac6f27e0c72f2a90eabc3c4e1=
d998

--
My best regards to you.

     No System Is Safe!
     Dongliang Mu
