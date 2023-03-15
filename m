Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47658C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 10:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjCOKq6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 06:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjCOKq2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 06:46:28 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4975288DAF
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 03:45:36 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id cu4so12105605qvb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 03:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678877132;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QTNxUOsopsgHi6eyPQimzUe9EuGTFH5J0p78sFCVrSw=;
        b=dSaoX5L5avsP4GUXVhwnz4G0ovow0uOtI7sbVIY/1Wm2ZRzXA10E0L6D9pVNYBv0ow
         MKW8lUudKVmDrEpSPLanj7ihbVHWJwYGNcm0UGIzJ/SmrlyWRSRZZ8LUkcL5cU3HkywC
         yewqJSbYquRGzFHbwLRDBbAo92HFXq8dC50kObn3jmeuetlJ7hC01r7pSHPiK2VEhwNy
         UhgKVkrneFByrcMZy3TFoWZLEMh+Bh1RkJt9zjIoaO1YHOqg9cOGEqeSLpg7GoQxVTy0
         KMuCYh64H5+AFDbDIexEQWsXWM5DsuQkemDJXw0zHo7UfYlo0zBnF9+oeEwTI8dY6Ih2
         DCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678877132;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTNxUOsopsgHi6eyPQimzUe9EuGTFH5J0p78sFCVrSw=;
        b=OHPopyuAhlN3o4C0pu0moLGMC6StqnbMMIS6jHSFwp1nLyGqNrokJcF/WfXhLwujwq
         GP+ChLr9SgkGd1BfPptqPM8Rf472FemSng7yVhe7ovdbNOYNKRDVlcixyUIQpeGQN7Lx
         CCOTWXWgplTHH7PPS/Ll4arWmhn9zwzY4beYiWGYa/Jb4N6bJ9fA/5tgkqipyFzV4DX0
         0Z76PQXvZRbICQp5z6h94IVG1eXgVcsy5Em15upP25QOcLmgzx6hE5rVx3StuZB7feoE
         hyP4TZAtZdnTDKQidsCbQ+ZnKaA3VtXhMPuHVl/P+2cmMXMuLX4SU8VfFJuYKnE3TGm2
         fxmw==
X-Gm-Message-State: AO0yUKUqr6z+WQGOO8LNBe7JJx+6yFmyuj9HKWNJ0sgIEsyHdZvgoiZQ
        c2AfQes0j/mYq9FQI78GHdnelPghUUo=
X-Google-Smtp-Source: AK7set/Mkvw2LBENH5WRdAv7qD7iv127GwcVaNJBY5rdCS0edvcXOgH1FOv+6x3eRRhn8sS2YV3/xQ==
X-Received: by 2002:ac8:5b93:0:b0:3bf:d179:f964 with SMTP id a19-20020ac85b93000000b003bfd179f964mr39723041qta.34.1678877132299;
        Wed, 15 Mar 2023 03:45:32 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.57])
        by smtp.gmail.com with ESMTPSA id g28-20020ac842dc000000b003d460ec242esm1459945qtm.81.2023.03.15.03.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 03:45:32 -0700 (PDT)
Message-ID: <6411a1cc.c80a0220.43b3a.4a6e@mx.google.com>
Date:   Wed, 15 Mar 2023 03:45:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0150796764276225998=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, aarongt.shen@gmail.com
Subject: RE: obexd: reject to accept file when replying reject message
In-Reply-To: <20230315092954.4182-1-aarongt.shen@gmail.com>
References: <20230315092954.4182-1-aarongt.shen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0150796764276225998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730242

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       PASS      0.36 seconds
BuildEll                      PASS      32.08 seconds
BluezMake                     PASS      982.20 seconds
MakeCheck                     PASS      12.92 seconds
MakeDistcheck                 PASS      182.92 seconds
CheckValgrind                 PASS      294.99 seconds
CheckSmatch                   PASS      392.56 seconds
bluezmakeextell               PASS      119.40 seconds
IncrementalBuild              PASS      803.68 seconds
ScanBuild                     PASS      1223.38 seconds



---
Regards,
Linux Bluetooth


--===============0150796764276225998==--
