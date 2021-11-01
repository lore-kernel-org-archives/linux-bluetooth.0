Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56D3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 06:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76CE160F4F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 06:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhKAGo3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 02:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhKAGo2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 02:44:28 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190BAC061714
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 Oct 2021 23:41:56 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id bp7so10425773qkb.10
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 Oct 2021 23:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=BO2v0JTeBweGhuVnoy0dTehpO7VcFlDSNN5SwWPLKgU=;
        b=WlWGE4WiQk128RUAT1OL9NdGPiiSBbKZcLOzRi2ulS03u2SF/jEryU3sm561o1iS2v
         ep6UNKiDnbcystuELgzf96Za3xVJEQcCn6VW/4ZfSIVzDaMBDhC7SZ9+1KLEBU3Rbrpz
         yaDgS1VbpG0RcBbjK6NfHJpLshLC2PwDDGSglzNpVAEzouRWdXHWrD4NOBLSoV97dCJf
         HOoqfx9ZgysOXvypEXfJaIHPLZzittKHVqdYFcbqf9HPG1WFO2s+c1jKseu5dAgLAr4N
         SdUMOhsbWUFNv1ayXGwZnlaCWK0QEZNqt24uYMhsZprVtaPdQ17LFHuwNGocsMFGJaX6
         VrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=BO2v0JTeBweGhuVnoy0dTehpO7VcFlDSNN5SwWPLKgU=;
        b=F5B+jvoOitE8mTmqQghYCGKB1Ko2RnE4GK0MOnIMPOM2dapY7Ent/FQ7dIHty4xlaB
         CM4dNydi6K8rwp1Za1g/0NMjaCY0xRNkm8VdwPEG4W+jonYQ2AjKrNf4PW4Zuv359PB/
         bCi68QLb7MTuH/dA74Ugo8nqxiySxOznHjFluhUUpnQChQJByYcgWYjyUqocsgQ7h/XC
         +66QpujsbpDeBums0WGNy+FLdjwdQanc/pO7a3uqxqKg4vSAZNdhKJsyO9cGf0T6wPmK
         wPpfwDQoh6CspAs/yJJheVI47vp/sdPJDVfi2zMVHG8hZXQld4/2ZVtxP/EFNNnqJ57z
         k5nQ==
X-Gm-Message-State: AOAM531YIUGdODS6gNBSbQfs7GHCdcglO87nfi8H8mEs7SfqIOEW+DVb
        x40fl9toynAajWBz5BOP1WoYhU5y8bD3dA==
X-Google-Smtp-Source: ABdhPJxJqb5SLezOfsnmrN1rYdpCUtx8TC6hZCIT5xcKKTiTuq4QOHE6AtDSIBD8W3ZseTIhxOyS1g==
X-Received: by 2002:a05:620a:16d6:: with SMTP id a22mr6966022qkn.261.1635748915158;
        Sun, 31 Oct 2021 23:41:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.190.121])
        by smtp.gmail.com with ESMTPSA id v15sm10258026qkl.91.2021.10.31.23.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 23:41:54 -0700 (PDT)
Message-ID: <617f8c32.1c69fb81.8d919.e570@mx.google.com>
Date:   Sun, 31 Oct 2021 23:41:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2386146915397749538=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,1/3] adapter: Use PeripheralLongTermKey to store LTK
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211101140544.Bluez.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
References: <20211101140544.Bluez.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2386146915397749538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=573377

---Test result---

Test Summary:
CheckPatch                    PASS      4.10 seconds
GitLint                       PASS      2.80 seconds
Prep - Setup ELL              PASS      42.57 seconds
Build - Prep                  PASS      0.50 seconds
Build - Configure             PASS      7.91 seconds
Build - Make                  PASS      182.22 seconds
Make Check                    PASS      9.23 seconds
Make Distcheck                PASS      218.49 seconds
Build w/ext ELL - Configure   PASS      8.01 seconds
Build w/ext ELL - Make        PASS      173.06 seconds



---
Regards,
Linux Bluetooth


--===============2386146915397749538==--
