Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F565C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 19:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3518C61A28
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 19:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbhCXT5t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Mar 2021 15:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237911AbhCXT5p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Mar 2021 15:57:45 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B71C061763
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Mar 2021 12:57:44 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id y5so17807063qkl.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Mar 2021 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=QjT4MNF/GQFrMYpaGtWgeyK6KLQCFFhk8BFu9qzOia0=;
        b=hgNE8IqGCx+TTMug9c1wLqpjq1an9Mx620tVy71dYu+w/5ZkB40iLitovskm/0Mm6p
         n/m6DspifsDR6fpKlUqltQc+Qtxb/NHznITwANJh9HixNGDJXr+zECRDKCTIyLC+ws63
         aBPn3GE3X3TpLIBEHpWIAXpTwFxWbOsP01km7a3ln8dgpWWe+EonwSl9ed42mQWviP24
         JgTnJkPahfFJvdW6iLNzC3e7tx+16zvX3Jbg8er1Uag2fLqnzznQZUxfeSfpYC2OGK9V
         DTYr9KlBwBg2u2DfdHempiO6ZTp9OksBTkiDPxNKVgsY65WKirLkNh+z90TzLXWQrd6V
         TdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=QjT4MNF/GQFrMYpaGtWgeyK6KLQCFFhk8BFu9qzOia0=;
        b=Ypv88AzavBZ6tqA1zFqTYwJrtQW4MpNHbow7h1CCLSXW71ODix8J5MMqkK2ZSgo+rM
         L81WvG6yR2x+j0oHEHFOUZYEzSOtbmhn6itAqvpObmQ/y+CrcfgnViSH0o+u76hUMqQ8
         o3GZ5np1vz60kJtgAljrQRQpxlsELx9k6joq5YGxY9T3DH6b4J058c95mERB8ZGK7wEl
         grYsnzwxcGblkPQaVar6NtaxTosbqGTJ6FPki8HhCY7zxW7AnR0r1BCwPpUT2l1pxsNn
         fzFhUJiNLDfRajuLQxZCLYMMQAAGBCrUAk95ZhwlnnZyLvNGGgpIWRIcCGyM4Yho0i6e
         y0bg==
X-Gm-Message-State: AOAM533v96QtCFe3SuFSrgY5Uo5yXImIV4P3gWZxX/dpjndMflXRL+iv
        tn8cZOAWhbRCMIK+E9wgJTi0JE54YsArmw==
X-Google-Smtp-Source: ABdhPJyL8GqEYghYEOwwFOUSgMwp1VP7r/OW72knxpMi64WzT0VtFquPNNTZ43Wzu3F1WuPlI8jX2A==
X-Received: by 2002:a05:620a:124f:: with SMTP id a15mr4779597qkl.125.1616615863886;
        Wed, 24 Mar 2021 12:57:43 -0700 (PDT)
Received: from [172.17.0.2] ([52.152.177.149])
        by smtp.gmail.com with ESMTPSA id g11sm2539034qkk.5.2021.03.24.12.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 12:57:43 -0700 (PDT)
Message-ID: <605b99b7.1c69fb81.d85d8.f8c0@mx.google.com>
Date:   Wed, 24 Mar 2021 12:57:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2045140975218640904=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] mesh: Fix segmented msg RX with friendship
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210324193412.488233-1-brian.gix@intel.com>
References: <20210324193412.488233-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2045140975218640904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=454865

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


--===============2045140975218640904==--
