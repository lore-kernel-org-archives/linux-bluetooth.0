Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE01EC4361B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 19:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A376B23406
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 19:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgLQTdr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Dec 2020 14:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLQTdr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Dec 2020 14:33:47 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77F3C061794
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 11:33:06 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id 7so20986319qtp.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 11:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=DwovOKj4NzFpL5+x+7drRyM3S5maAT0v84BhwLR+660=;
        b=rlI0HUtyd/UwToJFPa9FX9YW7vQ1ssVG7Cabt9lBygQJGoSnesD1YCb1Z40YbcWz9z
         kJxZBCOT3sAYlSwwDEmsaq0gXpDHMNFflkjEbgy1kzfhRV54ww0335uzXhlpJ575vcpW
         05IHWPx2vGvmkK3LTYksZr1HSCyJqmxZjjzvrKnZbxlnvgBtFHcDVKHDOtu/tQivwU9u
         e+KpQjbV0xddfpJxArL52NjLeMLtehSWnoWfqUlAcF0+nUwzZmHsR18opurWO9Bd64m4
         h2SKvFECSKi7Pe5eMjwPnS12PGAb3yERO3XrfkbX3zgrVh3t8H0DjKEHEWN0Jyuz3ym2
         TT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=DwovOKj4NzFpL5+x+7drRyM3S5maAT0v84BhwLR+660=;
        b=R+VoTyM90YZsIjojjLZS78noevlLfoWsqVXwNrRIevLRuPU2S76RzsFsZn1R5Fws+n
         DWUo8Xbrk4v3VnXU+IRMEq8kDFQqaQlOPtw5itVi/cM28EASOV5duxe3IIjtObQD61kX
         oYfylXsJGeoCJ0Gin+bsdh9wS/BSCrwB+OJNZGTX6sG4wxT6aaqIZfJBICfTyjT/Rgdz
         yEUkL1aNVH2PMZqzgGd7ErzKvF6bZW6PkR7xXuGfTf3mpXBX0Jktfe/eOqTKZbr4h3rv
         YpF++b++9/oOLZjDqTNsX8vto/JBCFvClWflo4LKJNnyeZEbc49HITQdqgqPXEBohzPw
         Bd+g==
X-Gm-Message-State: AOAM530Fxn93jozgjHTZpqTUxRzs4ZlF2VIH7H17iN7CKh/IYqi6+2Fn
        zVuYF/KZNJ+7ak9PDcmGpqNdYBx1THc/SQ==
X-Google-Smtp-Source: ABdhPJzYeRhHVH95K8/OmLdCisXTubPnEERakHLxtUpAPIMj8d8TIN6F84i/lkVki1ZW0Os9cF5OWQ==
X-Received: by 2002:ac8:5acb:: with SMTP id d11mr304080qtd.269.1608233585950;
        Thu, 17 Dec 2020 11:33:05 -0800 (PST)
Received: from [172.17.0.2] ([52.167.129.189])
        by smtp.gmail.com with ESMTPSA id f19sm2545283qta.80.2020.12.17.11.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 11:33:05 -0800 (PST)
Message-ID: <5fdbb271.1c69fb81.6809b.f91e@mx.google.com>
Date:   Thu, 17 Dec 2020 11:33:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7505102982257539298=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] btdev: Add support for multiple connections
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201217185357.1354172-1-luiz.dentz@gmail.com>
References: <20201217185357.1354172-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7505102982257539298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=403793

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


--===============7505102982257539298==--
