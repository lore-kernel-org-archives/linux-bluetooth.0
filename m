Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6A4C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D84720776
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqrUjFnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgE2Pgy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 11:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgE2Pgx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 11:36:53 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6C2C03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:36:53 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id n11so2546435qkn.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Gx6HvrWoE7pRKmE5JTF038IgoECxUdX8+w1cOIC7VS8=;
        b=LqrUjFnYl3XLqLSrfDKDpEP9TXq6eOAHheuk39h4BelccULY5eidV+GDajE5Te0ffy
         EmINuO0g/Two7spYIesELsN6VNPuCkiuIOfsaliXZTpE9dcknKFuCrjw33VhDganLVQj
         PRdiNC6KiVO6+OKVi2JXt9omH47SjQnmzrk1L2Gadj2CLijFoQ9RRDCEWBH/sHTF6v+k
         VMsJGbtmx5704lGl7EGwNcuZpRjoG19VY1oTz1OXweg3lrEyhmrhT17xUwfjTH9I6gqR
         cEbuINx1g2kjdYbE+Ba0Ejt7jbKzS/oaik5ylxHzLnkPVD0aVL9x1/4153ri6aIdCE5C
         GKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Gx6HvrWoE7pRKmE5JTF038IgoECxUdX8+w1cOIC7VS8=;
        b=CNg8OX9ae8g324JDwzZCnx6R+ymQdUPCMd+xfqU3OcHw5ti+3Pi1enrZuBUEdTzNjF
         XQMRwxMD28QsuTvnxUFa8vZthSVfKdpDuQG3TvQ03ENCMoASPP5+ReWqoB5Cp+hKuDC3
         BFtRrD9XWdCyVY6kLNnTjFGgNNr4gkZRBHFL1GLDSqrqJwbIdtvHMqfanbcK6Nxdt2vi
         d1i7T9BBpC9bQQeXE3Zqdxfm24evBgPM9R33P27u+gw4tTj0c7Qrl66azt1ynxAMNlLZ
         i6pcTJW+liRcWF2FRWWqvoIMN+B2yvQ3GOVqsG3tI4Atc08lalt1qymSp/lNz2IN3ysW
         rZ1Q==
X-Gm-Message-State: AOAM5313yqcvicMgV/GlwuE0k0KDL/dNsdrHljDKtzx4dYW/fERTqlEO
        Tar19pGZPwxjbmj+cCamn0Jk2r0UES4=
X-Google-Smtp-Source: ABdhPJzE25AlOQ8Uozntk42T3zElHr6eNj95iSd88k3pPAvn2Ih1SRhO4t0jqpTTMSPC54WF+PNkoA==
X-Received: by 2002:a37:4e54:: with SMTP id c81mr8109822qkb.46.1590766612722;
        Fri, 29 May 2020 08:36:52 -0700 (PDT)
Received: from [172.17.0.2] ([13.90.47.33])
        by smtp.gmail.com with ESMTPSA id r57sm314396qtr.41.2020.05.29.08.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 08:36:52 -0700 (PDT)
Message-ID: <5ed12c14.1c69fb81.1b9cb.22bb@mx.google.com>
Date:   Fri, 29 May 2020 08:36:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0427218059280182854=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, alainm@chromium.org
Subject: RE: [BlueZ,v2,3/3] main:read default system configuration from the conf file.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200529152940.208214-4-alainm@chromium.org>
References: <20200529152940.208214-4-alainm@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0427218059280182854==
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
1: T3 Title has trailing punctuation (.): "main:read default system configuration from the conf file."



---
Regards,
Linux Bluetooth

--===============0427218059280182854==--
