Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967C5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Oct 2021 17:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD5060E54
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Oct 2021 17:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJJRjb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 10 Oct 2021 13:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhJJRja (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 10 Oct 2021 13:39:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA52C061570
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Oct 2021 10:37:32 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso9239050pjb.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Oct 2021 10:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=mSsMkH4yp2hRryNISiYuuRjffeySDwYhoXS1/xMcCi4=;
        b=KbKXGDY9GJGsgKQNDLy5A329PSuwPGUOYSIVf+LS8cOokOh8IF1FWVVupg0h+enCfN
         sxeu1WI+LdWBqE2wk/63cf/z4Gc48LODSZQH2YlW6LycIV40ivFZIhfqscnjdSxziJIw
         pCpN+cxNu3T811XGHsvTjYQt+RR6Gr1mUAkVc+6p7jLGBzzIkpUHqIjfIl1YziWROoWY
         ux8jGvYWZPR35az/TkeuVA1I9xpNj6O12NpBup+auYU0aUmELg+GHu+HQAqcoJcGrZMT
         pUpn05iDwVc1p4uocJJLcIOMoUsf91bR6PEoQvwFsb5VPNBPNIqzVBLJCN/7c4S7hb/V
         0mPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=mSsMkH4yp2hRryNISiYuuRjffeySDwYhoXS1/xMcCi4=;
        b=daeSGOf3VpcBOiQiPDtpwOr/L7xahvhaUghh1ZPFSiQ8n2Tregw2SdRn63POWzz4UB
         fwYtrW/4Qf4ePatC2BYORbOdOsS+nhtRqZJLa1AOlS8wIwEbmhFhE/Y8PSp6dpSuT1jq
         1qHSNvx/v6x19toLNSi3qa92TbluzawGDon4XtavZ/Yz19eF1/L8Q6hbmyi05SEaAPTl
         jOkQkUMgZTNsmjasaPAMSin+EYHu7K3Gk7YEj37IfcOuJxvaWvgfVMCau7ANjFV6SAVm
         49E44CEJGElP+Q/hcxp/3Vvi2XFRTxlgkfcSdrcQkjDHXyf9ZFiZub/UERDCAzgdYMW/
         wYRA==
X-Gm-Message-State: AOAM53305+XUmvU5JIMS9o4hev9OILu2dUW/Yt8wPigWtNIcYHIH7rn7
        ngRoJsyzzgRdFQK7DCLtLxYtEUIqRx8=
X-Google-Smtp-Source: ABdhPJzL7S5s0cyU34k49UQu7sSeiylEvvdnAnIby9DZrDIRRpQYr4uRHm9+sRLzUAMJoRL9uZMPzw==
X-Received: by 2002:a17:902:d483:b0:13f:342d:ec92 with SMTP id c3-20020a170902d48300b0013f342dec92mr2778088plg.67.1633887451426;
        Sun, 10 Oct 2021 10:37:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.112.97.94])
        by smtp.gmail.com with ESMTPSA id u74sm5214560pfc.87.2021.10.10.10.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 10:37:31 -0700 (PDT)
Message-ID: <616324db.1c69fb81.8c8e3.e43e@mx.google.com>
Date:   Sun, 10 Oct 2021 10:37:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2356565247040944378=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] avrcp: keep track of last volume, and use as transport init_volume
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211010171447.35355-1-pav@iki.fi>
References: <20211010171447.35355-1-pav@iki.fi>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2356565247040944378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=560715

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.31 seconds
Prep - Setup ELL              PASS      47.59 seconds
Build - Prep                  PASS      0.24 seconds
Build - Configure             PASS      8.61 seconds
Build - Make                  PASS      206.06 seconds
Make Check                    PASS      9.62 seconds
Make Distcheck                PASS      240.06 seconds
Build w/ext ELL - Configure   PASS      8.40 seconds
Build w/ext ELL - Make        PASS      188.57 seconds



---
Regards,
Linux Bluetooth


--===============2356565247040944378==--
