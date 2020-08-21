Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5664EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 06:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22EDF20714
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 06:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbMtUaLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgHUGur (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHUGup (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 02:50:45 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7826C061385
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 23:50:45 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id 6so595696qtt.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 23:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=aBYYnNgxSeuYf5HXI+jNWeDLYiLmhNA1RcN5JBWgvzg=;
        b=vbMtUaLMoECZshRjMApuPDXwOmFy91lFqLqAg3UIC1WbXP5R1hxjoAjcKzYJ3EIYcY
         Dglg2la7eTS1JzV7AE7ZmC61Fs3PH7GdLpgtbH3bzDu9Q0gnlLpPYLT3FjlnJ6kkaGwp
         edUKTiMElGeA7Uiil3s2Lyfjv62mnlNhg08m0Z9SM9CYCUhy75/3fjw/wLbyYJfHHbAf
         LYXhtXxGzJ7cLJJ7Z7UJ3qeSzo9Y9dgXTZ3vM0ryTi1AwFDb8X+MViZaaynk/kj68J1X
         dbA6xSMjZabjBRJPZIo1wy+3m5q+T/Ft8PRYVran1V8cvtGiOXkilNwC7k9FzS+dzzil
         fJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=aBYYnNgxSeuYf5HXI+jNWeDLYiLmhNA1RcN5JBWgvzg=;
        b=H2HewCXrj0i7DFFVmQhsR5hGLka+QNDDOi4p5OW4Q+aUp9bGKTjfv5bOzC0mZVcMhZ
         M05SzZ3UPrRug8WR0CJprwmIsAkxketp/KyiMiyYULIAhJH8puYT+IoONckWjvrqnZ3W
         UAf4gBhXSk8LlCzw96t+RPGOLGSLcbVS0JWe+HCj0DTcrgR0q63MERxH2SQ+94IgKOGC
         byKD+NYEpsUOH7OCaIadO0tFJ7gjetIwSTODCqIGKgPCWpouhcLm/XNDBOeHqecrofMR
         8ZmMz3GCJwR7RB/V123ygjO6D+ZSRRlibWZVRIbLafpnUb4GnwjBBNKAtX+ZaPL/Rk3r
         h4DA==
X-Gm-Message-State: AOAM530lymhkXwO6vZEJMbsJMcf6/tWoIjBoXAAZ/dPU05i3aRvWOmSJ
        ishhELy+5txE7CeuQGknOj4rOICPd9vOiw==
X-Google-Smtp-Source: ABdhPJz02+SsGBkw04NtbxdveVofFzEWixWNVu7C98ESgNaybyNITyOo5HCuLey2udxkF6bj1dqWSg==
X-Received: by 2002:ac8:3042:: with SMTP id g2mr1500433qte.224.1597992644524;
        Thu, 20 Aug 2020 23:50:44 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.69.72])
        by smtp.gmail.com with ESMTPSA id d20sm972818qkk.84.2020.08.20.23.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 23:50:43 -0700 (PDT)
Message-ID: <5f3f6ec3.1c69fb81.ad2b4.353c@mx.google.com>
Date:   Thu, 20 Aug 2020 23:50:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5349863263851167541=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] device: Cleanup att of a device object before assigning a new one.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200821063844.17349-1-sonnysasaka@chromium.org>
References: <20200821063844.17349-1-sonnysasaka@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5349863263851167541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
1: T3 Title has trailing punctuation (.): "device: Cleanup att of a device object before assigning a new one."



---
Regards,
Linux Bluetooth

--===============5349863263851167541==--
