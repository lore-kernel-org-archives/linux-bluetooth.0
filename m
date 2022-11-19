Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE81C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 03:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiKSDuO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 22:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiKSDsO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 22:48:14 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF215C1F59
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 19:47:03 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id c7so5206694iof.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 19:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=60sC967vxaZt+baaFvg5B3sMQy+VUsrF+YWD6xYrXu8=;
        b=l+eWL/Vz/skU1QE64DvxCUbyRBGXYBHcddU0nMX9ZS9+Yjxujhb8lTH+l9UsNDrhWN
         6iW+AOxfgMzJvbebWsyxGtShLVg2xfheZ8JRucP8P/l6JaFdjoFycFxMkdHI68I6bcag
         LrYLhi16XMCMIbIUCnefM04xySHqwvmtA8bmDxXd8HSoU8eLPEEDrVrzwzs5M3fqX3If
         rbkJGirp8KAlQHaXdBf7DaixoBkrYigvMIYocJ1T8r6HOx9I9CkWbnrw5SNq/+mXyjL8
         uekjowTWnOjg1GtEhN9TgkxMqsILWFsKAqCJraBun/PrA2qT4guBebl/lyIKRWfZDiLb
         3IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60sC967vxaZt+baaFvg5B3sMQy+VUsrF+YWD6xYrXu8=;
        b=RfAPMZd87tYzy1XEifEwRBiSc0iN5iBUEI3BYteSAuZU5B1B0xxhS3PsDjw7Q4Muiw
         gOJLkNB78iYbNFcBN9Pdps4T+rzk/mV8WIQ8E4HOBuFXvcMQoQXU2jIGwA8Gl1L4cxTj
         xt4k95TTAfnDyWXFP4maaI7SrOKAAzrsiH05KWS1lzUUjC41pn8PeZEFUJmK6wYujtHw
         LxbecIIUm1UGAHUtfhbmEp9mWrbNn5VRJnwwyjklIPl3yo5Qp7YTCWEA+3nDwkd86Zte
         M2mxfiwojZ+bMTNKK6Tt5/vtSC4XQG2MUoPWzobBpMI1q4BkOn3D/CA3avRWDzlYZXWm
         p5zg==
X-Gm-Message-State: ANoB5pmmYqmzNTr3To2kAjjnU3Suic+QzbxC4cgnRGreMBcHSk7y3bLi
        /LNXfxKSrwWwoTepA73KWz0Eimxvxtw=
X-Google-Smtp-Source: AA0mqf58thnRIuIUPs1szUoMAocthdYXmotcfL6D84XUuEyVDTLjVYveas3mgNSkV8/pd80rGSguxw==
X-Received: by 2002:a05:6602:185:b0:6da:5632:1b52 with SMTP id m5-20020a056602018500b006da56321b52mr134844ioo.35.1668829622913;
        Fri, 18 Nov 2022 19:47:02 -0800 (PST)
Received: from [172.17.0.2] ([40.86.75.104])
        by smtp.gmail.com with ESMTPSA id y35-20020a029526000000b0037586addbe9sm1847627jah.88.2022.11.18.19.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:47:02 -0800 (PST)
Message-ID: <637851b6.020a0220.8a91c.4606@mx.google.com>
Date:   Fri, 18 Nov 2022 19:47:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1112711630639634401=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] main.conf: Add comment about LA Audio BAP UUIDs
In-Reply-To: <20221102101224.1463549-1-hadess@hadess.net>
References: <20221102101224.1463549-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1112711630639634401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691153

---Test result---

Test Summary:
CheckPatch                    PASS      0.35 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      26.07 seconds
BluezMake                     PASS      743.45 seconds
MakeCheck                     PASS      10.86 seconds
MakeDistcheck                 PASS      144.25 seconds
CheckValgrind                 PASS      237.12 seconds
bluezmakeextell               PASS      92.50 seconds
IncrementalBuild              PASS      598.32 seconds
ScanBuild                     PASS      940.01 seconds



---
Regards,
Linux Bluetooth


--===============1112711630639634401==--
