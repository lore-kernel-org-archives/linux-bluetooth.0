Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1871CC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C300564E6B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhBWTiM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhBWTiH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 14:38:07 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B424C061786
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 11:37:27 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 81so17425313qkf.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 11:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=krx8fJp5H+zjQFazQl5rU/f/F7S2ACQJVtB86et92rk=;
        b=EcSBmj012CoP1n3xfgERKcv51ir8mZoZr/xdJGXWXcIlIVPd+e3yIxUp4HlVS0iZDb
         Zgzav5F+clg35ILDzL7ompFmVnFH2PmdDGwnpBNlLYVrDJmxYBVyoLGcOomxC/+hgGSj
         9odyQQpLJ7vnzmAkk85fYS5+egaLzcfm7cYXYs8cN997+wRgQhzUVKGxk3ytP19BajHP
         8jLpwfWvrUAAyqoYOK66k+NerdRPzRrl0ZlDoTdaUo8iGRXfsPDk0QM+qGWDoSKZ7Flt
         RpVFUOf0d6S7cgOLPLOKvbqgQLzDF9YDXALCi/oEFoQTLCzc/lfQGOzdmIaRjHoAjG9n
         Kmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=krx8fJp5H+zjQFazQl5rU/f/F7S2ACQJVtB86et92rk=;
        b=S6bqQZN+WT26dFhlCXbmDDd6R0KTGEhHtVZY+XaAryPU2ArMJO1Jun/czo5gJRQN9r
         yiDEs2y7ItBPt6Bc1/7+yFNUOZvHn994DDwByjW6YOtRycNW1Knuuob2wiGXKxZ5ljSz
         i4XXU31O6E8+MgBzqSMGHNGy6+IaIxiDcdOF0yNnD9MHaqQ/neTClESe1Fe4khWl//UQ
         R4AmA6UWiPWSsfoQN51zEw/H/XRZMETlmI1WLU4zw4A/eSMH7lHBQ3Bwu3Ekjhv4dxye
         Cs+kfS02fUTw+phn+YkFz7AvxXkWDuVAYO5QUlDNcdI/S/jLgwonxagz6Vz3gSmgAub6
         VYKw==
X-Gm-Message-State: AOAM533RcPrPVIiaJS7QyldD3UPpyFAYhf1X6cwj0dA5ANvfXSb+IJlb
        1MiU6rT3B/zE81mJyaQPzamebkyO1b7onQ==
X-Google-Smtp-Source: ABdhPJwAi8V0VIJkG5LApcb1WxgPqrTC0r5kDIe62RrDxEtvsY7IvkSHrYCxInTn51VHm2N/2Ln7SA==
X-Received: by 2002:a37:48d2:: with SMTP id v201mr824853qka.235.1614109046224;
        Tue, 23 Feb 2021 11:37:26 -0800 (PST)
Received: from [172.17.0.2] ([20.36.214.54])
        by smtp.gmail.com with ESMTPSA id h5sm13678564qti.22.2021.02.23.11.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 11:37:25 -0800 (PST)
Message-ID: <60355975.1c69fb81.5cce9.329d@mx.google.com>
Date:   Tue, 23 Feb 2021 11:37:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7805472787277430334=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Cleanup: replace symbolic file permissions
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210223190252.483784-2-brian.gix@intel.com>
References: <20210223190252.483784-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7805472787277430334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=437329

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
mesh: Cleanup deprecated symbolic file permissions
3: B6 Body message is missing

obexd: Cleanup deprecated symbolic file permissions
3: B6 Body message is missing

peripheral: Cleanup deprecated symbolic file permissions
3: B6 Body message is missing

profiles: Cleanup deprecated symbolic file permissions
3: B6 Body message is missing

src: Cleanup deprecated symbolic file permissions
3: B6 Body message is missing

tools: Cleanup deprecated symbolic file permissions
3: B6 Body message is missing


##############################
Test: CheckBuild - FAIL
Output:
configure.ac:21: installing './compile'
configure.ac:33: installing './config.guess'
configure.ac:33: installing './config.sub'
configure.ac:5: installing './install-sh'
configure.ac:5: installing './missing'
Makefile.am: installing './depcomp'
parallel-tests: installing './test-driver'
configure: error: Embedded Linux library >= 0.37 is required


##############################
Test: MakeCheck - SKIPPED
Output:
checkbuild not success



---
Regards,
Linux Bluetooth


--===============7805472787277430334==--
