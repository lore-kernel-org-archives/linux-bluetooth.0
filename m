Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFCBC63777
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 17:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3475D20857
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 17:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/Jwx0vX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404022AbgKXRtt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 12:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgKXRtt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 12:49:49 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B33C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 09:49:49 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id u4so21538206qkk.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 09:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=cdxelZWUKt9EwdoMiYsyDKrhzvMWWpnKg+jhYk+h7N4=;
        b=B/Jwx0vXlMomI6Kp9kWJ2XLsOm6MJ7vTKdJEPzSGyy/KofOdOYmdxo49zKSftZ+oxf
         3a346h60FUSLGi1ajrn2NIYnqTmTbvuFcXy19Nv8uPzqhegBC+HdnUrfhsRUuqzfkkon
         JWxVv3Fo3ZCE3RWwKSreAhwuIZFeVt9aRxHcNcXelkOs/+A6udgBP8xbZOfamtsjTsiH
         0+ZW7p3w6NW6EaZvuy099G3vxsI+qj7vv9cYswZy1CxYXXLy/3AXqeyApPrMibMtuIwq
         9ltkT6Z8RKQzwCOW6xxePb6YzBiSyrfbWwuHyyW2t+notF5OZu2+g/LpEb3aUUPeo0FK
         0naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=cdxelZWUKt9EwdoMiYsyDKrhzvMWWpnKg+jhYk+h7N4=;
        b=SZSKOkjlNMD3dBZvPbEDSuyrFR81oD0fDPKDlvJ+5W/Kv/kP79hoNwa9uoy0EyoKml
         aR7r5+84WMS0pJ1SqjDKP1DADYXehF49z19Roy+QhKrIyT3taIYV1RvNYZrUvjRGhmAw
         XWEEFh2yIeH1DNFLH2oeD+JG1fnw6X1syh03zDxiVWw2E/bGIWwJAdvg8MlDOU5bFyjZ
         f2MEJn8voThuukkO7iYQ0MkuFeMoJQxDWRk4rvhR3Sj9wGukn0jp4gPqJtTyVvJjfgjk
         kYA1ZSMVjM/5PLn1LCM0s4F8xl8arIj0YPDiJVCc8slTFDshTT48h30mQ93fzUSzC6Rs
         ptiA==
X-Gm-Message-State: AOAM530hF4uqUSEqRofqRYfQYpNPQJ74mzZqA2RlKa0jHwGSZyXigW25
        89RW1d/tVCrBQuavf5cfzy8tcLdK+yU6oQ==
X-Google-Smtp-Source: ABdhPJx3ElSxTamslDNIuILIH4k94ethKg4Lks2EAcfQ1MhOkZQ65cV0ygc5r27TDVpD7nhiWgH/zg==
X-Received: by 2002:a05:620a:20c9:: with SMTP id f9mr6110553qka.378.1606240188526;
        Tue, 24 Nov 2020 09:49:48 -0800 (PST)
Received: from [172.17.0.2] ([40.75.107.77])
        by smtp.gmail.com with ESMTPSA id t2sm9614150qkb.2.2020.11.24.09.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:49:47 -0800 (PST)
Message-ID: <5fbd47bb.1c69fb81.64010.62fd@mx.google.com>
Date:   Tue, 24 Nov 2020 09:49:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4098499183067933962=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, danielwinkler@google.com
Subject: RE: Add mgmt-tester coverage for new advertising MGMT APIs
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201124092549.Bluez.1.Ia11a74cda6aa978ddd357bd37b1f9b0a363ba8bf@changeid>
References: <20201124092549.Bluez.1.Ia11a74cda6aa978ddd357bd37b1f9b0a363ba8bf@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4098499183067933962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=390411

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


--===============4098499183067933962==--
