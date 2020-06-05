Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A843C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 00:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E1E82065C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 00:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRZ4HdqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgFEAMu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgFEAMu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 20:12:50 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46788C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2020 17:12:49 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id b27so8161806qka.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2020 17:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hc1osGXZBqZMEbdtS21QOC2f6qIo9WDKdYyGEqk70po=;
        b=iRZ4HdqI11HXeMd0erG/NMBxzXFhMtIiUaifVb+X+bf89NG9TxnRnbgbcdShqAzokX
         zi3a5jETB7l9bntyN2/EgkXmqNGbNJJB9ogRdQhTkyanjXXAbKO0V7JFgQk9D8Y/AE0h
         2o94MgIeKB7Sj6i203mpLOj692Y6//RlTgE7my5fB+cLM9JjMtpouX3skxSs7KlIYfcm
         mqSQH6wa5Uy/VmouYsVlw1EsNTRSLdajNUyGYZjlkpY/dTqn+829gJYF7xYCKz03I2xR
         I0fJqM6/3saoE2SFAPBNfW5dkq7wJy9duvKtBIruAWxDdzWiPpd0cK+p3lqHK3Xgk4Sz
         PfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hc1osGXZBqZMEbdtS21QOC2f6qIo9WDKdYyGEqk70po=;
        b=fdhp4SG7TCaI8TNiGj1iUBmGlfabiEWlGpKRSFdZ/NoQbON/kHZTenST6iLUsiCHHd
         Ft7mSOWz6j3tmVkcEP8mv8tt8pTt1KqKcB2Ug4YiRqyTob2hrr77ObB5XfGZqQ4YNTeD
         Ezx8kusaLTExuB+CuB81xOdJ6VfLixzfdoZQIS+ftMkOTKiHe03o84d+zYV+hBcoypc9
         Herg8qtAu2nuZTpOe+odoFmva0pvX7eTzbzg4LikhvXNem23qKNftT8PLEhdKd7Tw/6i
         XDky9GubTJTYYCycQ8QU1P0vdZLrSSxAhDKPe67qrh4uU+qHg+SP8MoRA6goumuEPeTC
         xyCA==
X-Gm-Message-State: AOAM533k6yaJ3XICRjoMv8ZoqrlgUHg/8M2EsrHh8w/p9D3FbVhiTzUu
        MX8rzCMcI4vvhu1Hknvr55H07ehgtmw=
X-Google-Smtp-Source: ABdhPJwPrD4izc7MgpscvBXLPxRr9X1kEIW3IEAtLibv+PejOpkx3WuzcGGVotBSd9EyiWX2WDTeag==
X-Received: by 2002:a05:620a:14b6:: with SMTP id x22mr7137616qkj.448.1591315968462;
        Thu, 04 Jun 2020 17:12:48 -0700 (PDT)
Received: from [172.17.0.2] ([52.138.85.28])
        by smtp.gmail.com with ESMTPSA id d14sm6113085qtr.17.2020.06.04.17.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 17:12:48 -0700 (PDT)
Message-ID: <5ed98e00.1c69fb81.34673.28af@mx.google.com>
Date:   Thu, 04 Jun 2020 17:12:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8324068411868692985=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pali@kernel.org
Subject: RE: sap: Improve error messages
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200604232433.4951-1-pali@kernel.org>
References: <20200604232433.4951-1-pali@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8324068411868692985==
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
5: B1 Line exceeds max length (96>80): "bluetoothd[19117]: profiles/sap/server.c:sap_server_register() Sap driver initialization failed."



---
Regards,
Linux Bluetooth

--===============8324068411868692985==--
