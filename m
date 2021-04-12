Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA03FC433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 21:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B5961369
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 21:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbhDLVjT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbhDLVjS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Apr 2021 17:39:18 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63048C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Apr 2021 14:39:00 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id t17-20020a9d77510000b0290287a5143b41so2993705otl.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Apr 2021 14:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5HyXMPiMkrFFomW/9ASiPlnrj7LycEQTHpDQTsv/Ke4=;
        b=eOw+vAzJMexnrKAahhfeMDDZtf+zJtuIC56HBN/njzjlG0HmBut23YhP/OJOz0Qj6C
         z104uQriscjmpsZUjNwbfeGpMdK65H/TOFWNeaaVVPaqfOLX7JEYb1jbf6WMwH2pD30j
         u+VMwROIBMEoQI64KQeELAJRwkpoSwOWGuzkthCe8BOQfCAOBDCobjQGSLjzC0X3mIwV
         66ighzZ5wehUy5Vi4FOu1L8JYbCpckUAwqMJ/Yo+mRw9+y8HXLHXQT63cgUjBXGNQBEc
         5lLe+qDzdzm0PBaM+0ldEK1gGIfIfVgpN8PBpz5cjqmp9J2Kn3z1U6LrmPJJpvjNUpH6
         DN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5HyXMPiMkrFFomW/9ASiPlnrj7LycEQTHpDQTsv/Ke4=;
        b=J20xhClwo4BM/FixID2sQTFc4eFSudTXYERD+ecLrEnUWSJEspW9ASfqh0X/qy5Cm4
         GkyP2oO4j93z42fS1P/g9aNqwODJm/14QpbQ0lRnz5Py+lGVQEErIHBCGVrDPkdFvpae
         NTeOlE42PXz1HqGNlmx8EBzUWVmsNBJTb6CBlAqry9G9+JknVZ63uturANWWuGVLmDJr
         lEOpnMzhSNIzNbxiLj17jBCD91mhfFzpVj+JysdB21K8sLOyLU6Oqs+pF+52Q5vRC0DN
         LKllGrmXP/ulXIZcJBMb8eOr6kNuUHKW1FmiYs1K317g/FTJFhYZGdE/V5x0PK2q31lr
         XB1w==
X-Gm-Message-State: AOAM531ONNVhn1K+xhWPTdhY4fEl7x4xd/YfCjItNTWfIjzyCCsZDVq+
        xfIjYkqrOVOllqSAfSvTcQNkUfGB0HX/OwDJbWDsDXXUSbb0hg==
X-Google-Smtp-Source: ABdhPJz3jYK7z6StHxsIHapNVvDtQScxzht6Fs7srirq1iHkSyftgE2mHlXbkjr2qcxT0klOet5jFWn+PPQ/D1hO1XQ=
X-Received: by 2002:a9d:63d0:: with SMTP id e16mr10152064otl.44.1618263539339;
 Mon, 12 Apr 2021 14:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210412184033.2504931-1-luiz.dentz@gmail.com> <6074a15f.1c69fb81.778c7.5299@mx.google.com>
In-Reply-To: <6074a15f.1c69fb81.778c7.5299@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 12 Apr 2021 14:38:48 -0700
Message-ID: <CABBYNZJb8-M6cXNsFhOrsXESkz5zuLZ-Oepg2_2onbVfnt1rWw@mail.gmail.com>
Subject: Re: [RFC,1/2] Bluetooth: Introduce bt_skb_pull
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Apr 12, 2021 at 12:37 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=465841
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
>
> ##############################
> Test: CheckGitLint - PASS
>
>
> ##############################
> Test: CheckBuildK - PASS
>
>
> ##############################
> Test: CheckTestRunner: Setup - PASS
>
>
> ##############################
> Test: CheckTestRunner: l2cap-tester - PASS
> Total: 40, Passed: 34 (85.0%), Failed: 0, Not Run: 6
>
> ##############################
> Test: CheckTestRunner: bnep-tester - PASS
> Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: CheckTestRunner: mgmt-tester - PASS
> Total: 416, Passed: 402 (96.6%), Failed: 0, Not Run: 14
>
> ##############################
> Test: CheckTestRunner: rfcomm-tester - PASS
> Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: CheckTestRunner: sco-tester - PASS
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: CheckTestRunner: smp-tester - PASS
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: CheckTestRunner: userchan-tester - PASS
> Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
>
>
>
> ---
> Regards,
> Linux Bluetooth

This should fix issues found by szybot like:

[syzbot] KMSAN: uninit-value in hci_event_packet


-- 
Luiz Augusto von Dentz
