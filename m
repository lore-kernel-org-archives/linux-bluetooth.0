Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D547AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Dec 2022 14:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiLOOju (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Dec 2022 09:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiLOOjn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Dec 2022 09:39:43 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF872ED5C
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 06:39:38 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id g7so5284463qts.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 06:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Wvjbj1q5eR9k30krX9JMhPrLNrInlf6Oe4Iout0J7A=;
        b=CDhsyhWMD2VpoO9nqQnYZt1nyQ99YycflBVJBhE0G1s9J7ywIjXVuLQoyEwp5LXZ6t
         wYSUXrvm0KJkRNN1GcmvaU8WPrRZJqQvZxWzaj4DkWt6OH6IiGklwjYeudKv/grwNqpj
         5wPuTpocAbumjUz7uXVHR9OcQ/pjxECrL8S9KTUjkksZ8usnDmE+7CQ7DkznTflzezWQ
         bbGuYqWeMvVSyJzqle6yJ3wgEVPf4eQ/kf2R+Z7yjlKWbjBulvfOSXfT1BYVd4OTg1XW
         EZ/l5vYPFoC0x831pHhZC9UK/t1MzRwqtTSNSVUjmp+2+iuUL4wGbL3qj1iH+2cZUx8n
         xhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Wvjbj1q5eR9k30krX9JMhPrLNrInlf6Oe4Iout0J7A=;
        b=UVIL5AtCII3903C9Q6f0ZRXAdtaGZjBAX3CJlSXbg2kqnvTdHKC8i9K2SBxuLqJqpv
         1NLjS5FZ6HjX0UwGdlZt1CrJ+A4G3SX3psICNDZy3b2ESpmUrJvFwI1Jw5axwJGtNtEN
         gypVzgWHkaH+dZKnXK2Ub0QKQRLvIrK72QdJMcPZ1kW2O4F/fGQrdR7d0gLYolmzrd0b
         E+c2BKqQZm+CykcFsc5L7LqnCRWENlsmTqDpTrDZmE1FLDWFRB0ZUjHKtHIBzVtwSimE
         +giHaC96mBEB4gajQ86R4vX7L26tWI5m/XotyjRQBPjConoTK2NlWo+Nsw/l+h24WQXv
         hh6A==
X-Gm-Message-State: ANoB5pkgqkw3ym3gOq+p/cJpLJBCK1axAApqOmIiHe+NAK8X/YdNtM1V
        9P+TPODfohZ98MX/oPKVp+rxkQFlje4OaQ==
X-Google-Smtp-Source: AA0mqf6OApgFpTMuVAnBuAhlPKiyuGRN3rmipHtSC0aycXU0tBwcXbkwQXy5P6ixLZuhZzPdokbqYA==
X-Received: by 2002:ac8:5189:0:b0:3a7:f86a:a516 with SMTP id c9-20020ac85189000000b003a7f86aa516mr40715873qtn.10.1671115177235;
        Thu, 15 Dec 2022 06:39:37 -0800 (PST)
Received: from [172.17.0.2] ([172.177.145.241])
        by smtp.gmail.com with ESMTPSA id l14-20020ac84cce000000b0038b684a1642sm3535844qtv.32.2022.12.15.06.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 06:39:36 -0800 (PST)
Message-ID: <639b31a8.c80a0220.85898.f5be@mx.google.com>
Date:   Thu, 15 Dec 2022 06:39:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5204077339911639256=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v5,1/2] Bluetooth: Add hci_nxp to hci_uart module to support NXP BT chipsets
In-Reply-To: <20221215142150.240712-1-neeraj.sanjaykale@nxp.com>
References: <20221215142150.240712-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5204077339911639256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: tools/btattach.c: does not exist in index
error: tools/hciattach.h: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5204077339911639256==--
