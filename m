Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00517C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 23:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B453F20738
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 23:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrwl6qbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbgEVXhF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 May 2020 19:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387433AbgEVXhF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 May 2020 19:37:05 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01ED1C061A0E
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2020 16:37:05 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id er16so5567275qvb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2020 16:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=E9pdszUT68gzJqrZnOX8hsiXhPZ4MKe4CK9d9pIgkrI=;
        b=jrwl6qbg6CZhlJGh75niRzUcllQsw0iI3LONJGvwLiCQ0WUZIq0cM0xT1KCwj8ALel
         oiJLIGc1Z9j4lD5QSyAKXdUhyFikWoBsKQYBc3hi1tb3fmcRggNC5qXvbV0Qpnb1D7F3
         tuimC9upiozocQ5Fl+EdM8637Uo9VXXQHva7umvxSDgN2k1fsbZQdaYCfRonVe7VAyaE
         c0dX1191szMgy/daqqhc1CjRlGcxy9HyAUapjwq1/Y+lOhEk8TpTEney12cXjpk0eISG
         GLblx9x+nayxgoUrELuH0sBp3qw6szKZ4Vgj2WQJd4apDnKxn5njtc/+v2VWrk9KQR6a
         v0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=E9pdszUT68gzJqrZnOX8hsiXhPZ4MKe4CK9d9pIgkrI=;
        b=QxY3qpDhoGSRMYhIZf+gXaGOCTuKVHig3M36o3YLwcYS6C3kK961Inz1JCSe/+6I//
         DqBLk/WHlwWLt/5aEwKU2eey8aM+IlWfwYFCD7AcA3e2hSnQqs3I9IAFFtpMK7VF+syq
         Po/FDrz8JoQjxwgD0WsvI9Dypt3AVIwp/MWOzhXjyOicLg6b6TK7A2Vt2gKXsHQSD3nL
         k+etapt8NMc8jTrjU9fblipFsz319GNvVu1xfiH85LySEh09sE+CLv3cq/aHolr9nYBU
         YcPP+k0gnE3vTBW/odUitIzkDQnvY81SSl9Otsn1trPm+PusWAWH8irTcEiNlP4K5ouY
         h1jw==
X-Gm-Message-State: AOAM533/DMZF/flxGFIKlPo2GTKwyg9ev8/JZ1wJK8Gh5A138J2XpjAo
        so+PI/zQANFiQeCQ6RWRFbs7ZUAmcH8=
X-Google-Smtp-Source: ABdhPJwSUMGswQjAgCH6LILGPveb7S7QV4dmjodxnO/4roH0ckW4BucNCfmciufqe34u9ITb1cYJGg==
X-Received: by 2002:a0c:f214:: with SMTP id h20mr6346873qvk.200.1590190624133;
        Fri, 22 May 2020 16:37:04 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.17.127])
        by smtp.gmail.com with ESMTPSA id n20sm8924511qtk.89.2020.05.22.16.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:37:03 -0700 (PDT)
Message-ID: <5ec8621f.1c69fb81.90ddc.3b18@mx.google.com>
Date:   Fri, 22 May 2020 16:37:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8777908123862468400=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,v2,2/4] mesh: Fix leaked mesh_net allocation
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200522211309.233824-3-brian.gix@intel.com>
References: <20200522211309.233824-3-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8777908123862468400==
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
3: B6 Body message is missing



---
Regards,
Linux Bluetooth

--===============8777908123862468400==--
