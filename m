Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFC0ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 13:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiIWNx2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 09:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiIWNx1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 09:53:27 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B0E13D1C7
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 06:53:26 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p3so10310272iof.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=lGFmE/I1VcTZiRYpIrMPyiirkvZOlba5zXBKKYiVot4=;
        b=egu+aZ8SzkwRtQJ5foRpQhPSzQrSWyX4DLjJynxJaJ6gZeils9TaZYOJx4F0CBqeZI
         OVALf4H4PFbOH+SZ2B/NoKqADpRSxb/5imEabZUDDdCu8k1Z6cKBZm7inp8VsyXs0lbj
         3YcIk9NtC4s0wEbuqATl9i8/rnzPrQnWCVmjOCiR8J1G9aojx9BLXAa98bfl/wDmpoqh
         ziang6pOBvZnL4ZERF2wGwWkL35mCnwxaetNJWenHQUTeCDDVQqyF9g/QvcEAOSLOrKF
         VrECxONl+1t4oDevPCorVhdm2rn8v998kDVIESOqnBeM3wpXGEo+v2Gbw6CKEa24Ri2R
         c9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=lGFmE/I1VcTZiRYpIrMPyiirkvZOlba5zXBKKYiVot4=;
        b=BMhgNOE75ZB1JvNs4AFDgncExPgfs6WpWUVaemqfGDJq29+nG5J8J2cDoVfR3QVECL
         bf4TSXC7uKQYIDJt43AJ4RJtfPHJmcvlEZFNs1BwyhBIhrQ3/ZVb9agsxIE6gJNyoZWy
         jyxr1Ti6ASO5taT9lNZdbS+6A7VZBhaBuHNWvgHuYJ6fp4ScJCJe0YVcMUvDzLy/EttD
         SkDlrhCZFtX5n/5P59mT0IZ7TlTxgDz0zQpiIZwfjp2Y39oeUa09v/MOehdduBZgSpP4
         gR9w78jqwlJY2Va23nwT9+bC4FhrJJP53RVr+DNcXtz3Dx6o4qxg7nZ6g+8xpDBOQ5K6
         LkSA==
X-Gm-Message-State: ACrzQf10J2idSfGiwnAz5SX0ecCWoxM2+3firaJ0IEMUWh/DUTBt6nop
        KfbQVmTU9Y2iZGdhAKUCqUhgiG3rIwJ1JQ==
X-Google-Smtp-Source: AMsMyM5k0EwQG8ygDS3/FRcuxvKlj2TB7a4Ktji/a8t5qafx59StdzqesQPi0UT184dfVufBLLr5qw==
X-Received: by 2002:a05:6602:15c6:b0:67a:33d1:6c73 with SMTP id f6-20020a05660215c600b0067a33d16c73mr3922901iow.156.1663941205587;
        Fri, 23 Sep 2022 06:53:25 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.44.157])
        by smtp.gmail.com with ESMTPSA id 7-20020a6b0107000000b006a175fe334dsm3590316iob.1.2022.09.23.06.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 06:53:25 -0700 (PDT)
Message-ID: <632dba55.6b0a0220.fd51a.4b5b@mx.google.com>
Date:   Fri, 23 Sep 2022 06:53:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0773020243984235964=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, isak.westin@loytec.com
Subject: RE: Mesh: Fixes to comply with mesh profile
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220923113149.14209-2-isak.westin@loytec.com>
References: <20220923113149.14209-2-isak.westin@loytec.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0773020243984235964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=679853

---Test result---

Test Summary:
CheckPatch                    PASS      2.24 seconds
GitLint                       PASS      1.67 seconds
Prep - Setup ELL              PASS      36.89 seconds
Build - Prep                  PASS      0.81 seconds
Build - Configure             PASS      8.60 seconds
Build - Make                  PASS      1240.83 seconds
Make Check                    PASS      12.09 seconds
Make Check w/Valgrind         PASS      400.43 seconds
Make Distcheck                PASS      252.41 seconds
Build w/ext ELL - Configure   PASS      8.77 seconds
Build w/ext ELL - Make        PASS      139.00 seconds
Incremental Build w/ patches  PASS      314.75 seconds
Scan Build                    PASS      873.87 seconds



---
Regards,
Linux Bluetooth


--===============0773020243984235964==--
