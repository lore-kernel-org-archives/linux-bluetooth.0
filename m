Return-Path: <SRS0=oW7/=7N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0833C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 31 May 2020 05:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD4572070B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 31 May 2020 05:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhpOskFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgEaFIY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 31 May 2020 01:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgEaFIX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 31 May 2020 01:08:23 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B3BC05BD43
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2020 22:08:23 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g28so5425990qkl.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2020 22:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/x8nYvAaPSL3XCmiL2kwH0Mic4EeC53mssndxnU3kM8=;
        b=ZhpOskFR05vybXPDcOCOnNPltwOlCUP7Gt62lPGPyOvUWQVNihsCl9UtVrnI/EKt7N
         1QvrPwCgVlcRiiYU6xoF8bzYA3uvnDTM7CbRTLWU+w5n5MeG579C+vWHhIjJBkHbSKIT
         Cbo4VtdL8AbAFuhLeveFC6kNKW2X//rJBVHbZilEABr2nbcH/3hHuV7luuJLC4pCPsE+
         1UgGsUE5TH98KV8hFwE+UeJWyPZdrN3B3auVtuyKcG5oCE/uH5JpfdZpQ3mJ1EMIY0Kw
         J+R52gTibuN/rOekAAGZ+ksriKJhW6UBzXijgxnHBVgIUD5MdsDjfCtzEAGs7vwSehXj
         evnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/x8nYvAaPSL3XCmiL2kwH0Mic4EeC53mssndxnU3kM8=;
        b=YXWzy/pEYJGEjzzshWxpT5pWTwqslWQoXznOTycJqEx/PLoFQtlGhQVuiNxihvtg7Q
         NQtfHFY5qlAf0qnX+n+XBPJCbT5u1PtKF4Cw9q2JvQ75BerfGHZCZPg7hOx8V92R5+l7
         CBYW+70HekKI8YF8UWv57fUli/lirSv0fuvSwCbhdfphRz/YfgGZ2s8Xy2YiJI+Ua2HM
         OcWnnvbjBpDbncblJ+Jvh+G0hFFfQoW7UhpYUaKufpbRUWA0Ob7OcVYmoUjevMkzFgRA
         C4a/YgKsww++3q1HbQtpa/obIUTdxR7cG7UdtRdH6EYiD5tB3e7DfDzOoZl6k4ErwITd
         iWPA==
X-Gm-Message-State: AOAM533h52CKn2QwwT0pKbgV7zJ1rUChcFHCOiSDakjtXTcxRMggRn0a
        t4rJoFsHq4z56BSBEOCz4mPd29VvmWA=
X-Google-Smtp-Source: ABdhPJzE7Xcl1HdiN8oUog+l4MSnjL2ORynj1XX4oUjs7MDuzcy348y5QJYBjbLNqnSRRmOdcDD8VA==
X-Received: by 2002:a37:38c:: with SMTP id 134mr12689484qkd.434.1590901702536;
        Sat, 30 May 2020 22:08:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.64.244])
        by smtp.gmail.com with ESMTPSA id d9sm11884978qtq.56.2020.05.30.22.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 22:08:22 -0700 (PDT)
Message-ID: <5ed33bc6.1c69fb81.ad95c.3131@mx.google.com>
Date:   Sat, 30 May 2020 22:08:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8431105606806830260=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ,v2,4/5] mesh: Clean up style in net.c
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200531044128.16734-5-inga.stotland@intel.com>
References: <20200531044128.16734-5-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8431105606806830260==
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

--===============8431105606806830260==--
