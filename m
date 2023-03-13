Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C6AC6FD19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 21:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjCMVis (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 17:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCMViq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 17:38:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E8A898E6
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 14:38:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so18284323pjg.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 14:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678743524;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0TaW7ec1fqgL+t4li5x7ttTLXaSoo2gL6JFIjr9B7pE=;
        b=LRQKxOeFYTicqbewCXkduYLUQP8J/yPjSy6fntV8ZDwK3oJwT784l5yR3Z1TQ8Ks0F
         aivQqMXkjwZMueUA/7LCoTsI6u8MU2WFXJciDPVcEuRnO/qkjfgATmc7u3o04lZhF45w
         kzbZ/ainrrRvuzwhxZ4YFCxro+9aRTFFFTUyMx9z9DV0OMGsWqLpDFiFQzBWv5MuzYtf
         18fIrMCPBqIgZBKs4TiMRHi2wzFNXklBFmj428rIh3W3s6dg/+igpIhbkaED3XnciB68
         3+JV5aQ7rbT1AB9zek8Q8sQV1zcPKsuAq98A6L8mVNFuzH1QOoDejcR2b6ghny6j4JM7
         LTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678743524;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TaW7ec1fqgL+t4li5x7ttTLXaSoo2gL6JFIjr9B7pE=;
        b=s38fbPi11exeebAN+5YKjZv87nJm+Kno9jUWkOP6RVd2B5NFJv4ALt6QMWnP7iefPn
         y++fBXxFXLWEeYPV9YikXEif0Vh7P+naLSaNNO58OMJrwRlEhT67KfkYfJXNsxf5YOUo
         tfPAbCC86Fn5Xt83gNOe1WU9Br0QfYX7lCbM8t0YhsU04oEEO9CF9z/zF7vZ8nIXpECF
         1CdVUhT3XeYWT8/zSYHsgTeXgly0iHyn71uBOiPlmNKI+TxLt+768Ix59KjbNTAO2nN8
         SFIResYEUz6DeJRLLlLrIHQBaaxqcJIMtxyW9pGvvkHCk57NJ/lHP/MLw0Dhh3/nBNkV
         YDBA==
X-Gm-Message-State: AO0yUKVCHF9hOoVMS9i3+IFnwCVQfAv/+sPzf9k94WU2+m0mIZvn+D2t
        2uBuUpoRSe51rQUg8HIiw9dVlPe9zn8=
X-Google-Smtp-Source: AK7set9iy19Zyi7vFcLH4cCO/hf5nwkiE5e8c/vat4rLWlBiWmOmtmJMg0uPR2duKsvSYeacuLgZUw==
X-Received: by 2002:a17:903:18a:b0:19c:df6e:6aec with SMTP id z10-20020a170903018a00b0019cdf6e6aecmr12573697plg.7.1678743524397;
        Mon, 13 Mar 2023 14:38:44 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.71.23])
        by smtp.gmail.com with ESMTPSA id v3-20020a654603000000b005033e653a17sm172351pgq.85.2023.03.13.14.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:38:44 -0700 (PDT)
Message-ID: <640f97e4.650a0220.af7e.0f7f@mx.google.com>
Date:   Mon, 13 Mar 2023 14:38:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8478376440349711113=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@gmail.com
Subject: RE: [BlueZ,v2,1/2] mesh: Fix uninitialized memory usage
In-Reply-To: <20230313200048.50855-1-brian.gix@gmail.com>
References: <20230313200048.50855-1-brian.gix@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8478376440349711113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=729593

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
GitLint                       PASS      0.49 seconds
BuildEll                      PASS      31.84 seconds
BluezMake                     PASS      1012.63 seconds
MakeCheck                     PASS      13.01 seconds
MakeDistcheck                 PASS      180.85 seconds
CheckValgrind                 PASS      298.04 seconds
CheckSmatch                   PASS      393.38 seconds
bluezmakeextell               PASS      118.65 seconds
IncrementalBuild              PASS      1648.88 seconds
ScanBuild                     PASS      1223.47 seconds



---
Regards,
Linux Bluetooth


--===============8478376440349711113==--
