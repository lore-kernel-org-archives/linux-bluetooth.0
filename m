Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1744DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Sep 2021 16:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2C5061166
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Sep 2021 16:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhITQLU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Sep 2021 12:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbhITQLT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Sep 2021 12:11:19 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63835C061574;
        Mon, 20 Sep 2021 09:09:52 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id h9so19261886ile.6;
        Mon, 20 Sep 2021 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+yIrQ/P9U9GqL93qgveOM47ac0T/0riSAL7QQlHIRY=;
        b=Uv67J2tGqG9qgB2Wbhy4O6dwph6sqdwFFhctbkUJEq/U/88+oYDUbnn+YfMLE9AcLy
         uThZz4t/OnaTtpFnucmu7ntjeDuNq1HhXZ7UwO5y1VQA3kCwbFXBE0loYGI66Z2n6hPU
         KKSZmOYPlIthkfNdyDWNBQ1pRgoqIv8EgBFqPhwvTZMjUBzpgc+d2xXNgycdSrg3yP6R
         rmI7VEuCMVwZcI3cs8otsVZcdwHwe2OJjwojWznHp4ircYSKPhezPdfmdyrIL8FahruG
         LklISVU3nbBlAeYAKwBNfbi8xO+ZKGDvbWffmpmmIL3Rp9pWpy5qeGbp1+5Y+qbdYhVT
         VSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+yIrQ/P9U9GqL93qgveOM47ac0T/0riSAL7QQlHIRY=;
        b=EoZSUeXtQ4GUG/XNrLevOBZ3E/Cnw0zxhZMTgLP7JFrfKjMywrL0YaF/yLmC+H7JxA
         5zP/lRNmD5wHxwbAfK3t6uHXkUPD/X8je+SP9OQHfqIdW0XW/yIZAFBUtw4lH/xCFw76
         bAwhocG834PPg5anSu9LtGEZDm9cGSDiegXaHjlQVaXsziIHhzkbzGxL8zdT4H3xZT+S
         qI5TtQ/MOkOsH2cuCMc1iUYcjbD6RPJqFjUvs3tfdMXTge7JNz18lj/EutRbI4YXRBn6
         wBqjwLdcEm3O5K0JEs/z5Ij+iytPGXkE4wtdFFAMYpxZj3/FE1oitnGHkRAcnfFYIWEg
         05ew==
X-Gm-Message-State: AOAM531+6j5tZ9TzRp8TCNsLp0IJafqTPNMTm7Cwlvw9Q5op4A0ufOnj
        CT3rt/ZwW49lJyu0iKXRa27m++0pF5scqPqX84t1tfT8tAQ=
X-Google-Smtp-Source: ABdhPJxp8Cy0ttSj3gFCW8toj7uyh7aFqXZHRsHKAt9fOh/H5KP5zegtHAqyJO0si1RoyqW4oH4yWDrdUPdB+uiQxPM=
X-Received: by 2002:a92:c98b:: with SMTP id y11mr17731458iln.205.1632154191766;
 Mon, 20 Sep 2021 09:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsZB8iYMX9Gp7yorf09PFnTUFw267ULsbRMy_NZcJckYKw@mail.gmail.com>
In-Reply-To: <CACkBjsZB8iYMX9Gp7yorf09PFnTUFw267ULsbRMy_NZcJckYKw@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 21 Sep 2021 00:09:40 +0800
Message-ID: <CAJhGHyCCeyJbWxPX98QmS8zP9Hh3nAw0rqN=mb2YMNr2r34f0w@mail.gmail.com>
Subject: Re: WARNING in __queue_work
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Sep 20, 2021 at 9:13 PM Hao Sun <sunhao.th@gmail.com> wrote:
>
> Hello,
>
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.
>
> HEAD commit: 4357f03d6611 Merge tag 'pm-5.15-rc2
> git tree: upstream
> console output:
> https://drive.google.com/file/d/10dFvcbiBLWmCS05daXKnBH-ZEa8M7aI9/view?usp=sharing
> kernel config: https://drive.google.com/file/d/1HKZtF_s3l6PL3OoQbNq_ei9CdBus-Tz0/view?usp=sharing
>
> Sorry, I don't have a reproducer for this crash, hope the symbolized
> report can help.
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Hao Sun <sunhao.th@gmail.com>
>
> Bluetooth: hci1: command 0x040f tx timeout
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 10555 at kernel/workqueue.c:1440
> __queue_work+0x437/0x8d0 kernel/workqueue.c:1440
> Modules linked in:
> CPU: 2 PID: 10555 Comm: kworker/2:7 Not tainted 5.15.0-rc1+ #19
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> Workqueue: events hci_cmd_timeout

Add CC to Bluetooth people to deal with it together since the code
is also just changed.

It seems cmd_timer or cmd_timer.work is still active or pending for
unknown reasons when hdev->workqueue is being drained.
