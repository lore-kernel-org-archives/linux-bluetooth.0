Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FA3ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 22:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiH3WE4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 18:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiH3WEf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 18:04:35 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CB492F54
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 15:03:08 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id j17so9661146qtp.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 15:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=KVJivuRkft1AjLrJdW9bUZw9dkCKuZKUClbTt7yw2n8=;
        b=q6GD/UwYaskSax4wpBPeTIufL+5vI96cQG6ydiGfuKwyPLiqwgEMLe5dss56PcuNx1
         L8hIdJKBHMi5sjM+DFU9xBcnsYPYiceL42kidzfYbKISY67eRvc4pcgxpy6L1YgW/LU5
         z5AFgUnViYdAGW+l2K4FFpSw6m7K9sVXP7u61gApqZ+6GmfwMGpRDLxPSJ1HbyWv1bi2
         L9DcMOLfZGZPGvkln32AXns6VT8q1u9eMBafCuumq3PdxNZl7kkAXKJ6MCJBRlEQWaKn
         MT8rA2/GGEm/0eYTHJl2tbJbq/PsQj0cC60owooqFNNGQEfXas2Eu/IO7vVn9RIQheTy
         kEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=KVJivuRkft1AjLrJdW9bUZw9dkCKuZKUClbTt7yw2n8=;
        b=oE8aTluGfTF8VnVsw2Zhizume0NammXkKyLzmpu/z7f1qJVnaKTa4HBq0+24IYBi6z
         D+zJs+SmwJNv2YU9vALU+Qll3aP9RR9HxCKMgZHteB1Koh8hGXnCqAeQ8Zy4r/bsVRef
         CbqYPgNXlVB9/0VHzQRl/YfKzDVUkuZ2se2lpaKw7D9tjkG7REGtrkv+UKVBTS0SRCoB
         nVW4QHIoW9yYCXSQT4UqbJxaBaio2xJGYoeGx/iaLr8FQokSOL9r7GLGweZHATCvAHI+
         jfZSboYNA9luqG+yMo2c5Ov+bw8nKlxE8hhSiakw4mRBN7MEZZcstbfNTbAnY3lmdeR/
         FEfw==
X-Gm-Message-State: ACgBeo1DNlRU6hhP7Y5il5nXsl1H80KiZsgEJ6U5t9qSqxiqN3uxI1jI
        ToDuTMMMUlKX/U7ObGpvf29e/Z/2sZ4tcg==
X-Google-Smtp-Source: AA6agR4y3RD1NvAN3ZA8oOYk2vgtlTwRKIPiZ53DDPi8FwNqHLw5zfyOt6p0hYxJr22f/z4wB5dP7A==
X-Received: by 2002:ac8:5b93:0:b0:343:752b:395b with SMTP id a19-20020ac85b93000000b00343752b395bmr16220770qta.20.1661896986197;
        Tue, 30 Aug 2022 15:03:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.14.119])
        by smtp.gmail.com with ESMTPSA id a15-20020aed278f000000b0031ef69c9024sm7231190qtd.91.2022.08.30.15.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 15:03:05 -0700 (PDT)
Message-ID: <630e8919.ed0a0220.d4cdb.3dc0@mx.google.com>
Date:   Tue, 30 Aug 2022 15:03:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7489453331792246714=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: profiles: Add remote endpoint path to SelectProperties
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220830205411.68299-2-frederic.danis@collabora.com>
References: <20220830205411.68299-2-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7489453331792246714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672595

---Test result---

Test Summary:
CheckPatch                    PASS      4.38 seconds
GitLint                       PASS      3.09 seconds
Prep - Setup ELL              PASS      26.12 seconds
Build - Prep                  PASS      0.79 seconds
Build - Configure             PASS      8.24 seconds
Build - Make                  PASS      729.97 seconds
Make Check                    PASS      11.04 seconds
Make Check w/Valgrind         PASS      285.49 seconds
Make Distcheck                PASS      236.03 seconds
Build w/ext ELL - Configure   PASS      8.53 seconds
Build w/ext ELL - Make        PASS      82.32 seconds
Incremental Build w/ patches  PASS      292.27 seconds
Scan Build                    WARNING   513.47 seconds

Details
##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
profiles/audio/media.c:1459:6: warning: 8th function call argument is an uninitialized value
        if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:3005:3: warning: Use of memory after it is freed
                release_endpoint(adapter->endpoints->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:3008:3: warning: Use of memory after it is freed
                media_player_destroy(adapter->players->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3 warnings generated.




---
Regards,
Linux Bluetooth


--===============7489453331792246714==--
