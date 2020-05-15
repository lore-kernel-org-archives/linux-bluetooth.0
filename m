Return-Path: <SRS0=w0Ns=65=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6810C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 May 2020 06:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B374C20728
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 May 2020 06:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTpAoYTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgEOGgg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 May 2020 02:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726269AbgEOGgg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 May 2020 02:36:36 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2DEC061A0C
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2020 23:36:35 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id j2so1058518qtr.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2020 23:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=t/lOvpiSs4nt3XNuhjrFA3BNnzoVE4Lslo/8dfZMtHA=;
        b=BTpAoYTUqWR4WTgf86zLHwRU/DzcZJa3xRRZhmTMkWNKfvv9foj/hVf5DFkMoru+Ck
         6FR0JCla3slH38PUfbHJJqaH7T/PxYDdmglLLQ2OjOQUL9Jsea6fXFk8joN8xFsr/Qmn
         tRa8zLHXMWYFYpfvI0VqfrANufrjXWUnFnJ6IGrLtoxhyL7Gx9DrNRemFJqNDuT1N3Xu
         07hDmpixayqx7iTJZsGDF0noEb7/ldIj9IPXHNvsKWvvDU3PC6PiysrPhNtRBbAFbZRi
         ci1T/aRo+5k+1Hjx+LECDklPjxpe41I++QvSQijP+XfZ+4Aq/HiDDJ+lJ9qMvkBo/fHy
         Udow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=t/lOvpiSs4nt3XNuhjrFA3BNnzoVE4Lslo/8dfZMtHA=;
        b=anxxG+ZK0I0ebxb6juBbdEzB9plXttOexxJaKyZBLPF3o7yGtZwVjvzTNJRSXrLxHP
         o5LoJrk4uv9OD3DI+NOV7BSGQxsU8tQCfJ86sa2Zm3FGdL1ymN5YWA4x11YgfkbrkPvh
         wgCarrMjY6I7U/bus+xQYJc115x6Ze14EyKK2zApfhcMTcjymRArXXr7SOYkKwaGyEza
         YHwFRbRDY4v3CpmCzhHcEXHf2Q4gCPoJG9oUlaZetS90k7oXgXbRtDvxBWvV5rquOpBS
         j5Nyf6dhTusPtQqm4OpPe/tkhr0kY6zFAwYBDiFs3x0/WmIxHIdxMai4QzxDa1suL+aW
         1AxQ==
X-Gm-Message-State: AOAM532sy16H63BBgpJnPW6rPCzzZL7Z1nph5LNA982TmlN06kUkd4Jl
        eHQm8RnjpRqVoJaE8W5MA3eOGand
X-Google-Smtp-Source: ABdhPJy+/H09IhoXkaWCDUM4W2e1Ry4q9Lq07lNY2Nk8c1viBatPLPPkq+T8VD+wNcvzylR1jNYeHQ==
X-Received: by 2002:ac8:7496:: with SMTP id v22mr1938497qtq.348.1589524594979;
        Thu, 14 May 2020 23:36:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.124.247])
        by smtp.gmail.com with ESMTPSA id h9sm1150434qtu.28.2020.05.14.23.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 23:36:34 -0700 (PDT)
Message-ID: <5ebe3872.1c69fb81.2c3bf.6d26@mx.google.com>
Date:   Thu, 14 May 2020 23:36:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3935328447011842391=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] mesh: Fix segfault caused by re-enabling of HCI controller
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200515061530.4983-1-inga.stotland@intel.com>
References: <20200515061530.4983-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3935328447011842391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
11: B1 Line exceeds max length (109>80): "0x00005618e6e12d9a in io_ready_callback (user_data=0x5618e75538a0, result=<optimized out>) at mesh/mesh.c:174"
12: B1 Line exceeds max length (125>80): "0x00005618e6e3d2c8 in l_queue_foreach (queue=<optimized out>, function=0x5618e6e158e0 <process_read_info_req>, user_data=0x0)"
14: B1 Line exceeds max length (118>80): "0x00005618e6e37927 in request_complete (mgmt=mgmt@entry=0x5618e754ad50, status=<optimized out>, opcode=opcode@entry=4,"
15: B1 Line exceeds max length (96>80): "    index=index@entry=0, length=length@entry=280, param=0x5618e754b389) at src/shared/mgmt.c:261"



---
Regards,
Linux Bluetooth

--===============3935328447011842391==--
