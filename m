Return-Path: <SRS0=KHjC=B3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83995C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 20:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5840820758
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 20:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chb7SWs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgHQUu6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgHQUu5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 16:50:57 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCCDC061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 13:50:56 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b14so16303307qkn.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 13:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vLX1btiv+rxQBwdgZfx93NNh+vu/2OGlrmuq4CHtKIY=;
        b=chb7SWs/uEj1ggnGkc6qFw921EX87XdZSdulEemXAzo6Vf2/bh2iVGP0jp+gSCn+yE
         AYKkA0uOErhz3Es3uhXGklrukrje5UD2j2Qgi51ffrzdu983L5+8zuV1BL05p7tfDGRU
         3rmuixoJpx/NMUoOVSlRKQRtf3395jy2XG7ZaJUs34f5B2y5YWkCVBpkmVAmDI0/2eL8
         FPSl6mUo/SeClM3UG8YsTBdrtVJ9vzWH/tFLDAfmfDfSWrHimqRdXpGsnf0ee61ru4A3
         6N5LS3t/HKoIq5sZ3T3nwPnXbYUYyD+nkME710CkP+dHXXv6BWrtZqWQlM8sud6TqfDE
         9H9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vLX1btiv+rxQBwdgZfx93NNh+vu/2OGlrmuq4CHtKIY=;
        b=ejQHtNUiNZ+qFuGKxbsAuQDl8fIRPY8yIup/PidvNp+d+PqUOeVRGGJUteZxNtYa2A
         kCRyyPS441StuOEMxOM03tuD+14QwVqe7pZsFdcMmcxHB3qhGo8t2UFAegpnlbtFFTUd
         1nK2s6SEg788B0D2oMYs11qaK4xOaSgP3/FPjASpPupaH6W1SKXE86IkQG3CFyBESj+i
         0FLTo9zogsd98oLWZgeX+J+LePAsvYMN4vYvR56DwurNCr8dCQ3+LubfJzrhWIn6Ae3q
         2CLq8p82T/27I2gP3Svr8N7TUBmZ7W3Snju6s1dEN/+iXEPWPLIAm9rSRDrGpsnnwMVU
         pt6Q==
X-Gm-Message-State: AOAM530aIlvhQMDN9AapqKxgvxwuuGQ9p+30taGOsbyvgKkum9F2tW7H
        yLqMnlAR7jBSU3ab/P2a8nyfX4H0eeLuLQ==
X-Google-Smtp-Source: ABdhPJzzR+OimUti16ML2QZulWg6n90/8OQaq4JaOmu72osXS4AztdrgljjEWOk08Q1Fnnc27uULPg==
X-Received: by 2002:a05:620a:24e:: with SMTP id q14mr14545163qkn.482.1597697455281;
        Mon, 17 Aug 2020 13:50:55 -0700 (PDT)
Received: from [172.17.0.2] ([52.242.93.78])
        by smtp.gmail.com with ESMTPSA id 65sm19443678qkf.33.2020.08.17.13.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 13:50:54 -0700 (PDT)
Message-ID: <5f3aedae.1c69fb81.96718.fbe9@mx.google.com>
Date:   Mon, 17 Aug 2020 13:50:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5073655635248183269=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yudiliu@google.com
Subject: RE: [Bluez,v1] adapter- Device needs to be in the temporary state after pairing failure.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200817134133.Bluez.v1.1.I21d21871d85db48b07ba847742c7cb933024307c@changeid>
References: <20200817134133.Bluez.v1.1.I21d21871d85db48b07ba847742c7cb933024307c@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5073655635248183269==
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
1: T1 Title exceeds max length (73>72): "adapter- Device needs to be in the temporary state after pairing failure."
1: T3 Title has trailing punctuation (.): "adapter- Device needs to be in the temporary state after pairing failure."



---
Regards,
Linux Bluetooth

--===============5073655635248183269==--
