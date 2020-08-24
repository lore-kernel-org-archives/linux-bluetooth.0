Return-Path: <SRS0=dZ4y=CC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFC7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 18:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC462224D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 18:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZECzesz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHXS23 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgHXS2U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Aug 2020 14:28:20 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83285C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2020 11:28:19 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id p36so3566000qtd.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2020 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ainMyn8m3YK8zwPvZsPC0ZPkL95Kkd6EhZksjdEt2Ek=;
        b=ZECzesz7NKdiGN4Xr7cs8Gk/t8WFnwwjfBnYFMY1MkMN/+YBQGgxkxky0CQxJfXgQl
         N99PrBudeB9mHjeNohAIhltV/n66PKrm5vO1Q7x/DDs5iLdlRyMF+ZCktvT4bA/52eWI
         IQMp3ND3gPGPRpjTkJD2inbyjbwmnAHHRTbyISVI8EyZQg4zU0XhodBq1Ab6BCWKFkXr
         XuPVV51qTV2+U094bAumhFB/kJURgeLal6BoAFhFdSz0YHnE/ppBSGwCza8eR7X0AWsv
         DhTo/Ipx+/ZAq0DT0z9plWhwKQG4PfhcUn07eQlE3ZYq9xLxDrCJmHuXL1RXmNQUyQGc
         hd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ainMyn8m3YK8zwPvZsPC0ZPkL95Kkd6EhZksjdEt2Ek=;
        b=Dc/qSn6bZp6Qk8qWLa7DgBhzeU+X5IvXoJFFD3GA3QfZ7MkeMkI5GcL2ISvFsU1o+4
         ObLAm+B2wSbcdQAciWYbpCRZdI1JEkIxq9pegOUFhw0p5wZoEFPxajuEX2ssEcn951ry
         GwOTMR0NcY9w7bZPs6LREMBFOVLLgRcyEol3iSdvCXbwN7HxmHutFHpy+gm2OHz5rFOa
         J2J5a+IZ23Qsa+3zSkJFOswXxcfSq76PNAoeit3jmv9Ngrt8pjIAIIJUpfABiZKBu4lx
         9sKMmkifOXxShXYZyp0ItbNt7erwXA1Y6VsCnpvsKhhfeKQeuNlWklQ45N7Av3BlyQhN
         orMw==
X-Gm-Message-State: AOAM530jv5NCFjujFBQBDy6Vz0sVjlzmRgxkptWHWDsxZRp7aD+aKHJ1
        1Q++dE3CI+28ubMmETPpgKW4KGzY4OLItA==
X-Google-Smtp-Source: ABdhPJx1HLwI517iqo4BDdj6J6ff8bl9gQZIuJcG95ponWOBlYESBpGFIa/sFZO5ohlnp/wFG3byMw==
X-Received: by 2002:ac8:4d5c:: with SMTP id x28mr6307605qtv.35.1598293698662;
        Mon, 24 Aug 2020 11:28:18 -0700 (PDT)
Received: from [172.17.0.2] ([104.46.193.199])
        by smtp.gmail.com with ESMTPSA id q126sm9453421qkb.75.2020.08.24.11.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 11:28:17 -0700 (PDT)
Message-ID: <5f4406c1.1c69fb81.f8450.9888@mx.google.com>
Date:   Mon, 24 Aug 2020 11:28:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8288428430018806918=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yudiliu@google.com
Subject: RE: [Bluez,v3] adapter - Device needs to be in the temporary state after pairing failure
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200824111837.Bluez.v3.1.I21d21871d85db48b07ba847742c7cb933024307c@changeid>
References: <20200824111837.Bluez.v3.1.I21d21871d85db48b07ba847742c7cb933024307c@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8288428430018806918==
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
1: T1 Title exceeds max length (73>72): "adapter - Device needs to be in the temporary state after pairing failure"



---
Regards,
Linux Bluetooth

--===============8288428430018806918==--
