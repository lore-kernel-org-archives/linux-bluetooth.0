Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6461AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 22:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349993AbiC3Wg0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 18:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiC3WgZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 18:36:25 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141802F383
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 15:34:40 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b189so18158540qkf.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 15:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8V/9uvToBoVcb/t6K7tQ/qP34gRpyJ71a6GuqZE14Vg=;
        b=OEwdo6oI2E5bqz/e2hid5RahUspMl59mM0v0L5MSjz0w0LRQCkNho4afasSzkjexQc
         u6WNxtkuF7iEZa9k2W3ObkNcAes3M9Fam3iwWixIt9GsYDzIM/uZbSzHjo5or3/72rHj
         r8py4jBnxnq/im2sZ8Ym5L3DtmigWYDfqQA0EY6t8hUY9b2uyfEZHjMPtphekfey7hEG
         D/XkXnwiItusifljCB5i1augGC51Xz6MQr7/2o8hjz5l0k0WQ7MMvLO3rlOLOnN/eLLH
         22GZlKmeb5tpkGzPCsdB0tE3X4wtn9+XS1BpzdjXOVqXVSpvN7BKCu2P8gL9WZYcXk+9
         mFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8V/9uvToBoVcb/t6K7tQ/qP34gRpyJ71a6GuqZE14Vg=;
        b=t3NKoDqC+HfZdHg7ggkXBbMyPrj5hySRmS5155W44yHxfhuFZFdgDypBEKXz9NhMEO
         ahHTGvkSfTuckyQSXrbFXBvnpjLiRGcPJKHwe16s4mIncSncM8lspCDGuj3bnpRhai5r
         xBQEmrukzWtTycpANgBgvSJ8vnuIx0RsDuJgaQkb8rLzviUi1vgBUrZGYNhxYQ7plH9J
         EwU4xmHjJiqdzCsa/Dad2v1HyqmGgTuw152nn2UMH5aD7pCnnTFqdCZ3jgJMkmrGnyBG
         dDG5FkXnJ6JtFmwITWwx25ZhOt1td4shTk6d3r3oXl4xmUYeJrufqfAlVsT9y8LAW/U5
         UVqw==
X-Gm-Message-State: AOAM531Z2S/4vrp6pSXAY9MoTdrmloJlTBl3JBRrIqDsSb8B951tx4J4
        Zab8Kwj5XtJ3Nbpny3N39P6gZyEwAKDsiA==
X-Google-Smtp-Source: ABdhPJyRXYNZdsRwGBt1zJ3lYFjhA+IQS9YzhOVQE/OYNRX5FCE+IMCs1VVcDqRgiPtin4BKmv63Ag==
X-Received: by 2002:a05:620a:16c5:b0:67d:47db:8b50 with SMTP id a5-20020a05620a16c500b0067d47db8b50mr1437838qkn.77.1648679679118;
        Wed, 30 Mar 2022 15:34:39 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.206.24])
        by smtp.gmail.com with ESMTPSA id x20-20020ac85f14000000b002e1ee1c56c3sm18808808qta.76.2022.03.30.15.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 15:34:38 -0700 (PDT)
Message-ID: <6244dafe.1c69fb81.a264e.5065@mx.google.com>
Date:   Wed, 30 Mar 2022 15:34:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3918547489223296001=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] mesh: use explicit uint32_t when bit shifting left
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220330211747.48759-1-inga.stotland@intel.com>
References: <20220330211747.48759-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3918547489223296001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=627632

---Test result---

Test Summary:
CheckPatch                    PASS      1.52 seconds
GitLint                       PASS      0.99 seconds
Prep - Setup ELL              PASS      41.73 seconds
Build - Prep                  PASS      0.75 seconds
Build - Configure             PASS      8.53 seconds
Build - Make                  PASS      1190.18 seconds
Make Check                    PASS      11.58 seconds
Make Check w/Valgrind         PASS      416.72 seconds
Make Distcheck                PASS      217.35 seconds
Build w/ext ELL - Configure   PASS      8.28 seconds
Build w/ext ELL - Make        PASS      1186.12 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============3918547489223296001==--
