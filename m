Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5C7C64E8A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 11:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137DE20663
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 11:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388620AbgLCLGz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 06:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387757AbgLCLGz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 06:06:55 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C05C061A4D
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Dec 2020 03:06:15 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id b8so1474074ila.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Dec 2020 03:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=DjFIuxxQw1K5vrm8+HOU6tM/NKkw3T04LZdVPQGM3Vk=;
        b=nQmIyNb1crJg751pqmHUa8g/PkHrveihygtI980i3HL8C2XmAUm8JdFKSbMN4hv3yL
         ej5iIeF2YtMdFh9NPHDxWne8Caid9zTgIc7bUanoioypFcIE0hbNPgWMuZEWFWbka83F
         /+7feHuy4XuwDpLd3Zz0cMvDBdKhyah+Zs/Ykj1Van2uh+IzY/C94dp6uGhmktxePudf
         32O8pTAebKjGy3wgDyz7xh/htIudUO4PGPJJHX9ILxAIH1X0NTkho+Lha2DXlhrV5DvP
         pJMmt7lQz3GjFlw6/XGz300KGYNrnHtGhTz3BnJvcXSLStXu9Ac/Yma1SparZfnPHsJE
         N1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=DjFIuxxQw1K5vrm8+HOU6tM/NKkw3T04LZdVPQGM3Vk=;
        b=TykQJhKB1C/91YUHNzS1t3DrL6lR29tbONF/lL/iu2PR5yLU+ZaTLmzWXdwp5VMWb3
         GdhGG50fCHdS5zbq5Xjxm7GwYF2+SEVk8fFr9YSmrpWntGM9Ijt7lJnkINwjLfGH3qk8
         gJTXNVS6NbhfrEFg9ylAEZIbfFN+UxBSXQcGgcLoAnJyHDx1QB4OzvcZ9l49fbJGJsrl
         DgySD/CTOIc2iixkQfhsPhVYibAJeiD9ycir4QvfZx3ZGDFrYJl1DQ+7d9TC4eiE5LQo
         swoRZ2oV9gqsVlefSD46UCcn9IFE7IaZ4gF3I1m8N9JKlOcIsf8vQ/DoiHyThDjYNTm4
         Ddjg==
X-Gm-Message-State: AOAM532T2fL5df7aP1qUaMQ/BARVepiWnQOOPObbyUFg/kCbjo18WcjI
        HEr5Ig0l6WnTaUbiyJthUhNqPa9zmcM=
X-Google-Smtp-Source: ABdhPJyvto++zHT7FNmelxXJz5NC960kSfgvlaKSdx13OX93gJ3P1MenwZMhm5Vtuqiip6DcKOl91g==
X-Received: by 2002:a05:6e02:6d2:: with SMTP id p18mr2460017ils.41.1606993574395;
        Thu, 03 Dec 2020 03:06:14 -0800 (PST)
Received: from [172.17.0.2] ([13.82.53.235])
        by smtp.gmail.com with ESMTPSA id q9sm519335iob.18.2020.12.03.03.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 03:06:13 -0800 (PST)
Message-ID: <5fc8c6a5.1c69fb81.20003.1965@mx.google.com>
Date:   Thu, 03 Dec 2020 03:06:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6870626532693024698=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: MSFT offloading support for advertisement monitor
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201203182903.v1.1.I92d2e2a87419730d60136680cbe27636baf94b15@changeid>
References: <20201203182903.v1.1.I92d2e2a87419730d60136680cbe27636baf94b15@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6870626532693024698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=395361

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============6870626532693024698==--
