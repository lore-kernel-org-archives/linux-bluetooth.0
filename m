Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462A5C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Sep 2022 05:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiI1FjB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Sep 2022 01:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiI1Fi6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Sep 2022 01:38:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404CF11A68C
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 22:38:57 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 9so11554607pfz.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 22:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=buQfTgMikWcGSzj7BYA6S293noe+rZTZJSfpjwh4pJg=;
        b=NzGVmaeFOaTWw/I6hfA8/oDfzizfXBaZuPS61rPEZ2KgRt3MVKwlacUM5GBFB+QOE6
         HtxzKJ54u3Fx3mLXzHC28uOs6MnAVvakX1yLLEjHsCV2hGDysW/FEAQgt1nuGqoAwjO9
         0+/XLuPVIusoGbkrWwPAASUa1LydZSBy1YKwnPMBqcxZoQNsbM8nBNkWPCzT1lambdsW
         niXJ4vdUhhP8AFJEJMjT8mOj/AyPe/BSKWA3eVwLnLX4/+Zd0+cc8qEQM9G0nIA6X/Wp
         3Hau+T3rIAUoQNELXxgLbNIn6ZDLWcw+HpbVKyunnVXCTt3n1oyU8BGu6TAGbeaOoD9q
         hV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=buQfTgMikWcGSzj7BYA6S293noe+rZTZJSfpjwh4pJg=;
        b=WJd2owroym1m9/GXBYcGTE5zVs4jgKTIIN36RQCYfpLlBE6fMOAFw/To1b2N7vB7VB
         86KAXcoUaSF0rqidNzg+JNaZQqrxd/w36UmQL6M9bFCNHuYoQxClThDKW2XCqLm+qvjc
         oY7bfIwJMohQhYROq/tB8DY6czo3NBx4rbhKnn2VaqiRpX7neMhYMjU3Qo2w7XIgV5O0
         8Lsx7b9IhCdrtCK5/ZDN4ykVoG208l7OG29+PYEGmeAK88FV+QpvGm77junNMC85ApvG
         pJ8kqWGwrGacu5Ostx4626P4IugJR1YNeU/osGNsYtBINO3BnbqbZlsrY4Zr67yuMv1X
         ffVQ==
X-Gm-Message-State: ACrzQf10UlNh+ry4CsIQtHvYe2GoarP9fuGmaG/p0IVImKTSGFJfcbrW
        QS44HjbHrzVEFfWnuCW3hJ/pp40q8USdvw==
X-Google-Smtp-Source: AMsMyM5kVdlZDXzhDhy3+4ETIHE0C6YQAXkCvZZBoBIAhjKLidDCsywBreuoV/lGnyVh+4qEOVO+8w==
X-Received: by 2002:a05:6a00:4006:b0:53e:815a:ff71 with SMTP id by6-20020a056a00400600b0053e815aff71mr32808256pfb.4.1664343536340;
        Tue, 27 Sep 2022 22:38:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.178.54])
        by smtp.gmail.com with ESMTPSA id z189-20020a6233c6000000b00546d8c2185dsm2950391pfz.170.2022.09.27.22.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 22:38:55 -0700 (PDT)
Message-ID: <6333ddef.620a0220.6a353.56c3@mx.google.com>
Date:   Tue, 27 Sep 2022 22:38:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4554727858867955920=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v2] doc: test patch - DO NOT MERGE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220928045439.210967-1-hj.tedd.an@gmail.com>
References: <20220928045439.210967-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4554727858867955920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=681301

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.53 seconds
Prep - Setup ELL              PASS      31.76 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      10.15 seconds
Build - Make                  PASS      960.84 seconds
Make Check                    PASS      12.90 seconds
Make Check w/Valgrind         PASS      348.17 seconds
Make Distcheck                PASS      296.47 seconds
Build w/ext ELL - Configure   PASS      10.49 seconds
Build w/ext ELL - Make        PASS      101.09 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      595.37 seconds



---
Regards,
Linux Bluetooth


--===============4554727858867955920==--
