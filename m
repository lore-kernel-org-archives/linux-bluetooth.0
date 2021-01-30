Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9E3C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jan 2021 00:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D90F64E11
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jan 2021 00:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhA3AGe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jan 2021 19:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhA3AGe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jan 2021 19:06:34 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B50C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 16:05:53 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id e15so8037756qte.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 16:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=AH4r/i1jgafN8Pcd5ZZWBVcEazOe5deC1Gzub2RkyC0=;
        b=YqVGRtvj3C+QA0e39aaZ61jSsv8TLi71j/DaSIeGcOumw7ypdB9iuG4mYtTLW5zkyJ
         cW81kRn0Yhwr1EZpEfyd17FpPkwnd4yUEy1Z0OnFxD0kMXW/+2NmH8IqfrCmc/vv0cX6
         22RI1gLgDTMAf8ObxyqqyYQm1yAsOpbftCvrkDC3BaM4FoRRo+uHWwzpXhCuxgYD1AAA
         MM3kGkm0kK45PLd1FC2W+cRg4N6LnVQMOh3JFAreWbY8RPeS04bw/UtHlZv25pe/njfu
         u9qmB0hNMwitVgcm85rOC4MlvsopPoXK4sfk+PERXNCwj68s49whUhBv/6uRc1pdl3PR
         UHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=AH4r/i1jgafN8Pcd5ZZWBVcEazOe5deC1Gzub2RkyC0=;
        b=D9A5q7CV9qZPsFZitbJsezizNo9WXhg7jggjKxW/AiuQGfKesbHslSJR1CsopBvWCB
         FGMLSTpOVlV33CDf9SnWe8JI0wn7uKrfqsoIY3FkU91wzF9++xE7+EbS9VrPO6F8u1Z+
         /fu03hRs0QHhGlFNrErwP0hiiIPl1nMp7n8djsJgOKwyN5WXJFpE87beHk04d0+uIKfi
         1yM3sQlf1nG2s9iPPA8yV0wo6V+WYdv9nHRPoQEDwyKQziRDgYKK+sICe5aKmWIjmp/f
         ptU6dt46P8Sc2CsQwr6O/jBV4J+9a+INxgU8d0jeCEXY5LAxowA5BKmJu1ZEgTAbll1P
         xWpA==
X-Gm-Message-State: AOAM530sDqjbKdbDxxag4/KaHcoq/D8/uqBZEJEbAf5qKTZ/Wg7s4giI
        FgvUm4ScdoUCfpNn6E2eANjaY+feIDY=
X-Google-Smtp-Source: ABdhPJyQol/j1E6siY6/cN3VBsFwKF3OETnw6UX3J84gdu0K5qCKk6/E/fozWcN4Sbi9zyC23ojcHg==
X-Received: by 2002:ac8:6c26:: with SMTP id k6mr6549685qtu.319.1611965152951;
        Fri, 29 Jan 2021 16:05:52 -0800 (PST)
Received: from [172.17.0.2] ([52.179.215.115])
        by smtp.gmail.com with ESMTPSA id y135sm7699575qkb.14.2021.01.29.16.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 16:05:52 -0800 (PST)
Message-ID: <6014a2e0.1c69fb81.19233.ea83@mx.google.com>
Date:   Fri, 29 Jan 2021 16:05:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6927994453088152731=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,1/2] tools/bluemoon: Display FW version of firmware file
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210129235017.89788-1-hj.tedd.an@gmail.com>
References: <20210129235017.89788-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6927994453088152731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=424641

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


--===============6927994453088152731==--
