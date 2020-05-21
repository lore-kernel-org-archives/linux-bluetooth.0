Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11F7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 18:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DF920823
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 18:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILJ9J70d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgEUSHt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 14:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgEUSHs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 14:07:48 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EC0C061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 11:07:48 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d7so6188339qtn.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 11:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=jr4Vz3ZkRQYcGbdl3K/tLhe5unipYZG5io72zqChS+Q=;
        b=ILJ9J70d4/9RbOgs7rnleLQGqIChxFLeYhvLfATzOmnVrtAb/12zZHdzuOCsD7RdjG
         WJZz5dqm9Y25Q/wqGXXpWzfmAhS2rDo/2WvWa1H5o7RKq9z0Xph/2eIrC5odgmsYVzHx
         4KBf895KsB7I9Y08ibTgF/EDGmgJJpzPguGpg6qxm2qTTl2OB0H/bJ9j0U+Tmg+qUh+o
         6ud0WbzSVwJYTdKsNQa6zh0MnekihUIh+X810orSt3LOwnQ6Q8KPnap0JgFkR5bmiWek
         fIfOu+P8wquFgJs3s+cPTjHAV6DAyPYJh+SovxbD8C5/QMWExMx93hwr/07ZK78OTS9j
         uLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=jr4Vz3ZkRQYcGbdl3K/tLhe5unipYZG5io72zqChS+Q=;
        b=pjirzp792q2LcA5qcNWdmRrEtzo9RLHkv01TZTOJkn2+9LkrIYcFS/d+P76IMhfyeH
         TrMQakiwdHCuaZzlCX3zsJ6gIpeZPcgKPuYEqwYPyZwOPi8zDPEDlznwjphn2KQlr07a
         Iy6QfMI120sS29X776iI/WYEPgMbqWJFD5GD8BYp08aaqDKP90U9boBKyJxXxTLFr4nS
         D9Z4aPujmoSSRw8JDcfevm4y714INgkcc150naq82OJSsJyZEcFFYpQmWLFA9X3TxfXy
         7tWwbBGr9HtBHVeKLg/UEJMjXwEmAVcReLp6G9pB57naGB2kc9mcOp6vcRHAYEsS9mDO
         YNzQ==
X-Gm-Message-State: AOAM533p9g99vhGvXGzKTCg1uue/TnhOGNy8X3eZrTR5T0nrRyxhXYux
        tadEsAqMzSIrtgOWISitOrIj5BqEUis=
X-Google-Smtp-Source: ABdhPJxVHZSdaU0m//jErFI1VPShyV4RgToG3hYzjVimv5UUsKK/QGYpIrvy6MxHfHPN/O882n780Q==
X-Received: by 2002:ac8:b4b:: with SMTP id m11mr5760902qti.234.1590084467557;
        Thu, 21 May 2020 11:07:47 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.232.232])
        by smtp.gmail.com with ESMTPSA id y129sm5449767qkc.1.2020.05.21.11.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:07:46 -0700 (PDT)
Message-ID: <5ec6c372.1c69fb81.4eb73.02c7@mx.google.com>
Date:   Thu, 21 May 2020 11:07:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7166887772300970013=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [v2,2/3] doc/device-api: Add Types property to org.bluez.Device1
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200521175543.7923-2-sonnysasaka@chromium.org>
References: <20200521175543.7923-2-sonnysasaka@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7166887772300970013==
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
3: B6 Body message is missing



---
Regards,
Linux Bluetooth

--===============7166887772300970013==--
