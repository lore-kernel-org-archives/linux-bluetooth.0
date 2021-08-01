Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E709DC4338F
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Aug 2021 08:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7549610A0
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Aug 2021 08:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhHAIyr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Aug 2021 04:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhHAIyr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Aug 2021 04:54:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8A7C06175F
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Aug 2021 01:54:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l19so21400601pjz.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Aug 2021 01:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8OJUQINl7UgWXdbnxp3od2KyBKmzZJubgZ8n5hg9xkk=;
        b=S3zoYP1mOZfajsoWOygEEkqgVS2cwNFocKyI2l/PV5QY0oMY6fkGqdl6+y6NeqRkTB
         1M2lt8LUqKw2ZJK2OXBvQmdnSiaqTFagv4e+QjqCkBk/5a8an8EyPknjYZB7NkY1tH9e
         zl4+7qlXbdiCr9l+nX0iCSym0ai3CtgEXkbX8aiXe3jtJAJQnPembv3Y7mKHk9QJAMnx
         FOatUAMo/n0dCKfvN0LYbWCrx0LrlUM+WGZkzGBb6542y/21okSHsPFD6nbDbUdYz5C6
         9DkTxiAZbgQgPeJ32zp/QaxkbbQyozbtFuqdGB4XA+9i2eru31ARMd2z2ZuPEYBqTIGY
         /ABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8OJUQINl7UgWXdbnxp3od2KyBKmzZJubgZ8n5hg9xkk=;
        b=Y2RJppebmR+oxd+SUy2TmJdiFGzMUvMmNedXcwwvpeFarp0fu7NaQaIanXcdB9S3En
         dgXge+p6lYqyHw6Ewz5hY10MBzxKrAhPWOy25VtIdt4qUoBTHNqInitvWo0N/9X0G4gN
         o4/X5K01IiT4BKAUG43dRh8A22t7Qx+j9W0y5KPtXcKvQSRvqz7DuWo0Nn3xc0sF61oG
         iqbzvMEaGUvcByVzpL4pHyqU3u6xQo80Go8MGUkezpiLz1G5sU/wcY2kSH/m57j8zwzy
         y+R+wnoBzBJZIGmV/aM8Bhbj9DERpM6ITKAzFESdrVh8h1depFfpEr/0r3QKEtEUsKCi
         yYgQ==
X-Gm-Message-State: AOAM530V72h4mkJpKnxJ5ZUb1bM/cLWbjFoBMUJSI0AIXkZ+kSsVaw+L
        K6LkeOfv48O17T4sI+XfRBSdYP+9PxrpSvGuxrA=
X-Google-Smtp-Source: ABdhPJxSTIlxkp+Gi7PGLGNaBpMFxn8G6XKT1JtspOe5CAfk30T674H1QdCd8iXMFkFfnOHIJPn3chyq4haS/D9vZf8=
X-Received: by 2002:aa7:99c1:0:b029:39a:56d1:6d43 with SMTP id
 v1-20020aa799c10000b029039a56d16d43mr11159111pfi.58.1627808078228; Sun, 01
 Aug 2021 01:54:38 -0700 (PDT)
MIME-Version: 1.0
From:   nil Yi <teroincn@gmail.com>
Date:   Sun, 1 Aug 2021 16:54:28 +0800
Message-ID: <CANTwqXBc9d4v=uPdFYc-yrgDKk219+SWri3+b84ZU14zH=1Nvw@mail.gmail.com>
Subject: [BUG] drivers: bluetooth: bcm203x.c:dangling pointer in function bcm203x_probe
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, there is a dangling pointer in data->urb  in function
bcm203x_probe in v5.14-rc3 in function bcm203x_probe :
187: data->urb = usb_alloc_urb(0, GFP_KERNEL);
...
205:  usb_free_urb(data->urb);
206:  return -ENOMEM;
leave a dangling pointer here,  I'm not sure whether it  can be
triggered somewhere.

Any feedback would be appreciated, thanks :)


Best wishes,
Nil Yi
