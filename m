Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433B8C00140
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jul 2022 16:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiGZQLc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jul 2022 12:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiGZQLb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jul 2022 12:11:31 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8420BB1E7
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jul 2022 09:11:30 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o1so11291089qkg.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jul 2022 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=g3Nwl9D3JOMpsuUi7UWykeap/lzveLD79dTRRX/R2Mw=;
        b=ETM6wfzXb4ylCsxcLIGvz/uA1JB50wRpd2WH2aqMgg5PrUkpaSUV4M7wAnGtZgk42a
         Lc5yh4QoqzrOIdVb8LQq+jvvtKGsbmozCAIIz9bNJuFJ6dfLw8GzR/2TSP7P58F0hhO1
         MtqWzQqMBaZ7KhlUF2b3aZ4IgvpoP4p9jwgAvao5CQwbK85Ott9tED5TPoV8AZvqM1yb
         k3YWXBGfSFd4BsTjZ81IEgXXBoXF9y1Ri+drkVwNT5K09t3f3PFERpaOXv3oWCS3fzl9
         QHC/tU8CkndVKLGYE6gHLXwEMftakodV6SYsmf5XVEGofTdTiZjBP1Y2vB3DpxDBMby0
         OhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=g3Nwl9D3JOMpsuUi7UWykeap/lzveLD79dTRRX/R2Mw=;
        b=av+1DkfH3T2Z36R/iFl6vJpnndmlPe7DID6XlPdZDtiVCXszSq/dpRpKQmz4Xs6kvq
         spEiberunU5CiO6YYuw4K3MsWTf/97Ls9V1Du41BuFmkU6z+ZD5FEYyEZMhdj/0jaCJp
         bXDMh8p6vsrb4kI54d/UgfbxQKOUSYtab8NGncXMlNHguDAJWXRAr8wgz4SUd4J1BjAk
         VDHcscLZ/pmERIxVjTM/VeRnM+jUJTJ5oCyeKErzRaNWjS3k1yseEDmC7MPBRLhkJ2O+
         G1hZdMTcXQFRcYe/cc68jBLsl8SIqFl0yhjaU9ssClMlpP/ZfQ1/0o9vFi8sAHz+1waP
         mQ9Q==
X-Gm-Message-State: AJIora/EmWZcDvvMaymcKANm2Vq8yt7wu4xBnezW4tgT+pYN2DKKjxuZ
        LCLmI0BKg4k9nM6Zr9VWqZDOJHrADx0=
X-Google-Smtp-Source: AGRyM1tmOGzDNLD69yB3YUJOEsUQ+V6sU6dvCdz/xMLFGcz4Rw6Xo/6pvj6Z0mmNYuDBaSF8TrYUbg==
X-Received: by 2002:ae9:e704:0:b0:6b5:6bb9:48c3 with SMTP id m4-20020ae9e704000000b006b56bb948c3mr13575857qka.618.1658851889277;
        Tue, 26 Jul 2022 09:11:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.200.114])
        by smtp.gmail.com with ESMTPSA id q20-20020a37f714000000b006b5e60c4de1sm11141452qkj.78.2022.07.26.09.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 09:11:28 -0700 (PDT)
Message-ID: <62e01230.1c69fb81.1b3c2.d592@mx.google.com>
Date:   Tue, 26 Jul 2022 09:11:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2446522617011399814=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dan.carpenter@oracle.com
Subject: RE: Bluetooth: mgmt: Fix double free on error path
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <YuAEqGGp/SRNP2Nr@kili>
References: <YuAEqGGp/SRNP2Nr@kili>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2446522617011399814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=663130

---Test result---

Test Summary:
CheckPatch                    PASS      1.91 seconds
GitLint                       PASS      1.22 seconds
SubjectPrefix                 PASS      0.94 seconds
BuildKernel                   PASS      33.00 seconds
BuildKernel32                 PASS      28.54 seconds
Incremental Build with patchesPASS      41.68 seconds
TestRunner: Setup             PASS      478.13 seconds
TestRunner: l2cap-tester      PASS      16.71 seconds
TestRunner: bnep-tester       PASS      6.27 seconds
TestRunner: mgmt-tester       PASS      98.49 seconds
TestRunner: rfcomm-tester     PASS      9.46 seconds
TestRunner: sco-tester        PASS      9.30 seconds
TestRunner: smp-tester        PASS      9.38 seconds
TestRunner: userchan-tester   PASS      6.41 seconds



---
Regards,
Linux Bluetooth


--===============2446522617011399814==--
