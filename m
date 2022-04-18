Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60AEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Apr 2022 20:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242850AbiDRUov (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Apr 2022 16:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiDRUou (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Apr 2022 16:44:50 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2561114E
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 13:42:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id j71so7439951pge.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=oGlgREgbfm62oe1zAngWYB6geWfze+i9QtLFiqDfz0M=;
        b=Vy3ljm1jICQ1KJif8c38wHIXVc81ndEoBs5Hr0xev7ZLZhzd8CzXNpGvAM1RRawBXl
         KNmT2718KE4fXH/aw1oBMATwJ81phgLcuhKsqmw+XiDBfMWSyJ3BUYwaAmw+QEECdhs0
         3KpaAWHLLo7H7F1brGcHBv2CKmq17qC5SZlFN3Zv4Naz+If9SZPSti56EJZHTLf22gw8
         u+9rT65QXTGuVCYfK387WXWISORc/5ji+VxDuI2HEqBbPjZ5Qf9gEZ8NacfEYkLLEAed
         6YcKhmdEv+hukQDy8uL+Wgi5un1Ehft1p9BwqfYTVov1u2EtZ0/f5i2FSI4X7nLblLRH
         IZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=oGlgREgbfm62oe1zAngWYB6geWfze+i9QtLFiqDfz0M=;
        b=n/dCXz4+IDQ7Xg7slEEseOy6wkF5e1Hh7OJJcJCQEkDODIXaem+znUBHik6lF+yd9l
         LSCYHWBYksCYSAJh7xeCE22SBeco0MqZeQQ+shPbpsK23HllLvlA+Nk01sOgfomAcXv4
         Vm5iELb6LZbZbD+WlS/kVO5GL3lC+Gt7GTHZ6qTGBP/GfLnIx9Mh4/YkFuDc1d6BOyLL
         b+OERvoOgPqmnltgpKH5bbbLbpKt35DFKj4k+yQ65FvgROQ49wQptxVtprnFERFmNNFj
         jrk4HOQfSpSeNmp9blNHXYYaHOi/zfK9wv4G7KuGYc3tHjG+mE5JiwFcO6d+MCcw9ZS/
         R4Hg==
X-Gm-Message-State: AOAM531KN/pxs8MhzcLk6MRVYpszGGwntsVmGG7wLMbZdWD49pRcdJ/v
        RPzIio3yniW+NieCUEBN2DYG8mofG7Gpaw==
X-Google-Smtp-Source: ABdhPJy8JyQMZhZM9/1OtkzXXTAuRIkHPkl5LGGvqvjrJyS8E7EgLFJIPqPMShLtwTptX7NoPksxcQ==
X-Received: by 2002:a05:6a00:1988:b0:4fa:c15d:190d with SMTP id d8-20020a056a00198800b004fac15d190dmr13796216pfl.44.1650314528163;
        Mon, 18 Apr 2022 13:42:08 -0700 (PDT)
Received: from [172.17.0.2] ([40.118.202.148])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a174800b001d286e16e4esm5161713pjm.3.2022.04.18.13.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 13:42:07 -0700 (PDT)
Message-ID: <625dcd1f.1c69fb81.bbcfb.b820@mx.google.com>
Date:   Mon, 18 Apr 2022 13:42:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6757086664983600560=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: Adding bonded flag to D-Bus property
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220418174914.Bluez.v2.1.I6ab300fa4999c9310f4cb6fc09b1290edb6b2c2b@changeid>
References: <20220418174914.Bluez.v2.1.I6ab300fa4999c9310f4cb6fc09b1290edb6b2c2b@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6757086664983600560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=633121

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
GitLint                       PASS      0.89 seconds
Prep - Setup ELL              PASS      49.01 seconds
Build - Prep                  PASS      0.61 seconds
Build - Configure             PASS      9.71 seconds
Build - Make                  PASS      1700.73 seconds
Make Check                    PASS      12.49 seconds
Make Check w/Valgrind         PASS      515.95 seconds
Make Distcheck                PASS      271.29 seconds
Build w/ext ELL - Configure   PASS      10.12 seconds
Build w/ext ELL - Make        PASS      1667.33 seconds
Incremental Build with patchesPASS      3404.97 seconds



---
Regards,
Linux Bluetooth


--===============6757086664983600560==--
