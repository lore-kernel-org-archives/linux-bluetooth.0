Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860F0C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 10:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D08720791
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 10:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ+v4f62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgJ2Kiv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 06:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgJ2Kiv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 06:38:51 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22398C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 03:38:51 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id p10so2501846ile.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 03:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=WcMJy9DyfnhL9GdsrjzdXmeowyjRZ5QFa02p6AxrilM=;
        b=OJ+v4f62g9zIXcT0aLy27j0/izIofRCpJllUr7vwB3sUSMz1OeoshpSumus3+W3Igt
         lTtFfTGojfW2PK+whvPYFMX+Y0mwEpcGMUH/JVWF2RGsbK6SqgDkEEbJBZxX1L35F80U
         CO4Xf3TK2YZyNoS0bBit6plldCqtDo4PrRf/W3nx+qR1z0lRim+c5fUFtDXfEgO9MojA
         y0ZqplxLnbxIItaTEqay3aGPzcZgn5uPKmCEyRZn9JtijScL4PANhprEml8wePzoGdJH
         ewtG1a1BHtG79L2o4FLK0kjDzVaQb9iF/o7pQBs8Qz6j8XobbJjwEQskH+UR7W/Ywvp6
         r2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=WcMJy9DyfnhL9GdsrjzdXmeowyjRZ5QFa02p6AxrilM=;
        b=I66ATHiF1MwL623GEqh79qIvqJueLt6dUg3BWwDR3/T6bcR8lKRfmGhHt5c7dpT20i
         AVq0sst7tvbg4rhJ8HPl8saIW2S0X1DWvTRvwQ8s38Iyv31nvTYTL/JH6EDJjhhpHKXC
         YAc6ergUmPzNn9vuNAA3anPouivUJhyFXVMndtuAE43kNIKwK2NzHCcZnJYQYIxcSfDU
         DeBwrxYqFKm52qqxbNjXQnLKM8fKCD+3X3yzNINsUE/ogmCgcBNV3CQr4Q5h5Pk3YtMZ
         3D0ndThJq6tXEmvfeoRsFxXGD0qn03fQ0gEoiCWDQu5U30LASF3Vf3sLexE5H3lREPPc
         TQ+g==
X-Gm-Message-State: AOAM531qIzlJLxAecwfFNzs9+UFwOZecllA0lnnEv9xWKZqGNFOE9F/4
        WZ9I5GTJPp61a8EzY1MP8tLwwR95R32bQw==
X-Google-Smtp-Source: ABdhPJxiG6L5fGIYtG6ZS1pJJolY/IxxjAS94D8XLVcsgMsjx9HmztjPOEm7csTTwMEg37ymkVmr9Q==
X-Received: by 2002:a92:1f90:: with SMTP id f16mr2592230ilf.296.1603967930257;
        Thu, 29 Oct 2020 03:38:50 -0700 (PDT)
Received: from [172.17.0.2] ([40.70.76.178])
        by smtp.gmail.com with ESMTPSA id o13sm1715207iop.46.2020.10.29.03.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 03:38:49 -0700 (PDT)
Message-ID: <5f9a9bb9.1c69fb81.ed651.85c4@mx.google.com>
Date:   Thu, 29 Oct 2020 03:38:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2650172682000502684=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [BlueZ,1/3] monitor: Decode ADV Monitor read feature command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201029180756.BlueZ.1.I3e9cc07cf60d04d69c8045c442b6cf9f0c3292e7@changeid>
References: <20201029180756.BlueZ.1.I3e9cc07cf60d04d69c8045c442b6cf9f0c3292e7@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2650172682000502684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=372967

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============2650172682000502684==--
