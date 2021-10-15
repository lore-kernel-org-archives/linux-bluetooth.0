Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCFCC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 23:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168FD61247
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 23:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhJOXkY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Oct 2021 19:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbhJOXkX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Oct 2021 19:40:23 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B927BC061570
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Oct 2021 16:38:16 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id n12so6682615qvk.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Oct 2021 16:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pdkZGHIKMgc+JDnLvhpYpPPWy3AeDrzhajro44q5104=;
        b=bhFSVqHXRKQSXqKE3YihS+cJxLVRUXDi3GOqYAlUjSRa/bICHuvLssJ/vYKDDMysWm
         5ewCECrDm506rzEgB1ZBKFxiS0K/goShxpJkVvwqyGAqd0l+xjbX98IO0P055do6AwE7
         57asBJ5beoETkHVJpZj+mTKV8c8FjZ3CkFUFd7vDSuH5VK/k3uZYLm//6FvUNGT+Bw7k
         YRzMTib1kI8j4qhwCpeAdx+4HwAMQA7vQEuY6DcKs1NgdTNbxZfc3mU+IViwB3uJ00bd
         0tHqftufpTpl2P6LAMcefQ2rVdaiVJ+ym8nqqydVeE74rlv/pYVFhyL0+tFyGWyv/Bnh
         woeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pdkZGHIKMgc+JDnLvhpYpPPWy3AeDrzhajro44q5104=;
        b=natSwSH3LoqxgukRdFccN42YI286uB41+VeGfwhNThTbdsdp9M41RqMhD5PysQbzfI
         fVj4t4cOPjcTIjyitG2BJ3xQv+pJM8uOCUWQE/AbCb7lRnSeZhIsp3mwl+oAsQaopat4
         PEPpgtqi5qP8NZt0NrA/QU0va3xvUSHVjga5FXMuBzeGV+IotX13xdrikyAA3lkVvlTP
         gS6hNmk7lTYen1yQ0sgVIZCoJqeEUBb3VEYLDE1knVUD3iaFBGSFx7+eiVC4crlEY17N
         mw3czdy7IBtoZMxZWICWg+la4j6v7dzgpEvlH3uM0PKf4AH6DSiQvBz2n65pF0wLrDQ5
         8/9w==
X-Gm-Message-State: AOAM531+vM/taLGMe8nnbs0WYp8cyzo4Xu8W2iQ30JpOQUzI6Um8kvdN
        l5QyJusCyqcvrE05avLclIFgLdesUkNX7w==
X-Google-Smtp-Source: ABdhPJyhtdw0EsxB9onqYC9CYXTDdYbVwlieHkb1GEsKrxnJik7cN0haFVbplwAx5zgni0oqCFD2sQ==
X-Received: by 2002:a05:6214:1754:: with SMTP id dc20mr14061757qvb.17.1634341095489;
        Fri, 15 Oct 2021 16:38:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.184.184.81])
        by smtp.gmail.com with ESMTPSA id z14sm3249966qkb.91.2021.10.15.16.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 16:38:14 -0700 (PDT)
Message-ID: <616a10e6.1c69fb81.b6086.881a@mx.google.com>
Date:   Fri, 15 Oct 2021 16:38:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4195160563555122909=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [RFC,BlueZ,v11,1/4] emulator: Add support to config the accept and resolve list
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211015224242.351166-1-hj.tedd.an@gmail.com>
References: <20211015224242.351166-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4195160563555122909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=564577

---Test result---

Test Summary:
CheckPatch                    PASS      7.49 seconds
GitLint                       PASS      3.81 seconds
Prep - Setup ELL              PASS      48.41 seconds
Build - Prep                  PASS      0.52 seconds
Build - Configure             PASS      8.81 seconds
Build - Make                  PASS      206.42 seconds
Make Check                    PASS      9.52 seconds
Make Distcheck                PASS      257.19 seconds
Build w/ext ELL - Configure   PASS      9.41 seconds
Build w/ext ELL - Make        PASS      205.51 seconds



---
Regards,
Linux Bluetooth


--===============4195160563555122909==--
