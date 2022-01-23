Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94ECC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Jan 2022 14:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiAWOxv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Jan 2022 09:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbiAWOxu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Jan 2022 09:53:50 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4C0C06173B
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Jan 2022 06:53:49 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id a7so17367101qvl.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Jan 2022 06:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hrv3awavkYT/6nv5AnQioqwba6ue1m1OzsBCwGOdpLE=;
        b=H8Ilj400uquq3WDtYaugfyL6AE5ye+TCzFf0VzzM1MgKoRUVvOWLTci1kc78TM03F1
         P3sw7pj0Qng9TspANBGilsDFH7ZhybQGQr0sAA68NKb8S9zTZhD5e6qapJRuhd53hGn9
         xUZE+mlV56O2z5vYYDrqkgQl+DRypqDiOMkAtMyhmMUSjOej2XLezmaOfUPxZTcYl2br
         C+jShSC+9w3zWQD4KKWRCr5F2xd+oDRGIGI8gRkQnqEQ01xU6uSiJlhhwbq4IGCZ+grQ
         TFuTJC66plMpIe+eUnfXdLlTsL0wp9qbYMc9tQp2kyh4Y0Z8Uyd1s1m9G+I77emSExqs
         hNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hrv3awavkYT/6nv5AnQioqwba6ue1m1OzsBCwGOdpLE=;
        b=0udhXAasoaN5eaHCRgixxAGgpUJE12qXGJ386v9rMTpAFdDoOBY5tSSiTJCoQ5gg6E
         Gi8GK7LfnhNy7Sc+SS6ApmGTw5zMeNGFHEyDq3fAT1IZ9v6fxAfmgTbc6FkmkBhwbyEZ
         1y41L6y/YAikk4C9XJujOT90gvCH0N87efzxiA0PLCJ6bu+c2N5TcZPu+SyIFldf1yBm
         VqwESfjaBARd/Bhi5pQLRWniu2PcqKA9oNUVtvkFnibwlzuJsTLP4vgZz+04JLsojDTO
         6Aw950HtScGFhapWfT941QnZ55XHEkGKyhgnNsMCOdwIHCP7QrjSf3LTW060iSv7LRo5
         yAWg==
X-Gm-Message-State: AOAM531ftHZoXyWAPByOIE1IKb+k6lRupmEzBQwlXz2vA7HzaQGRejGl
        edH6wGEtpSK2QS8s55QoF/KmOM9vkSoTXQ==
X-Google-Smtp-Source: ABdhPJy1NPlfCWZ/cMIntky4rkwCtzGI6AWpVqKfsc2T2C9b/n0x4G5H3n8b76Dvdw+UfjBOqguoSw==
X-Received: by 2002:a05:6214:21ef:: with SMTP id p15mr4678249qvj.92.1642949628726;
        Sun, 23 Jan 2022 06:53:48 -0800 (PST)
Received: from [172.17.0.2] ([40.79.36.188])
        by smtp.gmail.com with ESMTPSA id bl17sm5860159qkb.16.2022.01.23.06.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 06:53:48 -0800 (PST)
Message-ID: <61ed6bfc.1c69fb81.81a86.35c1@mx.google.com>
Date:   Sun, 23 Jan 2022 06:53:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0740350910333134077=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, soenke.huster@eknoes.de
Subject: RE: [RFC,v2] Bluetooth: hci_event: Ignore multiple conn complete events
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220123140624.30005-1-soenke.huster@eknoes.de>
References: <20220123140624.30005-1-soenke.huster@eknoes.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0740350910333134077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=607576

---Test result---

Test Summary:
CheckPatch                    PASS      1.90 seconds
GitLint                       FAIL      0.97 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      30.23 seconds
BuildKernel32                 PASS      27.08 seconds
Incremental Build with patchesPASS      36.92 seconds
TestRunner: Setup             PASS      479.12 seconds
TestRunner: l2cap-tester      PASS      13.54 seconds
TestRunner: bnep-tester       PASS      6.05 seconds
TestRunner: mgmt-tester       PASS      104.38 seconds
TestRunner: rfcomm-tester     PASS      7.51 seconds
TestRunner: sco-tester        PASS      7.71 seconds
TestRunner: smp-tester        PASS      7.54 seconds
TestRunner: userchan-tester   PASS      6.37 seconds

Details
##############################
Test: GitLint - FAIL - 0.97 seconds
Run gitlint with rule in .gitlint
[RFC,v2] Bluetooth: hci_event: Ignore multiple conn complete events
16: B2 Line has trailing whitespace: "v2: "




---
Regards,
Linux Bluetooth


--===============0740350910333134077==--
