Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1F1C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 23:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2E8600CF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 23:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhBWXID (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 18:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhBWW7z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 17:59:55 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1894C061793
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 14:58:54 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id z190so426602qka.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 14:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Xu2epQ1Cv39oPYgHA73WS/wPsGw20wpuwJa/+aD1lfs=;
        b=sCKdQ1WjqM0KdKC+MXOKzv9OYjOwyZLBecMVng+WgiqXE0j8sc38Hatz5gCNmb+cTo
         wzutmkcRMK+Uq9pt4PMrGo8RDPgBZvetLA2tsg+iiz/8YkKJ/8NM+FxFzl9JPwUoO+Pi
         zj7rCfQ2Jg8K8sTYiv9qzIMmzFqzx1ZpWwPOW2abbd+8oGLk7cNZaT6HZpACjow1RVmG
         6g8Nck7CtF3R+/pw/7NBgvLhyd6DN2ZZjiXfnpGQzmZpwVa8oLnc6yJy2ciKdqN9JfKt
         KC+JX8wRmO9px4Td57qB/CpxkTFBXOTlVcyseiPBIofeiOGVE40SzliFOaZNi8K9juAA
         XgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Xu2epQ1Cv39oPYgHA73WS/wPsGw20wpuwJa/+aD1lfs=;
        b=ScQkZV8b2SkqRZiLevMMD/xMUOaWgzsonwX2IPIWNEZpXoJwiOEwuSt+P+irNzoUNM
         S2ugc9avfTxKKhS088K1i0KJ/dEWId7DcLeu49NW3zQedlUyFUYeLRoOCgKvw03jijAg
         8r+J0IJGiX1Bq6ujL20RGJKLUq3/ofYkqY0xlUeH+glmknfZAC8QS6hcDAi31Ou6LKvz
         d/gU3NFRWPvm6C1z+W4GC5BQJaL0F0Nz+L+PF2ZtSmmXsS2q9RD2/d/t17oE5RBlhp0U
         P5Je9H4ITthBrjG6oACDq7RYafgb8vJx2A5g70gl9+zyO5GlFhss0cfGNA4luSKsHbLL
         08Rw==
X-Gm-Message-State: AOAM532wnvUy0V9Ef5otYmtV8QdQj1kk17F93wb8skH3BwbBCzLZACkl
        6UzF2lAXv2yUSeZlXClik4XNrANVvVbiTw==
X-Google-Smtp-Source: ABdhPJyI7g8muSD5TJagR2EZ/Y/LEcuefrIHLa7AKErfnYJxPKbBealfZms5txzeUlNhW6ESNwGQjg==
X-Received: by 2002:a37:9003:: with SMTP id s3mr27988752qkd.117.1614121130946;
        Tue, 23 Feb 2021 14:58:50 -0800 (PST)
Received: from [172.17.0.2] ([52.252.42.72])
        by smtp.gmail.com with ESMTPSA id r7sm99473qtd.49.2021.02.23.14.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 14:58:50 -0800 (PST)
Message-ID: <603588aa.1c69fb81.dd8cd.0a7e@mx.google.com>
Date:   Tue, 23 Feb 2021 14:58:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7693012356703557984=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Cleanup: replace symbolic file permissions
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210223190252.483784-2-brian.gix@intel.com>
References: <20210223190252.483784-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7693012356703557984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=437329

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
mesh: Cleanup deprecated symbolic file permissions
3: B6 Body message is missing

obexd: Cleanup deprecated symbolic file permissions
3: B6 Body message is missing

peripheral: Cleanup deprecated symbolic file permissions
3: B6 Body message is missing

profiles: Cleanup deprecated symbolic file permissions
3: B6 Body message is missing

src: Cleanup deprecated symbolic file permissions
3: B6 Body message is missing

tools: Cleanup deprecated symbolic file permissions
3: B6 Body message is missing


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============7693012356703557984==--
